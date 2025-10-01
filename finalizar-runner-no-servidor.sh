#!/bin/bash

# ============================================================================
# Script para executar DENTRO DO SERVIDOR para finalizar instalação
# ============================================================================

echo "════════════════════════════════════════════════════════════════"
echo "  🔧 Finalizando Instalação do Runner"
echo "════════════════════════════════════════════════════════════════"
echo ""
echo "Execute estes comandos NO SERVIDOR (10.147.20.52):"
echo ""
echo "────────────────────────────────────────────────────────────────"
cat << 'EOF'

# Conectar no servidor
ssh otavio@10.147.20.52

# Depois de conectado, execute:
cd ~/actions-runner
sudo ./svc.sh install
sudo ./svc.sh start
sudo ./svc.sh status

# Sair do servidor
exit

EOF
echo "────────────────────────────────────────────────────────────────"
echo ""
