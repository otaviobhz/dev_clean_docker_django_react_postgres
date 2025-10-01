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

# 4) Inicia o Jupyter Notebook sem token/password
echo "📚 Iniciando Jupyter Notebook..."
exec jupyter-notebook \
     --ip=0.0.0.0 \
     --port=8999 \
     --no-browser \
     --NotebookApp.token='' \
     --NotebookApp.password='' \
     --allow-root
