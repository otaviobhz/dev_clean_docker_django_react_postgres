FROM node:18-alpine

WORKDIR /app

# Copiar package.json
COPY package.json ./

# Instalar dependências
RUN npm install

# Copiar código fonte
COPY . .

# Expor porta 8081
EXPOSE 8081

# Configurar variáveis de ambiente
ENV HOST=0.0.0.0
ENV PORT=8081
ENV BROWSER=none
ENV CHOKIDAR_USEPOLLING=true

# Iniciar React dev server
CMD ["npm", "start"]
