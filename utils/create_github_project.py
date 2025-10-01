#!/usr/bin/env python3
"""
create_github_project.py
Cria um repositório no GitHub (privado por padrão) e inicializa um projeto local.
Requisitos:
  - Python 3.8+
  - requests (pip install requests)
  - git instalado e funcional
  - GH_TOKEN no ambiente, com escopo:
      * classic token: repo
      * fine-grained: repository: create, contents: read/write (na org, se usar --org)
Uso:
  python utils/create_github_project.py --name myproj
  python utils/create_github_project.py myproj
  python utils/create_github_project.py myproj --public
  python utils/create_github_project.py myproj --org minha-org
  python utils/create_github_project.py myproj --https
"""

from __future__ import annotations

import argparse
import os
import subprocess
import sys
from pathlib import Path
from typing import Optional

import requests


GITHUB_API = "https://api.github.com"


class UserError(Exception):
    pass


def run(cmd: list[str], cwd: Optional[Path] = None) -> None:
    """Executa comando de shell com erro amigável."""
    res = subprocess.run(cmd, cwd=str(cwd) if cwd else None)
    if res.returncode != 0:
        raise UserError(f"Falha ao executar: {' '.join(cmd)} (code={res.returncode})")


def get_token() -> str:
    token = os.getenv("GH_TOKEN")
    if not token:
        raise UserError(
            "GH_TOKEN não encontrado no ambiente. "
            "Ex.: export GH_TOKEN=ghp_xxx (ou use um Fine-grained Token)."
        )
    return token


def create_repo(
    token: str,
    name: str,
    private: bool = True,
    description: str = "",
    org: Optional[str] = None,
    auto_init: bool = False,
) -> dict:
    """Cria repo na conta do usuário (/user/repos) ou em org (/orgs/{org}/repos)."""
    url = f"{GITHUB_API}/user/repos" if not org else f"{GITHUB_API}/orgs/{org}/repos"
    headers = {"Authorization": f"Bearer {token}", "Accept": "application/vnd.github+json"}
    payload = {
        "name": name,
        "description": description,
        "private": private,
        "auto_init": auto_init,  # deixamos False para fazer init local bonito
    }
    r = requests.post(url, headers=headers, json=payload, timeout=30)
    if r.status_code == 422:
        # pode ser "name already exists on this account"
        msg = r.json()
        raise UserError(f"O repositório '{name}' já existe (ou conflito 422): {msg}")
    if r.status_code == 404:
        raise UserError("404 ao criar repo (token sem escopo na org? use --org e dê permissão).")
    if r.status_code == 403:
        raise UserError("403 Forbidden (rate limit ou escopo insuficiente no token).")
    if not r.ok:
        raise UserError(f"Erro ao criar repo: HTTP {r.status_code} -> {r.text}")
    return r.json()


def ensure_local_repo(
    base_dir: Path,
    project_name: str,
    default_branch: str = "main",
    add_python_gitignore: bool = True,
) -> Path:
    """Cria pasta local com README e .gitignore (Python), inicializa git."""
    proj_dir = base_dir / project_name
    proj_dir.mkdir(parents=True, exist_ok=True)

    readme = proj_dir / "README.md"
    if not readme.exists():
        readme.write_text(f"# {project_name}\n\nProjeto criado via script.\n", encoding="utf-8")

    if add_python_gitignore:
        gi = proj_dir / ".gitignore"
        if not gi.exists():
            gi.write_text(
                "\n".join(
                    [
                        "# Byte-compiled / optimized / DLL files",
                        "__pycache__/",
                        "*.py[cod]",
                        "*$py.class",
                        "",
                        "# Virtual environments",
                        ".venv/",
                        "venv/",
                        "env/",
                        "",
                        "# OS",
                        ".DS_Store",
                        "Thumbs.db",
                        "",
                        "# Tools",
                        ".pytest_cache/",
                        ".mypy_cache/",
                        ".vscode/",
                    ]
                ),
                encoding="utf-8",
            )

    # git init + branch
    run(["git", "init"], cwd=proj_dir)
    # definir a branch inicial como main (funciona mesmo se config global já tiver)
    run(["git", "checkout", "-b", default_branch], cwd=proj_dir)

    # commit inicial
    run(["git", "add", "."], cwd=proj_dir)
    run(["git", "commit", "-m", "chore: primeira versão"], cwd=proj_dir)

    return proj_dir


def set_remote_and_push(
    proj_dir: Path,
    owner: str,
    name: str,
    default_branch: str = "main",
    use_https: bool = False,
) -> None:
    """Configura remote (SSH por padrão) e dá push -u."""
    if use_https:
        # HTTPS: se usar, recomendo ter credential helper configurado
        remote = f"https://github.com/{owner}/{name}.git"
    else:
        # SSH (recomendado)
        remote = f"git@github.com:{owner}/{name}.git"

    # set remote
    run(["git", "remote", "add", "origin", remote], cwd=proj_dir)

    # push
    run(["git", "push", "-u", "origin", default_branch], cwd=proj_dir)


def parse_args() -> argparse.Namespace:
    p = argparse.ArgumentParser(
        description="Cria repo GitHub privado e projeto local (push inicial)."
    )
    # nome pode ser posicional ou via --name, para sua preferência
    p.add_argument("name", nargs="?", help="Nome do projeto/repositório")
    p.add_argument("--name", dest="name_opt", help="Nome do projeto/repositório (alternativo)")
    p.add_argument("--description", default="", help="Descrição do repositório")
    p.add_argument("--public", action="store_true", help="Cria como público (padrão: privado)")
    p.add_argument("--org", help="Organização onde criar o repo (opcional)")
    p.add_argument(
        "--path",
        default=".",
        help="Diretório base onde criar a pasta local (padrão: diretório atual)",
    )
    p.add_argument("--https", action="store_true", help="Usar remote HTTPS em vez de SSH")
    p.add_argument(
        "--branch", default="main", help="Nome da branch principal (padrão: main)"
    )
    p.add_argument(
        "--no-push",
        action="store_true",
        help="Não executar git push (apenas cria localmente e no GitHub).",
    )
    return p.parse_args()


def main() -> int:
    try:
        args = parse_args()
        name = args.name_opt or args.name
        if not name:
            raise UserError("Informe o nome do projeto: ex. `python create_github_project.py meuapp`")

        token = get_token()
        resp = create_repo(
            token=token,
            name=name,
            private=not args.public,
            description=args.description,
            org=args.org,
            auto_init=False,
        )

        owner = resp["owner"]["login"]
        print(f"✓ Repositório criado: https://github.com/{owner}/{name}")

        base_dir = Path(args.path).expanduser().resolve()
        proj_dir = ensure_local_repo(base_dir, name, default_branch=args.branch)
        print(f"✓ Projeto local criado em: {proj_dir}")

        set_remote_and_push(
            proj_dir=proj_dir,
            owner=owner,
            name=name,
            default_branch=args.branch,
            use_https=args.https,
        )

        if args.no_push:
            print("! Você usou --no-push: o push inicial foi pulado.")
        else:
            print("✓ Push inicial realizado com sucesso.")
        print("Tudo pronto! 🚀")
        return 0

    except UserError as e:
        print(f"[ERRO] {e}", file=sys.stderr)
        return 2
    except KeyboardInterrupt:
        print("\n[INTERROMPIDO]", file=sys.stderr)
        return 130


if __name__ == "__main__":
    sys.exit(main())
