#!/usr/bin/env python3
"""
Setup Interativo do Servidor VPS
Execute: python3 setup_vps_interativo.py
"""

import subprocess
import sys

def run_ssh_command(command):
    """Executa comando SSH interativamente"""
    full_cmd = f'ssh otavio@10.147.20.52 "{command}"'
    print(f"\n🔧 Executando: {command}")
    result = subprocess.run(full_cmd, shell=True)
    return result.returncode == 0

def main():
    print("=" * 60)
    print("  🚀 Setup Automático do Servidor VPS")
    print("=" * 60)
    print("\nServidor: 10.147.20.52")
    print("Usuário: otavio")
    print("Senha: otarau10")
    print("\n⚠️  Você precisará digitar a senha para cada comando")
    print("\nPressione ENTER para continuar...")
    input()

    commands = [
        ("Criar diretório", "mkdir -p /Projetos_Oficial/dev"),
        ("Remover projeto antigo (se existir)", "cd /Projetos_Oficial/dev && rm -rf dev_clean_docker_django_react_postgres || true"),
        ("Clonar repositório", "cd /Projetos_Oficial/dev && git clone https://github.com/otaviobhz/dev_clean_docker_django_react_postgres.git dev_clean_docker_django_react_postgres"),
        ("Configurar ambiente", "cd /Projetos_Oficial/dev/dev_clean_docker_django_react_postgres && cp .env.production .env"),
        ("Verificar Docker", "docker --version && docker compose version"),
        ("Verificar estrutura", "cd /Projetos_Oficial/dev/dev_clean_docker_django_react_postgres && pwd && ls -la | head -15"),
    ]

    print("\n" + "=" * 60)
    print("  📋 Executando Comandos no Servidor")
    print("=" * 60)

    for i, (description, command) in enumerate(commands, 1):
        print(f"\n[{i}/{len(commands)}] {description}")
        success = run_ssh_command(command)

        if not success:
            print(f"\n❌ Erro ao executar: {description}")
            print("Deseja continuar mesmo assim? (s/n): ", end='')
            if input().lower() != 's':
                print("\n⚠️  Setup interrompido")
                sys.exit(1)

    print("\n" + "=" * 60)
    print("  ✅ SETUP CONCLUÍDO COM SUCESSO!")
    print("=" * 60)
    print("\n📦 Projeto instalado em:")
    print("  /Projetos_Oficial/dev/dev_clean_docker_django_react_postgres")
    print("\n🚀 Próximo passo:")
    print("  ./scripts/commands/deploy.sh \"deploy: first production deploy\"")
    print("\nOu acione manualmente no GitHub Actions:")
    print("  https://github.com/otaviobhz/dev_clean_docker_django_react_postgres/actions")
    print()

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\n\n⚠️  Setup cancelado pelo usuário")
        sys.exit(1)
