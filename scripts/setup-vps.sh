#!/bin/bash

# Script de Setup Inicial do VPS ZeroTier
# Este script deve ser executado UMA VEZ para configurar o servidor
# Uso: ./scripts/setup-vps.sh

set -e

echo "================================================"
echo "  Setup Inicial do VPS ZeroTier (10.147.20.52)"
echo "================================================"
echo ""

VPS_HOST="10.147.20.52"
VPS_USER="otavio"
REPO_URL="https://github.com/seu-usuario/myps.git"  # Ajuste a URL do seu repositório

echo "Este script irá:"
echo "  1. Criar o diretório /Projetos_Oficial/dev/"
echo "  2. Clonar o repositório"
echo "  3. Copiar o arquivo .env.production para .env"
echo "  4. Verificar se Docker e Docker Compose estão instalados"
echo ""

echo "Conectando ao servidor $VPS_HOST..."
echo ""

sshpass -p "otarau10" ssh ${VPS_USER}@${VPS_HOST} << 'ENDSSH'
set -e

echo "=== Verificando Docker ==="
if ! command -v docker &> /dev/null; then
    echo "❌ Docker não está instalado!"
    echo "Instalando Docker..."
    curl -fsSL https://get.docker.com | sh
    sudo usermod -aG docker $USER
else
    echo "✅ Docker está instalado: $(docker --version)"
fi

echo ""
echo "=== Verificando Docker Compose ==="
if ! docker compose version &> /dev/null; then
    echo "❌ Docker Compose não está disponível!"
else
    echo "✅ Docker Compose está instalado"
fi

echo ""
echo "=== Criando diretório do projeto ==="
mkdir -p /Projetos_Oficial/dev
cd /Projetos_Oficial/dev

echo ""
echo "=== Verificando se o repositório já existe ==="
if [ -d "myps" ]; then
    echo "⚠️  Diretório myps já existe! Atualizando..."
    cd myps
    git pull origin main || echo "Falha ao atualizar. Continue manualmente."
else
    echo "Repositório não existe. Clone manualmente após o setup."
fi

echo ""
echo "=== Setup concluído! ==="
ENDSSH

echo ""
echo "✅ Setup inicial concluído!"
