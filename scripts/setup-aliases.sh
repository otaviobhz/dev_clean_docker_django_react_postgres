#!/bin/bash

# ============================================================================
# Setup de Aliases para Comandos Personalizados
# ============================================================================
# Este script configura aliases no seu shell para usar os comandos de forma simples
# Uso: source scripts/setup-aliases.sh
# ============================================================================

# Detectar o diretório raiz do projeto
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Definir aliases
alias deploy="$PROJECT_ROOT/scripts/commands/deploy.sh"
alias commit="$PROJECT_ROOT/scripts/commands/commit.sh"

# Cores
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo ""
echo -e "${GREEN}✅ Aliases configurados com sucesso!${NC}"
echo ""
echo -e "${BLUE}Comandos disponíveis:${NC}"
echo ""
echo -e "  ${YELLOW}deploy${NC} \"mensagem\"  - Commit + Push + Deploy no VPS"
echo -e "  ${YELLOW}commit${NC} \"mensagem\"  - Commit + Push (sem deploy)"
echo ""
echo -e "${YELLOW}Exemplo de uso:${NC}"
echo "  deploy \"feat: adicionar nova funcionalidade\""
echo "  commit \"docs: atualizar documentação\""
echo ""
echo -e "${BLUE}ℹ️  Para tornar permanente, adicione ao seu ~/.bashrc ou ~/.zshrc:${NC}"
echo "  echo 'source $PROJECT_ROOT/scripts/setup-aliases.sh' >> ~/.bashrc"
echo ""
