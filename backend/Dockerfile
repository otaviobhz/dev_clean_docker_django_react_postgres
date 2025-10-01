# Use uma versão específica do Python para garantir compatibilidade
FROM python:3.10-slim

# Instala dependências do sistema necessárias para Selenium, Chrome e PyAudio
RUN apt-get update && apt-get install -y \
      wget gnupg unzip curl xvfb dos2unix \
      ffmpeg libavcodec-extra libportaudio2 libportaudiocpp0 libasound-dev \
      gcc g++ build-essential \
      portaudio19-dev python3-dev \
      pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Instala Google Chrome
RUN wget -q -O /tmp/google-chrome-key.pub https://dl.google.com/linux/linux_signing_key.pub \
    && gpg --dearmor -o /etc/apt/trusted.gpg.d/google-chrome.gpg /tmp/google-chrome-key.pub \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" \
        > /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update \
    && apt-get install -y google-chrome-stable \
    && rm -rf /var/lib/apt/lists/* /tmp/google-chrome-key.pub

# Define diretório de trabalho
WORKDIR /app

# Cria diretório X11 para Xvfb
RUN mkdir -p /tmp/.X11-unix \
    && chown root:root /tmp/.X11-unix \
    && chmod 1777 /tmp/.X11-unix

# Debug: Lista arquivos para verificar estrutura (não copia ainda)
# RUN echo "🔍 Estrutura de arquivos:" && find /app -name "*entrypoint*" -o -name "*requirements*" -o -name "*script*" | head -20

# Cria requirements.txt padrão e depois tenta usar o personalizado
RUN echo 'selenium>=4.20.0\nwebdriver-manager>=4.0.0\nundetected-chromedriver>=3.5.0\nrequests>=2.31.0\nPillow>=10.0.0\nSpeechRecognition>=3.10.0\npydub>=0.25.1\npyaudio>=0.2.11\njupyter>=1.0.0\njupyterlab>=4.0.0\nipywidgets>=8.0.0\npandas>=1.5.0\nnumpy>=1.24.0\nbeautifulsoup4>=4.12.0\nlxml>=4.9.0\nopencv-python-headless>=4.8.0\nmatplotlib>=3.6.0\nrich>=13.0.0\nopenai>=1.0.0\nmusicbrainzngs>=0.7.0\ndiscogs-client>=2.3.0' > requirements.txt

# Copia apenas requirements.txt se existir
COPY backend/requirements.txt* ./
RUN if [ -f "requirements.txt" ]; then \
        echo "✅ Usando requirements.txt personalizado"; \
    else \
        echo "⚠️ Usando requirements.txt padrão"; \
    fi

# Instala dependências Python
RUN pip install --no-cache-dir --upgrade pip \
  && pip install --no-cache-dir -r requirements.txt

# Instala IPython e Jupyter Notebook com versões específicas
RUN pip install --no-cache-dir \
      ipython==7.34.0 \
      notebook==6.5.7

# Copia e prepara script de extensões do Jupyter
COPY backend/script_nbextensions.sh* ./
RUN if [ -f "script_nbextensions.sh" ]; then \
        echo "✅ Usando script_nbextensions.sh personalizado"; \
        chmod +x script_nbextensions.sh && dos2unix script_nbextensions.sh && ./script_nbextensions.sh && rm script_nbextensions.sh; \
    else \
        echo "⚠️ Instalando extensões Jupyter padrão"; \
        pip install jupyter_contrib_nbextensions jupyter_nbextensions_configurator && \
        jupyter contrib nbextension install --sys-prefix && \
        jupyter nbextension enable --py widgetsnbextension && \
        jupyter nbextensions_configurator enable --sys-prefix; \
    fi

# Cria usuário não-root
RUN useradd -m -s /bin/bash dockeruser

# Copia todo o código do projeto
COPY . .

# Configura permissões do script de entrada ANTES de mudar permissões
RUN if [ -f "/app/backend/docker-entrypoint.sh" ]; then \
        echo "✅ Configurando docker-entrypoint.sh"; \
        dos2unix /app/backend/docker-entrypoint.sh && \
        chmod +x /app/backend/docker-entrypoint.sh; \
    else \
        echo "❌ Arquivo docker-entrypoint.sh não encontrado"; \
        exit 1; \
    fi

# Ajusta permissões do código
RUN chown -R dockeruser:dockeruser /app

# Cria diretórios necessários para o Selenium
RUN mkdir -p /home/dockeruser/.cache/selenium \
    && mkdir -p /home/dockeruser/Downloads \
    && chown -R dockeruser:dockeruser /home/dockeruser

# Muda para usuário não-root
USER dockeruser

# Define variáveis de ambiente
ENV DISPLAY=:99
ENV PYTHONPATH=/app

# Expõe porta do Jupyter
EXPOSE 8999

# Script de entrada
ENTRYPOINT ["/app/backend/docker-entrypoint.sh"]