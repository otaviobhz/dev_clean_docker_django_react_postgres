#!/bin/bash

# ============================================================================
# COMANDO: deploy
# ============================================================================
# Descrição: Faz merge de dev→main e dispara deploy automático no VPS
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
echo -e "${BLUE}║        🚀 DEPLOY - Merge dev→main + VPS       ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════╝${NC}"
echo ""

# Verificar se há mensagem de commit
if [ -z "$1" ]; then
    echo -e "${RED}❌ Erro: Mensagem do commit é obrigatória${NC}"
    echo ""
    echo "Uso: deploy \"sua mensagem de deploy\""
    echo ""
    echo "Exemplo:"
    echo "  deploy \"feat: nova funcionalidade de relatórios\""
    echo "  deploy \"fix: corrigir bug crítico no login\""
    echo ""
    exit 1
fi

COMMIT_MESSAGE="$1"

echo -e "${YELLOW}💬 Mensagem:${NC} $COMMIT_MESSAGE"
echo ""

# Verificar branch atual
CURRENT_BRANCH=$(git branch --show-current)
echo -e "${BLUE}[1/7]${NC} Verificando branch atual..."
echo -e "${YELLOW}📍 Branch atual:${NC} $CURRENT_BRANCH"
echo ""

# Se não estiver na dev, mudar para dev
if [ "$CURRENT_BRANCH" != "dev" ]; then
    echo -e "${YELLOW}⚠️  Mudando para branch dev...${NC}"
    git checkout dev
    echo ""
fi

# Verificar se há mudanças
echo -e "${BLUE}[2/7]${NC} Verificando mudanças na branch dev..."
if [[ ! -z $(git status -s) ]]; then
    echo -e "${YELLOW}Mudanças detectadas:${NC}"
    git status -s
    echo ""

    # Git add
    echo -e "${BLUE}[3/7]${NC} Adicionando arquivos ao staging..."
    git add .
    echo -e "${GREEN}✓${NC} Arquivos adicionados"
    echo ""

    # Git commit na dev
    echo -e "${BLUE}[4/7]${NC} Criando commit na dev..."
    git commit -m "$COMMIT_MESSAGE

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"
    echo -e "${GREEN}✓${NC} Commit criado na dev"
    echo ""

    # Push dev
    echo -e "${BLUE}[5/7]${NC} Enviando dev para GitHub..."
    git push origin dev
    echo -e "${GREEN}✓${NC} Branch dev atualizada no GitHub"
    echo ""
else
    echo -e "${GREEN}✓${NC} Nenhuma mudança pendente na dev"
    echo ""
fi

# Mudar para main
echo -e "${BLUE}[6/7]${NC} Fazendo merge dev→main..."
git checkout main
git pull origin main
git merge dev -m "Merge branch 'dev' into 'main' - $COMMIT_MESSAGE"
echo -e "${GREEN}✓${NC} Merge realizado"
echo ""

# Push para main (dispara deploy automático)
echo -e "${BLUE}[7/7]${NC} Enviando main para GitHub..."
echo -e "${YELLOW}⚡ Isso vai disparar o deploy automático no VPS!${NC}"
git push origin main
echo -e "${GREEN}✓${NC} Push realizado - Deploy iniciado!"
echo ""

# Voltar para dev
echo -e "${YELLOW}🔄 Voltando para branch dev...${NC}"
git checkout dev
echo ""

echo -e "${GREEN}╔════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║         ✅ DEPLOY INICIADO COM SUCESSO!        ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════╝${NC}"
echo ""

echo -e "${BLUE}📊 Acompanhe o deploy em tempo real:${NC}"
echo "   https://github.com/otaviobhz/dev_clean_docker_django_react_postgres/actions"
echo ""

echo -e "${YELLOW}⏱️  Aguarde ~2-3 minutos para o deploy completar${NC}"
echo ""

echo -e "${YELLOW}🌐 Aplicação estará disponível em:${NC}"
echo "   - Frontend: http://10.147.20.52:8081"
echo "   - API: http://10.147.20.52:8001"
echo "   - Jupyter: http://10.147.20.52:9000"
echo "   - PgAdmin: http://10.147.20.52:5051"
echo ""

echo -e "${GREEN}✓${NC} Você está de volta na branch dev para continuar desenvolvendo!"
echo ""
