# Guia de Deploy para VPS via ZeroTier

Este guia explica como configurar e realizar deploy automático da aplicação no servidor VPS através do ZeroTier.

## 📋 Informações do Servidor

- **IP ZeroTier**: 10.147.20.52
- **Usuário SSH**: otavio
- **Caminho do Projeto**: `/Projetos_Oficial/dev/dev_clean_docker_django_react_postgres`

## 🚀 Portas Expostas

A aplicação expõe as seguintes portas:

- **8081**: Frontend React
- **8001**: API Django Ninja
- **9000**: Jupyter Notebook
- **5433**: PostgreSQL
- **5051**: PgAdmin

## 🔧 Configuração Inicial

### 1. Configurar GitHub Secrets

Acesse: `Settings → Secrets and variables → Actions → New repository secret`

Adicione as seguintes secrets:

```
VPS_HOST=10.147.20.52
VPS_USERNAME=otavio
VPS_PASSWORD=otarau10
```

### 2. Preparar o Servidor VPS

#### Opção A: Setup Automático (Recomendado)

Execute o script de setup a partir da sua máquina local:

```bash
./scripts/setup-vps.sh
```

#### Opção B: Setup Manual

Conecte-se ao servidor:

```bash
ssh otavio@10.147.20.52
```

Execute os comandos:

```bash
# Criar diretório
mkdir -p /Projetos_Oficial/dev
cd /Projetos_Oficial/dev

# Clonar repositório
git clone https://github.com/otaviobhz/dev_clean_docker_django_react_postgres.git dev_clean_docker_django_react_postgres
cd dev_clean_docker_django_react_postgres

# Copiar arquivo de ambiente
cp .env.production .env

# Verificar Docker
docker --version
docker compose version
```

### 3. Primeiro Deploy

Após configurar as secrets do GitHub:

```bash
# Fazer commit e push
git add .
git commit -m "Setup deploy VPS"
git push origin main
```

O GitHub Actions iniciará automaticamente o deploy.

## 🔄 Deploy Automático

Toda vez que você fizer push na branch `main`, o GitHub Actions:

1. Conecta no servidor via SSH
2. Faz `git pull` do código atualizado
3. Para os containers antigos
4. Reconstrói as imagens Docker
5. Inicia os novos containers
6. Mostra os logs

## 🖥️ Deploy Manual

Se preferir fazer deploy manual:

```bash
./scripts/deploy-vps.sh
```

Ou conecte diretamente no servidor:

```bash
ssh otavio@10.147.20.52
cd /Projetos_Oficial/dev/dev_clean_docker_django_react_postgres
git pull origin main
docker compose -f docker-compose.prod.yml down
docker compose -f docker-compose.prod.yml up -d --build
```

## 🌐 Acessando a Aplicação

Após o deploy, acesse:

- **Frontend**: http://10.147.20.52:8081
- **API**: http://10.147.20.52:8001
- **Jupyter**: http://10.147.20.52:9000
- **PgAdmin**: http://10.147.20.52:5051

## 📝 Configuração de Domínio (Opcional)

Para usar o domínio `hyperfocus.com.br`:

### 1. Configurar DNS

Aponte o domínio para o IP: `10.147.20.52`

### 2. Instalar Nginx no Servidor

```bash
ssh otavio@10.147.20.52
sudo apt update
sudo apt install nginx
```

### 3. Configurar Nginx como Proxy Reverso

Crie `/etc/nginx/sites-available/dev_clean_docker_django_react_postgres`:

```nginx
server {
    listen 80;
    server_name hyperfocus.com.br;

    # Frontend
    location / {
        proxy_pass http://localhost:8081;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    # API
    location /api {
        proxy_pass http://localhost:8001;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

Ative o site:

```bash
sudo ln -s /etc/nginx/sites-available/dev_clean_docker_django_react_postgres /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

### 4. Instalar SSL (HTTPS)

```bash
sudo apt install certbot python3-certbot-nginx
sudo certbot --nginx -d hyperfocus.com.br
```

## 🐛 Troubleshooting

### Ver logs dos containers

```bash
ssh otavio@10.147.20.52
cd /Projetos_Oficial/dev/dev_clean_docker_django_react_postgres
docker compose -f docker-compose.prod.yml logs -f
```

### Verificar status dos containers

```bash
docker compose -f docker-compose.prod.yml ps
```

### Reiniciar containers

```bash
docker compose -f docker-compose.prod.yml restart
```

### Limpar tudo e reconstruir

```bash
docker compose -f docker-compose.prod.yml down -v
docker system prune -a -f
docker compose -f docker-compose.prod.yml up -d --build
```

## 🔐 Segurança

**IMPORTANTE**:

1. As credenciais neste arquivo são apenas para desenvolvimento
2. Para produção, use senhas fortes e diferentes
3. Considere usar chaves SSH ao invés de senha
4. Configure um firewall (UFW) no servidor
5. Mantenha o Docker e sistema operacional atualizados

### Configurar Firewall (Recomendado)

```bash
ssh otavio@10.147.20.52
sudo apt install ufw
sudo ufw allow 22/tcp      # SSH
sudo ufw allow 80/tcp      # HTTP
sudo ufw allow 443/tcp     # HTTPS
sudo ufw allow 8001/tcp    # API
sudo ufw allow 8081/tcp    # Frontend
sudo ufw allow 9000/tcp    # Jupyter
sudo ufw enable
```

## 📁 Arquivos Importantes

- `.env.production`: Variáveis de ambiente para produção
- `docker-compose.prod.yml`: Configuração Docker para produção
- `.github/workflows/deploy-vps.yml`: Workflow de deploy automático
- `scripts/deploy-vps.sh`: Script de deploy manual
- `scripts/setup-vps.sh`: Script de setup inicial

## 💡 Dicas

1. **Sempre faça backup do banco de dados antes de deploys grandes**
2. **Teste localmente antes de fazer push**
3. **Monitore os logs após cada deploy**
4. **Use branches para testar mudanças antes de mergear na main**

## 🆘 Suporte

Se tiver problemas:

1. Verifique os logs do GitHub Actions
2. Conecte no servidor e veja os logs dos containers
3. Certifique-se que o ZeroTier está conectado
4. Verifique se as portas não estão sendo usadas por outros serviços
