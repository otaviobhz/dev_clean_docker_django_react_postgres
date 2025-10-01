#!/bin/bash

# ============================================================================
# COMANDO: commit
# ============================================================================
# Descrição: Faz commit e push SEM fazer deploy
# Uso: ./scripts/commands/commit.sh [mensagem do commit]
# Ou após configurar alias: commit "mensagem do commit"
# ============================================================================

set -e

# Cores para output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Banner
echo ""
echo -e "${BLUE}╔════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║          📦 COMMIT COMMAND - No Deploy        ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════╝${NC}"
echo ""

# Verificar se há mensagem de commit
if [ -z "$1" ]; then
    echo -e "${RED}❌ Erro: Mensagem do commit é obrigatória${NC}"
    echo ""
    echo "Uso: commit \"sua mensagem de commit\""
    echo ""
    echo "Exemplo:"
    echo "  commit \"docs: atualizar README\""
    echo "  commit \"chore: atualizar dependências\""
    echo ""
    exit 1
fi

COMMIT_MESSAGE="$1"
BRANCH="${2:-main}"

echo -e "${YELLOW}📝 Branch:${NC} $BRANCH"
echo -e "${YELLOW}💬 Mensagem:${NC} $COMMIT_MESSAGE"
echo ""

# Verificar status do git
echo -e "${BLUE}[1/4]${NC} Verificando mudanças..."
if [[ -z $(git status -s) ]]; then
    echo -e "${RED}❌ Nenhuma mudança para commitar${NC}"
    exit 1
fi

git status -s
echo ""

# Git add
echo -e "${BLUE}[2/4]${NC} Adicionando arquivos ao staging..."
git add .
echo -e "${GREEN}✓${NC} Arquivos adicionados"
echo ""

# Git commit
echo -e "${BLUE}[3/4]${NC} Criando commit..."
git commit -m "$COMMIT_MESSAGE

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"
echo -e "${GREEN}✓${NC} Commit criado"
echo ""

# Git push
echo -e "${BLUE}[4/4]${NC} Enviando para GitHub..."
git push origin $BRANCH
echo -e "${GREEN}✓${NC} Push realizado"
echo ""

echo -e "${GREEN}╔════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║          ✅ COMMIT COMMAND COMPLETO            ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}ℹ️  Este commit NÃO vai fazer deploy automático${NC}"
echo -e "${YELLOW}Para fazer deploy, use:${NC} deploy \"mensagem\""
echo ""
