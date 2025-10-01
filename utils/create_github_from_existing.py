#!/usr/bin/env python3
"""
create_github_from_existing.py
Cria um repositório no GitHub a partir de um projeto JÁ EXISTENTE.
Diferente do create_github_project.py, este NÃO cria um novo diretório.

Requisitos:
  - Python 3.8+
  - requests (pip install requests)
  - git instalado e funcional
  - GH_TOKEN no ambiente, com escopo: repo

Uso:
  # No diretório do projeto:
  export GH_TOKEN=ghp_seu_token_aqui
  python utils/create_github_from_existing.py --name dev_clean_docker_django_react_postgres

  # Com descrição:
  python utils/create_github_from_existing.py --name dev_clean_docker_django_react_postgres --description "Full Stack Template"

  # Público:
  python utils/create_github_from_existing.py --name dev_clean_docker_django_react_postgres --public
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


def run(cmd: list[str], cwd: Optional[Path] = None, capture: bool = False) -> Optional[str]:
    """Executa comando de shell com erro amigável."""
    if capture:
        res = subprocess.run(
            cmd,
            cwd=str(cwd) if cwd else None,
            capture_output=True,
            text=True
        )
        if res.returncode != 0:
            raise UserError(f"Falha ao executar: {' '.join(cmd)} (code={res.returncode})\n{res.stderr}")
        return res.stdout.strip()
    else:
        res = subprocess.run(cmd, cwd=str(cwd) if cwd else None)
        if res.returncode != 0:
            raise UserError(f"Falha ao executar: {' '.join(cmd)} (code={res.returncode})")
        return None


def get_token() -> str:
    token = os.getenv("GH_TOKEN")
    if not token:
        raise UserError(
            "❌ GH_TOKEN não encontrado no ambiente.\n\n"
            "Como obter o token:\n"
            "1. Acesse: https://github.com/settings/tokens/new\n"
            "2. Note: 'MyPS Deploy Token'\n"
            "3. Expiration: 90 days\n"
            "4. Select scopes: Marque 'repo' (todos os sub-items)\n"
            "5. Clique 'Generate token'\n"
            "6. Copie o token (começa com ghp_...)\n"
            "7. Execute: export GH_TOKEN=ghp_seu_token_aqui\n"
            "8. Rode o script novamente\n"
        )
    return token


def create_repo(
    token: str,
    name: str,
    private: bool = True,
    description: str = "",
    org: Optional[str] = None,
) -> dict:
    """Cria repo na conta do usuário (/user/repos) ou em org (/orgs/{org}/repos)."""
    url = f"{GITHUB_API}/user/repos" if not org else f"{GITHUB_API}/orgs/{org}/repos"
    headers = {"Authorization": f"Bearer {token}", "Accept": "application/vnd.github+json"}
    payload = {
        "name": name,
        "description": description,
        "private": private,
        "auto_init": False,  # NÃO criar README, usamos o local
    }

    print(f"📡 Criando repositório '{name}' no GitHub...")
    r = requests.post(url, headers=headers, json=payload, timeout=30)

    if r.status_code == 422:
        msg = r.json()
        raise UserError(f"❌ O repositório '{name}' já existe (ou conflito 422): {msg}")
    if r.status_code == 404:
        raise UserError("❌ 404 ao criar repo (token sem escopo na org? use --org e dê permissão).")
    if r.status_code == 403:
        raise UserError("❌ 403 Forbidden (rate limit ou escopo insuficiente no token).")
    if r.status_code == 401:
        raise UserError("❌ 401 Unauthorized - Token inválido ou expirado!")
    if not r.ok:
        raise UserError(f"❌ Erro ao criar repo: HTTP {r.status_code} -> {r.text}")

    return r.json()


def check_git_status(proj_dir: Path) -> None:
    """Verifica se o diretório tem git inicializado."""
    git_dir = proj_dir / ".git"
    if not git_dir.exists():
        print("⚠️  Git não inicializado neste diretório!")
        print("🔧 Inicializando git...")
        run(["git", "init"], cwd=proj_dir)
        run(["git", "checkout", "-b", "main"], cwd=proj_dir)
    else:
        # Verificar se há branch
        try:
            current_branch = run(["git", "branch", "--show-current"], cwd=proj_dir, capture=True)
            if not current_branch:
                print("🔧 Criando branch main...")
                run(["git", "checkout", "-b", "main"], cwd=proj_dir)
        except:
            run(["git", "checkout", "-b", "main"], cwd=proj_dir)


def check_and_commit(proj_dir: Path) -> None:
    """Verifica se há mudanças e faz commit se necessário."""
    # Verificar status
    status = run(["git", "status", "--porcelain"], cwd=proj_dir, capture=True)

    if status:
        print("📝 Arquivos não commitados encontrados. Fazendo commit...")
        run(["git", "add", "."], cwd=proj_dir)
        run(
            ["git", "commit", "-m", "Initial commit: Full Stack Template"],
            cwd=proj_dir
        )
        print("✅ Commit realizado!")
    else:
        # Verificar se tem algum commit
        try:
            run(["git", "rev-parse", "HEAD"], cwd=proj_dir, capture=True)
            print("✅ Projeto já tem commits")
        except:
            print("⚠️  Nenhum commit encontrado. Criando commit inicial...")
            run(["git", "add", "."], cwd=proj_dir)
            run(
                ["git", "commit", "-m", "Initial commit: Full Stack Template"],
                cwd=proj_dir
            )
            print("✅ Commit inicial criado!")


def set_remote_and_push(
    proj_dir: Path,
    owner: str,
    name: str,
    default_branch: str = "main",
    use_https: bool = False,
) -> None:
    """Configura remote (SSH por padrão) e dá push -u."""
    if use_https:
        remote = f"https://github.com/{owner}/{name}.git"
    else:
        # SSH (recomendado se você já tem SSH configurado)
        remote = f"git@github.com:{owner}/{name}.git"

    # Verificar se remote já existe
    try:
        existing = run(["git", "remote", "get-url", "origin"], cwd=proj_dir, capture=True)
        if existing:
            print(f"⚠️  Remote 'origin' já existe: {existing}")
            print("🔧 Removendo remote antigo...")
            run(["git", "remote", "remove", "origin"], cwd=proj_dir)
    except:
        pass  # Sem remote, tudo bem

    # Adicionar remote
    print(f"🔗 Adicionando remote: {remote}")
    run(["git", "remote", "add", "origin", remote], cwd=proj_dir)

    # Push
    print(f"🚀 Fazendo push para branch '{default_branch}'...")
    run(["git", "push", "-u", "origin", default_branch], cwd=proj_dir)


def parse_args() -> argparse.Namespace:
    p = argparse.ArgumentParser(
        description="Cria repo GitHub a partir de projeto EXISTENTE e faz push."
    )
    p.add_argument("--name", required=True, help="Nome do repositório no GitHub")
    p.add_argument("--description", default="", help="Descrição do repositório")
    p.add_argument("--public", action="store_true", help="Cria como público (padrão: privado)")
    p.add_argument("--org", help="Organização onde criar o repo (opcional)")
    p.add_argument("--https", action="store_true", help="Usar remote HTTPS em vez de SSH")
    p.add_argument(
        "--branch", default="main", help="Nome da branch principal (padrão: main)"
    )
    return p.parse_args()


def main() -> int:
    try:
        args = parse_args()

        # Diretório atual
        proj_dir = Path.cwd()
        print(f"📂 Diretório do projeto: {proj_dir}")

        # Verificar token
        token = get_token()

        # Verificar/inicializar git
        check_git_status(proj_dir)

        # Verificar/fazer commit
        check_and_commit(proj_dir)

        # Criar repositório no GitHub
        resp = create_repo(
            token=token,
            name=args.name,
            private=not args.public,
            description=args.description,
            org=args.org,
        )

        owner = resp["owner"]["login"]
        print(f"✅ Repositório criado: https://github.com/{owner}/{args.name}")

        # Configurar remote e push
        set_remote_and_push(
            proj_dir=proj_dir,
            owner=owner,
            name=args.name,
            default_branch=args.branch,
            use_https=args.https,
        )

        print("\n" + "="*60)
        print("🎉 Tudo pronto! Repositório criado e código enviado!")
        print(f"🔗 URL: https://github.com/{owner}/{args.name}")
        print("="*60)
        return 0

    except UserError as e:
        print(f"\n{e}", file=sys.stderr)
        return 2
    except KeyboardInterrupt:
        print("\n[INTERROMPIDO]", file=sys.stderr)
        return 130
    except Exception as e:
        print(f"\n❌ Erro inesperado: {e}", file=sys.stderr)
        import traceback
        traceback.print_exc()
        return 1


if __name__ == "__main__":
    sys.exit(main())
