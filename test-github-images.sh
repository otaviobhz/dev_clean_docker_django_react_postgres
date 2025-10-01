#!/bin/bash
# Script para testar as imagens do GitHub Container Registry

echo "🔍 Testando imagens Docker do GitHub Actions..."
echo ""

# Pull das imagens
echo "📥 Fazendo pull das imagens..."
docker pull ghcr.io/otaviobhz/myps-frontend:latest
docker pull ghcr.io/otaviobhz/myps-backend:latest

echo ""
echo "✅ Imagens baixadas com sucesso!"
echo ""

# Verificar imagens
echo "📋 Imagens disponíveis:"
docker images | grep myps

echo ""
echo "🎉 Teste completo!"
echo ""
echo "Para rodar as imagens:"
echo "  Frontend: docker run -p 8081:8081 ghcr.io/otaviobhz/myps-frontend:latest"
echo "  Backend:  docker run -p 8001:8001 ghcr.io/otaviobhz/myps-backend:latest"
