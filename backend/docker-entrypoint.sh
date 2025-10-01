#!/usr/bin/env bash
set -e

echo "🚀 Iniciando container reCAPTCHA Docker..."

# 1) Limpa lock antigo do Xvfb
rm -f /tmp/.X99-lock

# 2) Inicia Xvfb no display :99 em background
Xvfb :99 -screen 0 1920x1080x24 +extension GLX +render -noreset &

# 3) Teste rápido do Chrome em headless, sem sandbox
CHROME=$(google-chrome --product-version)
echo "✅ Google Chrome encontrado: $CHROME"
echo "🧪 Testando Chrome básico..."
google-chrome \
  --headless \
  --no-sandbox \
  --disable-setuid-sandbox \
  --disable-gpu \
  --disable-dev-shm-usage \
  --disable-features=VizDisplayCompositor \
  --screenshot=/tmp/blank.png \
  about:blank

# 4) NOVO: Configurar Django e iniciar em background
echo "🔧 Configurando Django..."
cd /app/backend/django_project

# Aguarda PostgreSQL estar pronto
echo "⏳ Aguardando PostgreSQL..."
while ! python -c "
import psycopg2
try:
    conn = psycopg2.connect(host='postgres_db', port=5432, user='admin', password='12345', dbname='sample_project_db')
    conn.close()
    print('PostgreSQL OK')
except: 
    exit(1)
"; do
  echo "PostgreSQL não está pronto - aguardando..."
  sleep 2
done

echo "✅ PostgreSQL está pronto!"

# Executar migrações Django
echo "🗄️ Executando migrações Django..."
python manage.py migrate --noinput

# Iniciar Django Ninja em background
echo "🐍 Iniciando Django Ninja em background..."
python manage.py runserver 0.0.0.0:8001 &

# Aguardar Django iniciar
sleep 3
echo "✅ Django Ninja rodando em http://localhost:8001/api/"

# Voltar para diretório principal
cd /app

# 5) Inicia o Jupyter Notebook sem token/password (como antes)
echo "📚 Iniciando Jupyter Notebook..."
exec jupyter-notebook \
     --ip=0.0.0.0 \
     --port=9000 \
     --no-browser \
     --NotebookApp.token='' \
     --NotebookApp.password='' \
     --allow-root