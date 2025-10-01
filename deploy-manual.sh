#!/bin/bash

# ============================================================================
# Deploy Manual para VPS
# ============================================================================
# Como usar: ./deploy-manual.sh
# ============================================================================

echo "════════════════════════════════════════════════════════════════"
echo "  🚀 Deploy Manual para VPS (10.147.20.52)"
echo "════════════════════════════════════════════════════════════════"
echo ""
echo "Este script vai:"
echo "  1. Conectar no servidor via SSH"
echo "  2. Fazer git pull do código atualizado"
echo "  3. Reconstruir e reiniciar os containers Docker"
echo ""
echo "Pressione ENTER para continuar ou Ctrl+C para cancelar..."
read

ssh otavio@10.147.20.52 'bash -s' << 'ENDSSH'
set -e

echo ""
echo "✅ Conectado no servidor!"
echo ""

cd /Projetos_Oficial/dev/dev_clean_docker_django_react_postgres

echo "═══════════════════════════════════════════════════════════════"
echo "  📥 Atualizando Código do GitHub"
echo "═══════════════════════════════════════════════════════════════"
echo ""
git fetch origin
git reset --hard origin/main
echo "✅ Código atualizado"
echo ""

echo "═══════════════════════════════════════════════════════════════"
echo "  ⚙️  Configurando Ambiente"
echo "═══════════════════════════════════════════════════════════════"
echo ""
cp .env.production .env
echo "✅ Ambiente configurado"
echo ""

echo "═══════════════════════════════════════════════════════════════"
echo "  🛑 Parando Containers Antigos"
echo "═══════════════════════════════════════════════════════════════"
echo ""
docker compose -f docker-compose.prod.yml down
echo "✅ Containers parados"
echo ""

echo "═══════════════════════════════════════════════════════════════"
echo "  🔨 Reconstruindo Imagens Docker"
echo "═══════════════════════════════════════════════════════════════"
echo ""
docker compose -f docker-compose.prod.yml build --no-cache
echo "✅ Imagens reconstruídas"
echo ""

echo "═══════════════════════════════════════════════════════════════"
echo "  🚀 Iniciando Containers"
echo "═══════════════════════════════════════════════════════════════"
echo ""
docker compose -f docker-compose.prod.yml up -d
echo "✅ Containers iniciados"
echo ""

echo "⏳ Aguardando inicialização (10 segundos)..."
sleep 10
echo ""

echo "═══════════════════════════════════════════════════════════════"
echo "  📊 Status dos Containers"
echo "═══════════════════════════════════════════════════════════════"
echo ""
docker compose -f docker-compose.prod.yml ps
echo ""

echo "═══════════════════════════════════════════════════════════════"
echo "  📝 Últimos Logs"
echo "═══════════════════════════════════════════════════════════════"
echo ""
docker compose -f docker-compose.prod.yml logs --tail=20
echo ""

echo "═══════════════════════════════════════════════════════════════"
echo "  ✅ DEPLOY CONCLUÍDO COM SUCESSO!"
echo "═══════════════════════════════════════════════════════════════"
echo ""
echo "🌐 Aplicação disponível em:"
echo "   - Frontend: http://10.147.20.52:8081"
echo "   - API: http://10.147.20.52:8001/api/"
echo "   - Jupyter: http://10.147.20.52:9000"
echo "   - PgAdmin: http://10.147.20.52:5051"
echo ""

ENDSSH

echo ""
echo "════════════════════════════════════════════════════════════════"
echo "  🎉 Deploy Finalizado!"
echo "════════════════════════════════════════════════════════════════"
echo ""
echo "Acesse o frontend em: http://10.147.20.52:8081"
echo ""
