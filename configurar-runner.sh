#!/bin/bash

# ============================================================================
# Configuração do GitHub Runner com Token
# ============================================================================

TOKEN="AWTWPGELFADA6X7WJK3NDQTI3WXFG"

echo "════════════════════════════════════════════════════════════════"
echo "  🔧 Configurando GitHub Runner no Servidor"
echo "════════════════════════════════════════════════════════════════"
echo ""

ssh otavio@10.147.20.52 'bash -s' << ENDSSH
set -e

echo "✅ Conectado no servidor!"
echo ""

cd ~/actions-runner

echo "📝 Configurando runner..."
./config.sh --url https://github.com/otaviobhz/dev_clean_docker_django_react_postgres --token $TOKEN --name vps-zerotier --work _work --labels self-hosted,Linux,X64,zerotier --unattended

echo ""
echo "✅ Runner configurado!"
echo ""

echo "🔧 Instalando como serviço..."
sudo ./svc.sh install

echo ""
echo "🚀 Iniciando serviço..."
sudo ./svc.sh start

echo ""
echo "📊 Verificando status..."
sudo ./svc.sh status

echo ""
echo "════════════════════════════════════════════════════════════════"
echo "  ✅ RUNNER INSTALADO E RODANDO!"
echo "════════════════════════════════════════════════════════════════"
echo ""
echo "O GitHub Runner está ativo e esperando por jobs!"
echo ""

ENDSSH

echo ""
echo "════════════════════════════════════════════════════════════════"
echo "  🎉 CONFIGURAÇÃO COMPLETA!"
echo "════════════════════════════════════════════════════════════════"
echo ""
echo "Próximo passo: Atualizar o workflow do GitHub Actions"
echo ""
