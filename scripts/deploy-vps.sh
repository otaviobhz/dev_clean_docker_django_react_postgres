#!/bin/bash

# Script de Deploy Manual para VPS ZeroTier
# Uso: ./scripts/deploy-vps.sh

set -e

echo "==================================="
echo "  Deploy Manual para VPS ZeroTier"
echo "==================================="
echo ""

# Configurações
VPS_HOST="10.147.20.52"
VPS_USER="otavio"
PROJECT_PATH="/Projetos_Oficial/dev/myps"

echo "Conectando ao servidor $VPS_HOST..."
echo ""

ssh ${VPS_USER}@${VPS_HOST} << 'EOF'
set -e

echo "=== Iniciando Deploy no VPS ==="

# Navegar para o diretório do projeto
cd /Projetos_Oficial/dev/myps

echo "=== Atualizando código do repositório ==="
git fetch origin
git reset --hard origin/main

echo "=== Copiando arquivo de ambiente de produção ==="
if [ -f .env.production ]; then
    cp .env.production .env
    echo "Arquivo .env.production copiado para .env"
else
    echo "AVISO: Arquivo .env.production não encontrado!"
fi

echo "=== Parando containers antigos ==="
docker compose -f docker-compose.prod.yml down || true

echo "=== Removendo imagens antigas ==="
docker image prune -f

echo "=== Construindo novas imagens ==="
docker compose -f docker-compose.prod.yml build --no-cache

echo "=== Iniciando containers ==="
docker compose -f docker-compose.prod.yml up -d

echo "=== Aguardando inicialização dos containers ==="
sleep 10

echo "=== Verificando status dos containers ==="
docker compose -f docker-compose.prod.yml ps

echo "=== Verificando logs dos containers ==="
docker compose -f docker-compose.prod.yml logs --tail=30

echo "=== Deploy concluído com sucesso! ==="
echo ""
echo "=== Aplicação disponível em: ==="
echo "  - Frontend: http://10.147.20.52:8081"
echo "  - API: http://10.147.20.52:8001"
echo "  - Jupyter: http://10.147.20.52:9000"
echo "  - PgAdmin: http://10.147.20.52:5051"
EOF

echo ""
echo "✅ Deploy concluído!"
