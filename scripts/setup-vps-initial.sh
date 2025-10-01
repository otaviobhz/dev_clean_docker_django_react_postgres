#!/bin/bash

# ============================================================================
# Setup Inicial do VPS - EXECUTE UMA VEZ
# ============================================================================
# Este script prepara o servidor VPS para receber deploys automáticos
# ============================================================================

echo "════════════════════════════════════════════════"
echo "  🚀 Setup Inicial do VPS (10.147.20.52)"
echo "════════════════════════════════════════════════"
echo ""
echo "Este script irá:"
echo "  1. Criar o diretório /Projetos_Oficial/dev/"
echo "  2. Clonar o repositório como 'dev_clean_docker_django_react_postgres'"
echo "  3. Copiar arquivo .env.production para .env"
echo "  4. Verificar Docker"
echo ""
echo "⚠️  CONFIGURÁVEL: Para novos projetos, mude:"
echo "    - Nome do diretório: 'dev_clean_docker_django_react_postgres' → 'seu_novo_projeto'"
echo "    - URL do repositório GitHub"
echo ""
echo "IMPORTANTE: Execute os comandos abaixo MANUALMENTE no servidor VPS"
echo ""
echo "────────────────────────────────────────────────"
echo "PASSO 1: Conectar no servidor"
echo "────────────────────────────────────────────────"
echo ""
echo "ssh otavio@10.147.20.52"
echo ""
echo "────────────────────────────────────────────────"
echo "PASSO 2: Copie e cole os comandos abaixo"
echo "────────────────────────────────────────────────"
echo ""
cat << 'EOF'
# Criar diretório
mkdir -p /Projetos_Oficial/dev
cd /Projetos_Oficial/dev

# ⚠️ CONFIGURÁVEL: Mude 'dev_clean_docker_django_react_postgres' para o nome do seu novo projeto
# Verificar se dev_clean_docker_django_react_postgres já existe
if [ -d "dev_clean_docker_django_react_postgres" ]; then
    echo "⚠️  Diretório dev_clean_docker_django_react_postgres já existe!"
    echo "Removendo para clonar novamente..."
    rm -rf dev_clean_docker_django_react_postgres
fi

# ⚠️ CONFIGURÁVEL: Mude a URL para o repositório do seu novo projeto
# Clonar repositório
echo "Clonando repositório..."
git clone https://github.com/otaviobhz/dev_clean_docker_django_react_postgres.git dev_clean_docker_django_react_postgres

# Entrar no diretório
cd dev_clean_docker_django_react_postgres

# Copiar arquivo de ambiente
echo "Configurando ambiente de produção..."
cp .env.production .env

# Verificar Docker
echo ""
echo "Verificando Docker..."
docker --version
docker compose version

# Mostrar status
echo ""
echo "✅ Setup concluído!"
echo ""
echo "Estrutura criada:"
pwd
ls -la

echo ""
echo "Próximo passo: Sair do servidor e rodar deploy novamente"
echo "  exit"
echo "  ./scripts/commands/deploy.sh \"deploy: first production deploy\""
EOF

echo ""
echo "────────────────────────────────────────────────"
echo "PASSO 3: Depois de executar, saia do servidor"
echo "────────────────────────────────────────────────"
echo ""
echo "exit"
echo ""
echo "────────────────────────────────────────────────"
echo "PASSO 4: Faça o deploy novamente"
echo "────────────────────────────────────────────────"
echo ""
echo "./scripts/commands/deploy.sh \"deploy: first production deploy\""
echo ""
echo "════════════════════════════════════════════════"
