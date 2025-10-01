#!/bin/bash

# ============================================================================
# Instalação Automática do GitHub Self-Hosted Runner
# ============================================================================

echo "════════════════════════════════════════════════════════════════"
echo "  🤖 Instalação do GitHub Self-Hosted Runner"
echo "════════════════════════════════════════════════════════════════"
echo ""
echo "Este script vai instalar o runner do GitHub Actions no servidor VPS"
echo "para que o deploy automático funcione!"
echo ""

ssh otavio@10.147.20.52 'bash -s' << 'ENDSSH'
set -e

echo "✅ Conectado no servidor!"
echo ""

# Verificar arquitetura
ARCH=$(uname -m)
if [ "$ARCH" = "x86_64" ]; then
    RUNNER_ARCH="x64"
elif [ "$ARCH" = "aarch64" ]; then
    RUNNER_ARCH="arm64"
else
    echo "❌ Arquitetura não suportada: $ARCH"
    exit 1
fi

echo "📊 Arquitetura detectada: $ARCH ($RUNNER_ARCH)"
echo ""

# Criar diretório
echo "📁 Criando diretório para o runner..."
mkdir -p ~/actions-runner
cd ~/actions-runner

# Baixar runner
echo ""
echo "📥 Baixando GitHub Actions Runner..."
RUNNER_VERSION="2.311.0"
curl -o actions-runner-linux-$RUNNER_ARCH-$RUNNER_VERSION.tar.gz -L \
    https://github.com/actions/runner/releases/download/v$RUNNER_VERSION/actions-runner-linux-$RUNNER_ARCH-$RUNNER_VERSION.tar.gz

echo ""
echo "📦 Extraindo runner..."
tar xzf ./actions-runner-linux-$RUNNER_ARCH-$RUNNER_VERSION.tar.gz

echo ""
echo "✅ Runner baixado e extraído!"
echo ""

echo "════════════════════════════════════════════════════════════════"
echo "  ⚠️  PRÓXIMO PASSO IMPORTANTE"
echo "════════════════════════════════════════════════════════════════"
echo ""
echo "Para configurar o runner, você precisa de um TOKEN do GitHub."
echo ""
echo "1. Acesse este link no navegador:"
echo ""
echo "   https://github.com/otaviobhz/dev_clean_docker_django_react_postgres/settings/actions/runners/new"
echo ""
echo "2. Copie o TOKEN que aparece na página"
echo ""
echo "3. Execute este comando NO SERVIDOR:"
echo ""
echo "   cd ~/actions-runner"
echo "   ./config.sh --url https://github.com/otaviobhz/dev_clean_docker_django_react_postgres --token SEU_TOKEN_AQUI --name vps-zerotier --work _work"
echo ""
echo "4. Depois execute (ainda no servidor):"
echo ""
echo "   sudo ./svc.sh install"
echo "   sudo ./svc.sh start"
echo ""
echo "════════════════════════════════════════════════════════════════"
echo ""
echo "Diretório do runner: ~/actions-runner"
echo ""

ENDSSH

echo ""
echo "════════════════════════════════════════════════════════════════"
echo "  📋 RESUMO"
echo "════════════════════════════════════════════════════════════════"
echo ""
echo "✅ Runner baixado e instalado no servidor!"
echo ""
echo "🔗 Próximo passo: Obter token e configurar"
echo ""
echo "Abra este link para obter o token:"
echo "https://github.com/otaviobhz/dev_clean_docker_django_react_postgres/settings/actions/runners/new"
echo ""
echo "Depois me mostre o token que vou completar a configuração!"
echo ""
