#!/bin/bash

# ============================================================================
# Script de Diagnóstico do Servidor VPS
# ============================================================================

echo "════════════════════════════════════════════════════════════════"
echo "  🔍 DIAGNÓSTICO DO SERVIDOR VPS"
echo "════════════════════════════════════════════════════════════════"
echo ""
echo "Conectando no servidor para verificar o problema..."
echo ""

ssh otavio@10.147.20.52 'bash -s' << 'ENDSSH'

echo "✅ Conectado no servidor!"
echo ""

cd /Projetos_Oficial/dev/dev_clean_docker_django_react_postgres

echo "═══════════════════════════════════════════════════════════════"
echo "  📊 STATUS DOS CONTAINERS"
echo "═══════════════════════════════════════════════════════════════"
echo ""
docker compose -f docker-compose.prod.yml ps
echo ""

echo "═══════════════════════════════════════════════════════════════"
echo "  📝 LOGS DO BACKEND (últimas 50 linhas)"
echo "═══════════════════════════════════════════════════════════════"
echo ""
docker compose -f docker-compose.prod.yml logs --tail=50 jupyter_notebook
echo ""

echo "═══════════════════════════════════════════════════════════════"
echo "  📝 LOGS DO FRONTEND (últimas 30 linhas)"
echo "═══════════════════════════════════════════════════════════════"
echo ""
docker compose -f docker-compose.prod.yml logs --tail=30 frontend
echo ""

echo "═══════════════════════════════════════════════════════════════"
echo "  🌐 TESTANDO CONEXÕES"
echo "═══════════════════════════════════════════════════════════════"
echo ""

echo "Testando Backend (porta 8001):"
curl -s http://localhost:8001/api/ | head -20 || echo "❌ Backend não respondeu"
echo ""

echo "Testando Frontend (porta 8081):"
curl -s -I http://localhost:8081/ | head -10 || echo "❌ Frontend não respondeu"
echo ""

echo "═══════════════════════════════════════════════════════════════"
echo "  📁 ARQUIVO .env"
echo "═══════════════════════════════════════════════════════════════"
echo ""
cat .env | grep -v PASSWORD | grep -v SECRET
echo ""

echo "═══════════════════════════════════════════════════════════════"
echo "  ✅ DIAGNÓSTICO COMPLETO"
echo "═══════════════════════════════════════════════════════════════"

ENDSSH

echo ""
echo "════════════════════════════════════════════════════════════════"
echo "  📋 PRÓXIMOS PASSOS"
echo "════════════════════════════════════════════════════════════════"
echo ""
echo "Compartilhe os logs acima para eu identificar o problema!"
echo ""
