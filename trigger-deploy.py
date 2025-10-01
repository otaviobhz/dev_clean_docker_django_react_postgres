#!/usr/bin/env python3
"""
Script para acionar o deploy via API do GitHub
Uso: python3 trigger-deploy.py
"""

import json
import subprocess
import sys

def run_command(cmd):
    """Executa comando e retorna output"""
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    return result.stdout.strip(), result.returncode

def main():
    print("=" * 60)
    print("  🚀 Acionando Deploy via API do GitHub")
    print("=" * 60)
    print()

    # Pegar informações do repositório
    owner = "otaviobhz"
    repo = "dev_clean_docker_django_react_postgres"
    workflow = "deploy-vps.yml"
    branch = "main"

    print(f"📦 Repositório: {owner}/{repo}")
    print(f"🌿 Branch: {branch}")
    print(f"⚙️  Workflow: {workflow}")
    print()

    # Comando curl para acionar workflow
    api_url = f"https://api.github.com/repos/{owner}/{repo}/actions/workflows/{workflow}/dispatches"

    curl_cmd = f'''curl -X POST \\
      -H "Accept: application/vnd.github+json" \\
      -H "X-GitHub-Api-Version: 2022-11-28" \\
      "{api_url}" \\
      -d '{{"ref":"{branch}"}}'
    '''

    print("=" * 60)
    print("  ⚠️  IMPORTANTE: Você Precisa de um Token do GitHub")
    print("=" * 60)
    print()
    print("Este script precisa de autenticação para funcionar.")
    print()
    print("OPÇÃO MAIS FÁCIL:")
    print()
    print("Acesse manualmente o GitHub Actions:")
    print(f"https://github.com/{owner}/{repo}/actions")
    print()
    print("E siga os passos:")
    print("1. Clique em 'Deploy to VPS (ZeroTier)'")
    print("2. Clique no botão 'Run workflow'")
    print("3. Selecione branch 'main'")
    print("4. Clique em 'Run workflow' novamente")
    print()
    print("=" * 60)
    print()
    print("Ou se preferir usar a API, crie um token em:")
    print("https://github.com/settings/tokens")
    print()
    print("Depois execute:")
    print(f'export GITHUB_TOKEN="seu_token_aqui"')
    print()
    print("E rode:")
    print(curl_cmd.replace('\\', ''))
    print()
    print("=" * 60)

if __name__ == "__main__":
    main()
