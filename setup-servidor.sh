#!/bin/bash

# ============================================================================
# Script para Executar Setup no Servidor VPS
# ============================================================================
# Execute este script e ele vai conectar no servidor e fazer tudo automaticamente
# ============================================================================

echo "════════════════════════════════════════════════"
echo "  🚀 Conectando no Servidor VPS"
echo "════════════════════════════════════════════════"
echo ""
echo "Servidor: 10.147.20.52"
echo "Usuário: otavio"
echo "Senha: otarau10"
echo ""
echo "Conectando..."
echo ""

# Conectar via SSH e executar comandos
ssh otavio@10.147.20.52 << 'ENDSSH'

echo "✅ Conectado no servidor!"
echo ""
echo "════════════════════════════════════════════════"
echo "  📁 Criando Estrutura de Diretórios"
echo "════════════════════════════════════════════════"

# Criar diretório
mkdir -p /Projetos_Oficial/dev
cd /Projetos_Oficial/dev

echo "✅ Diretório criado: /Projetos_Oficial/dev"
echo ""

# Verificar se já existe
if [ -d "dev_clean_docker_django_react_postgres" ]; then
    echo "⚠️  Diretório dev_clean_docker_django_react_postgres já existe!"
    echo "Removendo para clonar novamente..."
    rm -rf dev_clean_docker_django_react_postgres
    echo "✅ Diretório removido"
fi

echo ""
echo "════════════════════════════════════════════════"
echo "  📥 Clonando Repositório do GitHub"
echo "════════════════════════════════════════════════"
echo ""

# Clonar repositório
git clone https://github.com/otaviobhz/dev_clean_docker_django_react_postgres.git dev_clean_docker_django_react_postgres

echo ""
echo "✅ Repositório clonado com sucesso!"
echo ""

# Entrar no diretório
cd dev_clean_docker_django_react_postgres

echo "════════════════════════════════════════════════"
echo "  ⚙️  Configurando Ambiente de Produção"
echo "════════════════════════════════════════════════"
echo ""

# Copiar arquivo de ambiente
if [ -f .env.production ]; then
    cp .env.production .env
    echo "✅ Arquivo .env configurado"
else
    echo "❌ ERRO: .env.production não encontrado!"
fi

echo ""
echo "════════════════════════════════════════════════"
echo "  🐳 Verificando Docker"
echo "════════════════════════════════════════════════"
echo ""

# Verificar Docker
docker --version
docker compose version

echo ""
echo "════════════════════════════════════════════════"
echo "  📊 Estrutura Criada"
echo "════════════════════════════════════════════════"
echo ""

pwd
echo ""
ls -la

echo ""
echo "════════════════════════════════════════════════"
echo "  ✅ SETUP CONCLUÍDO COM SUCESSO!"
echo "════════════════════════════════════════════════"
echo ""
echo "Projeto instalado em:"
echo "  /Projetos_Oficial/dev/dev_clean_docker_django_react_postgres"
echo ""
echo "Próximo passo: Fazer deploy"
echo ""

ENDSSH

echo ""
echo "════════════════════════════════════════════════"
echo "  🎉 Setup no Servidor Finalizado!"
echo "════════════════════════════════════════════════"
echo ""
echo "Agora você pode fazer o deploy:"
echo ""
echo "  ./scripts/commands/deploy.sh \"deploy: first production deploy\""
echo ""
echo "Ou acionar manualmente no GitHub Actions:"
echo "  https://github.com/otaviobhz/dev_clean_docker_django_react_postgres/actions"
echo ""
