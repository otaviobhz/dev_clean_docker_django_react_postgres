#!/bin/bash

# ============================================================================
# Copy Scripts to New Project
# ============================================================================
# Descrição: Copia os scripts de deploy/commit para outro projeto
# Uso: ./scripts/copy-to-project.sh /caminho/do/novo-projeto
# ============================================================================

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

if [ -z "$1" ]; then
    echo -e "${RED}❌ Erro: Caminho do projeto destino é obrigatório${NC}"
    echo ""
    echo "Uso: ./scripts/copy-to-project.sh /caminho/do/novo-projeto"
    echo ""
    exit 1
fi

DEST_PROJECT="$1"

if [ ! -d "$DEST_PROJECT" ]; then
    echo -e "${RED}❌ Erro: Diretório não existe: $DEST_PROJECT${NC}"
    exit 1
fi

echo ""
echo -e "${BLUE}Copiando scripts de deploy/commit para:${NC}"
echo -e "${BLUE}→ $DEST_PROJECT${NC}"
echo ""

# Copiar pasta de comandos
mkdir -p "$DEST_PROJECT/scripts/commands"
cp scripts/commands/deploy.sh "$DEST_PROJECT/scripts/commands/"
cp scripts/commands/commit.sh "$DEST_PROJECT/scripts/commands/"
chmod +x "$DEST_PROJECT/scripts/commands/"*.sh

echo -e "${GREEN}✅ Scripts copiados com sucesso!${NC}"
echo ""
echo -e "${BLUE}Uso no novo projeto:${NC}"
echo "  cd $DEST_PROJECT"
echo "  ./scripts/commands/deploy.sh \"mensagem\""
echo "  ./scripts/commands/commit.sh \"mensagem\""
echo ""
