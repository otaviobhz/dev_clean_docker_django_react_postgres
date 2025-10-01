#!/bin/bash

# ============================================================================
# COMANDO: deploy
# ============================================================================
# Descrição: Faz commit, push e trigger do deploy automático no VPS
# Uso: ./scripts/commands/deploy.sh [mensagem do commit]
# Ou após configurar alias: deploy "mensagem do commit"
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
echo -e "${BLUE}║        🚀 DEPLOY COMMAND - VPS ZeroTier       ║${NC}"
echo -e "${BLUE}╔════════════════════════════════════════════════╗${NC}"
echo ""

# Verificar se há mensagem de commit
if [ -z "$1" ]; then
    echo -e "${RED}❌ Erro: Mensagem do commit é obrigatória${NC}"
    echo ""
    echo "Uso: deploy \"sua mensagem de commit\""
    echo ""
    echo "Exemplo:"
    echo "  deploy \"fix: corrigir bug no login\""
    echo "  deploy \"feat: adicionar nova funcionalidade\""
    echo ""
    exit 1
fi

COMMIT_MESSAGE="$1"
BRANCH="${2:-main}"

echo -e "${YELLOW}📝 Branch:${NC} $BRANCH"
echo -e "${YELLOW}💬 Mensagem:${NC} $COMMIT_MESSAGE"
echo ""

# Verificar status do git
echo -e "${BLUE}[1/5]${NC} Verificando mudanças..."
if [[ -z $(git status -s) ]]; then
    echo -e "${YELLOW}⚠️  Nenhuma mudança para commitar${NC}"
    read -p "Deseja fazer deploy mesmo assim? (s/n) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Ss]$ ]]; then
        echo -e "${RED}Deploy cancelado${NC}"
        exit 0
    fi
else
    git status -s
fi

echo ""

# Git add
echo -e "${BLUE}[2/5]${NC} Adicionando arquivos ao staging..."
git add .
echo -e "${GREEN}✓${NC} Arquivos adicionados"
echo ""

# Git commit
echo -e "${BLUE}[3/5]${NC} Criando commit..."
git commit -m "$COMMIT_MESSAGE

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"
echo -e "${GREEN}✓${NC} Commit criado"
echo ""

# Git push
echo -e "${BLUE}[4/5]${NC} Enviando para GitHub..."
git push origin $BRANCH
echo -e "${GREEN}✓${NC} Push realizado"
echo ""

# Trigger deploy via GitHub CLI
echo -e "${BLUE}[5/5]${NC} Iniciando deploy no VPS..."

if command -v gh &> /dev/null; then
    echo -e "${YELLOW}Usando GitHub CLI para trigger do workflow...${NC}"
    gh workflow run "Deploy to VPS (ZeroTier)" --ref $BRANCH -f branch=$BRANCH
    echo ""
    echo -e "${GREEN}✓${NC} Deploy iniciado!"
    echo ""
    echo -e "${YELLOW}📊 Acompanhe o deploy em:${NC}"
    gh workflow view "Deploy to VPS (ZeroTier)" --web
else
    echo -e "${YELLOW}⚠️  GitHub CLI não instalado${NC}"
    echo ""
    echo "Para trigger automático, instale o GitHub CLI:"
    echo "  https://cli.github.com/"
    echo ""
    echo "Ou acesse manualmente:"
    echo "  https://github.com/$(git remote get-url origin | sed 's/.*github.com[:/]\(.*\)\.git/\1/')/actions"
    echo ""
    echo -e "${BLUE}Clique em 'Run workflow' e selecione a branch: $BRANCH${NC}"
fi

echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║           ✅ DEPLOY COMMAND COMPLETO           ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${YELLOW}🌐 Aplicação estará disponível em:${NC}"
echo "   - Frontend: http://10.147.20.52:8081"
echo "   - API: http://10.147.20.52:8001"
echo "   - Jupyter: http://10.147.20.52:9000"
echo ""
