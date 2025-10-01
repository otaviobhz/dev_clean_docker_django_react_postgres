#!/bin/bash

echo "════════════════════════════════════════════════════════════════"
echo "  🔑 COPIE E COLE ESTE COMANDO NO SEU TERMINAL"
echo "════════════════════════════════════════════════════════════════"
echo ""
echo "Este é um comando ÚNICO que faz tudo:"
echo ""
echo "1. Conecta no servidor"
echo "2. Cria estrutura de diretórios"
echo "3. Clona o repositório"
echo "4. Configura ambiente"
echo ""
echo "════════════════════════════════════════════════════════════════"
echo ""
cat << 'EOF'
ssh otavio@10.147.20.52 'bash -s' << 'ENDSSH'
set -e
echo "✅ Conectado no servidor!"
echo ""
echo "📁 Criando diretório..."
mkdir -p /Projetos_Oficial/dev
cd /Projetos_Oficial/dev
echo "✅ Diretório criado"
echo ""
echo "🗑️  Removendo projeto antigo (se existir)..."
rm -rf dev_clean_docker_django_react_postgres || true
echo "✅ Limpeza concluída"
echo ""
echo "📥 Clonando repositório do GitHub..."
git clone https://github.com/otaviobhz/dev_clean_docker_django_react_postgres.git dev_clean_docker_django_react_postgres
echo "✅ Repositório clonado"
echo ""
echo "📂 Entrando no diretório..."
cd dev_clean_docker_django_react_postgres
echo "✅ Dentro do projeto"
echo ""
echo "⚙️  Configurando ambiente de produção..."
cp .env.production .env
echo "✅ Ambiente configurado"
echo ""
echo "🐳 Verificando Docker..."
docker --version
docker compose version
echo ""
echo "📊 Estrutura criada:"
pwd
echo ""
ls -la | head -20
echo ""
echo "════════════════════════════════════════════════════════════════"
echo "  ✅ SETUP CONCLUÍDO COM SUCESSO!"
echo "════════════════════════════════════════════════════════════════"
echo ""
echo "Projeto instalado em: /Projetos_Oficial/dev/dev_clean_docker_django_react_postgres"
echo ""
ENDSSH
EOF

echo ""
echo "════════════════════════════════════════════════════════════════"
echo "  📋 INSTRUÇÕES:"
echo "════════════════════════════════════════════════════════════════"
echo ""
echo "1. COPIE todo o comando acima (desde 'ssh' até 'ENDSSH')"
echo "2. COLE no seu terminal"
echo "3. Digite a senha quando pedir: otarau10"
echo "4. Aguarde a execução"
echo ""
echo "Depois execute:"
echo "  ./scripts/commands/deploy.sh \"deploy: first production deploy\""
echo ""
echo "════════════════════════════════════════════════════════════════"
