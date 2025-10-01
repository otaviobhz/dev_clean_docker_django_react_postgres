# MyPS - Deployment Guide

**Version:** 1.0.0
**Last Updated:** October 1, 2025
**GitHub Actions Ready:** ✅

---

## 📋 Table of Contents

1. [GitHub Actions Workflows](#github-actions-workflows)
2. [Deployment Platforms](#deployment-platforms)
3. [URL Configuration](#url-configuration)
4. [Secrets Configuration](#secrets-configuration)
5. [Deployment Process](#deployment-process)
6. [Platform-Specific Guides](#platform-specific-guides)

---

## GitHub Actions Workflows

Criei **3 workflows** prontos para você:

### 1️⃣ **CI/CD Pipeline** (`.github/workflows/ci-cd.yml`)

**Quando executa:** Push para main/master, Pull Requests

**O que faz:**
- ✅ Testa código (Python + Node.js)
- ✅ Lint e validação
- ✅ Build de imagens Docker
- ✅ Push para GitHub Container Registry
- ✅ Deploy para múltiplas plataformas (configurável)

**Plataformas suportadas:**
- GitHub Container Registry (GHCR)
- Docker Hub
- VPS (SSH)
- Railway
- Render
- AWS ECS

---

### 2️⃣ **Docker Compose Deploy** (`.github/workflows/docker-compose-deploy.yml`)

**Quando executa:** Push para main/master, manual

**O que faz:**
- ✅ Deploy simples com docker-compose
- ✅ Health checks automáticos
- ✅ Migrations do banco
- ✅ Backup opcional

**Ideal para:** VPS, servidores dedicados

---

### 3️⃣ **Preview PR** (`.github/workflows/preview-pr.yml`)

**Quando executa:** Ao abrir/atualizar Pull Request

**O que faz:**
- ✅ Cria ambiente de preview
- ✅ Comenta no PR com URLs
- ✅ Cleanup automático

**Ideal para:** Review de código, testes

---

## Deployment Platforms

### 🎯 Onde você pode fazer deploy:

| Platform | Custo | Complexidade | URL Exemplo |
|----------|-------|--------------|-------------|
| **GitHub Pages** | Grátis | Baixa | `https://username.github.io/myps` |
| **Railway** | Grátis → $5/mês | Baixa | `https://myps-production.up.railway.app` |
| **Render** | Grátis → $7/mês | Baixa | `https://myps.onrender.com` |
| **Vercel** (Frontend) | Grátis → $20/mês | Baixa | `https://myps.vercel.app` |
| **Netlify** (Frontend) | Grátis → $19/mês | Baixa | `https://myps.netlify.app` |
| **Heroku** | $5-7/mês | Média | `https://myps.herokuapp.com` |
| **VPS (DigitalOcean)** | $6-12/mês | Média | `https://seudominio.com` ou IP |
| **AWS ECS** | ~$30/mês | Alta | `https://seudominio.com` |
| **Google Cloud Run** | Pay-as-you-go | Média | `https://myps-xyz.run.app` |
| **Azure App Service** | ~$13/mês | Média | `https://myps.azurewebsites.net` |

---

## URL Configuration

### 📡 Como saber qual será sua URL:

#### **Opção 1: GitHub Container Registry (Padrão)**
```
Suas imagens Docker:
- ghcr.io/SEU_USUARIO/myps-frontend:latest
- ghcr.io/SEU_USUARIO/myps-backend:latest

URL de acesso: Depende da plataforma de hospedagem
```

#### **Opção 2: Railway** ⭐ (Recomendado para começar)
```bash
# Após criar conta no Railway e conectar o GitHub:

Frontend: https://myps-frontend-production.up.railway.app
Backend:  https://myps-backend-production.up.railway.app

# Railway gera automaticamente essas URLs!
```

**Como descobrir a URL no Railway:**
1. Acesse https://railway.app
2. Faça login com GitHub
3. Conecte seu repositório
4. Railway mostra as URLs no dashboard
5. URLs são geradas automaticamente no formato: `https://[service]-production.up.railway.app`

#### **Opção 3: Render** ⭐ (Também fácil)
```bash
Frontend: https://myps-frontend.onrender.com
Backend:  https://myps-backend.onrender.com

# Você escolhe o nome ao criar o serviço!
```

**Como descobrir a URL no Render:**
1. Acesse https://render.com
2. Crie novo "Web Service"
3. Conecte seu repositório GitHub
4. Escolha o nome (ex: `myps-frontend`)
5. URL será: `https://[seu-nome].onrender.com`

#### **Opção 4: Vercel (Frontend apenas)**
```bash
Frontend: https://myps.vercel.app
# ou domínio customizado: https://seuapp.com
```

**Como descobrir a URL no Vercel:**
1. Acesse https://vercel.com
2. Importe projeto do GitHub
3. Vercel usa o nome do repositório: `https://myps.vercel.app`
4. Pode customizar depois no dashboard

#### **Opção 5: VPS (DigitalOcean, AWS, etc)**
```bash
# Você controla totalmente:
http://SEU_IP:8081      # Frontend
http://SEU_IP:8001      # Backend

# Com domínio customizado:
https://app.seudominio.com  # Frontend
https://api.seudominio.com  # Backend
```

#### **Opção 6: Localhost (Desenvolvimento)**
```bash
http://localhost:8081       # Frontend
http://localhost:8001/api/  # Backend
http://localhost:9000       # Jupyter
http://localhost:5051       # PgAdmin
```

---

## Secrets Configuration

### 🔐 Secrets que você precisa configurar no GitHub:

**Acesse:** GitHub → Seu Repositório → Settings → Secrets and variables → Actions

#### **Obrigatórios (GHCR - já funciona automaticamente):**
```
✅ GITHUB_TOKEN - Gerado automaticamente pelo GitHub
```

#### **Opcionais - Docker Hub:**
```yaml
DOCKERHUB_USERNAME: seu_usuario_dockerhub
DOCKERHUB_TOKEN: seu_token_dockerhub
```

**Como obter:**
1. Acesse https://hub.docker.com
2. Account Settings → Security → New Access Token
3. Copie o token

#### **Opcionais - VPS Deploy:**
```yaml
VPS_HOST: 192.168.1.100 ou seudominio.com
VPS_USERNAME: root ou seu_usuario
VPS_SSH_KEY: -----BEGIN OPENSSH PRIVATE KEY-----...
VPS_PORT: 22
```

**Como obter SSH Key:**
```bash
# No seu computador:
ssh-keygen -t ed25519 -C "deploy@myps"
cat ~/.ssh/id_ed25519  # Copie todo o conteúdo (PRIVATE KEY)

# No VPS:
cat ~/.ssh/id_ed25519.pub >> ~/.ssh/authorized_keys
```

#### **Opcionais - Railway:**
```yaml
RAILWAY_TOKEN: seu_token_railway
```

**Como obter:**
```bash
# Instale Railway CLI:
npm install -g @railway/cli

# Faça login:
railway login

# Obtenha token:
railway whoami
```

#### **Opcionais - Render:**
```yaml
RENDER_DEPLOY_HOOK: https://api.render.com/deploy/srv-xxx?key=yyy
```

**Como obter:**
1. Render Dashboard → Seu Service → Settings
2. Procure por "Deploy Hook"
3. Copie a URL

#### **Opcionais - AWS:**
```yaml
AWS_ACCESS_KEY_ID: AKIA...
AWS_SECRET_ACCESS_KEY: sua_secret_key
AWS_REGION: us-east-1
```

#### **Opcionais - Produção:**
```yaml
DB_PASSWORD: senha_forte_do_banco
DJANGO_SECRET_KEY: chave_secreta_django_longa
ALLOWED_HOSTS: seudominio.com,www.seudominio.com
FRONTEND_URL: https://seudominio.com
BACKEND_URL: https://api.seudominio.com
```

---

## Deployment Process

### 🚀 Passo a Passo Completo:

#### **Etapa 1: Preparação Local**

```bash
# 1. Certifique-se que tudo está commitado
git status

# 2. Adicione tudo se necessário
git add .
git commit -m "Setup deployment workflows"

# 3. Configure usuário Git (se ainda não fez)
git config --global user.name "Seu Nome"
git config --global user.email "seu@email.com"
```

#### **Etapa 2: Criar Repositório no GitHub**

```bash
# No GitHub (https://github.com/new):
# 1. Clique em "New repository"
# 2. Nome: myps (ou outro nome)
# 3. Descrição: Full Stack Template with BMad Framework
# 4. Public ou Private (sua escolha)
# 5. NÃO marque "Add README" (já temos)
# 6. Clique "Create repository"

# 7. No seu terminal, conecte o repositório:
git remote add origin https://github.com/SEU_USUARIO/myps.git
git branch -M main
git push -u origin main
```

#### **Etapa 3: Habilitar GitHub Actions**

```bash
# No GitHub, vá para:
# Seu Repositório → Actions → "I understand my workflows, go ahead and enable them"

# Os workflows serão executados automaticamente no próximo push!
```

#### **Etapa 4: Escolha sua Plataforma de Deploy**

##### **Opção A: Railway** ⭐ (Mais Fácil)

1. **Acesse:** https://railway.app
2. **Login com GitHub**
3. **New Project → Deploy from GitHub repo**
4. **Selecione:** seu repositório `myps`
5. **Railway detecta automaticamente:** `docker-compose.yml`
6. **Configure variáveis de ambiente:**
   - `POSTGRES_PASSWORD`: senha_forte
   - `DJANGO_SECRET_KEY`: chave_secreta
7. **Deploy automático!**
8. **URLs geradas:**
   - Frontend: `https://myps-frontend-production.up.railway.app`
   - Backend: `https://myps-backend-production.up.railway.app`

**Como ver sua URL:**
- Dashboard do Railway → Seu Projeto → Frontend/Backend → Aba "Settings" → "Domains"

---

##### **Opção B: Render** ⭐ (Também Fácil)

1. **Acesse:** https://render.com
2. **Login com GitHub**
3. **New → Web Service**
4. **Conecte:** seu repositório
5. **Configure:**
   - **Name:** `myps-frontend`
   - **Environment:** Docker
   - **Docker Command:** (deixe em branco, usa Dockerfile)
6. **Repeat para backend:**
   - **Name:** `myps-backend`
7. **Configure banco:**
   - **New → PostgreSQL**
   - Copie a URL de conexão interna
8. **Deploy!**

**Suas URLs:**
- Frontend: `https://myps-frontend.onrender.com`
- Backend: `https://myps-backend.onrender.com`

---

##### **Opção C: Vercel (Frontend apenas)**

```bash
# 1. Instale Vercel CLI:
npm install -g vercel

# 2. No diretório frontend:
cd frontend

# 3. Deploy:
vercel

# 4. Siga as perguntas:
# - Set up and deploy? Yes
# - Which scope? Sua conta
# - Link to existing project? No
# - Project name? myps-frontend
# - Directory? ./
# - Override settings? No

# 5. Deploy de produção:
vercel --prod
```

**Sua URL:**
- `https://myps-frontend.vercel.app`

**Como ver no dashboard:**
- https://vercel.com/dashboard → Seu projeto → Aba "Domains"

---

##### **Opção D: VPS (DigitalOcean, AWS, etc)**

```bash
# 1. No VPS, instale Docker:
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

# 2. Clone seu repositório:
git clone https://github.com/SEU_USUARIO/myps.git
cd myps

# 3. Configure .env:
nano .env
# Adicione suas variáveis de ambiente

# 4. Inicie:
docker compose up -d

# 5. Verifique:
docker compose ps
curl http://localhost:8001/api/health
```

**Suas URLs:**
- Frontend: `http://SEU_IP:8081`
- Backend: `http://SEU_IP:8001/api/`

**Com domínio customizado:**
1. Configure DNS apontando para seu IP
2. Configure nginx como reverse proxy
3. Instale SSL com Let's Encrypt

---

##### **Opção E: GitHub Container Registry + Qualquer Servidor**

```bash
# Imagens são automaticamente publicadas em:
# ghcr.io/SEU_USUARIO/myps-frontend:latest
# ghcr.io/SEU_USUARIO/myps-backend:latest

# No servidor:
docker pull ghcr.io/SEU_USUARIO/myps-frontend:latest
docker pull ghcr.io/SEU_USUARIO/myps-backend:latest

docker run -d -p 8081:8081 ghcr.io/SEU_USUARIO/myps-frontend:latest
docker run -d -p 8001:8001 ghcr.io/SEU_USUARIO/myps-backend:latest
```

---

#### **Etapa 5: Configurar Secrets (se necessário)**

```bash
# No GitHub:
# Repositório → Settings → Secrets and variables → Actions
# → New repository secret

# Adicione os secrets necessários conforme a plataforma escolhida
```

#### **Etapa 6: Trigger Deploy**

```bash
# Opção 1: Push automático
git add .
git commit -m "Configure deployment"
git push origin main

# Opção 2: Manual (GitHub Actions)
# GitHub → Actions → Workflow → "Run workflow"
```

#### **Etapa 7: Monitorar Deploy**

```bash
# No GitHub:
# Actions → Ver o workflow em execução

# Acompanhe cada job:
# - Test (testes)
# - Build (construir imagens)
# - Deploy (publicar)
```

#### **Etapa 8: Acessar Aplicação**

```bash
# Depende da plataforma:

# Railway: https://myps-frontend-production.up.railway.app
# Render: https://myps-frontend.onrender.com
# Vercel: https://myps.vercel.app
# VPS: http://SEU_IP:8081
# GHCR: docker pull ghcr.io/SEU_USUARIO/myps-frontend:latest
```

---

## Platform-Specific Guides

### 🚂 Railway (Recomendado)

**Vantagens:**
- ✅ Deploy automático do GitHub
- ✅ HTTPS grátis
- ✅ Banco PostgreSQL incluído
- ✅ Logs em tempo real
- ✅ Fácil rollback

**URL Format:**
```
https://[service-name]-production.up.railway.app
```

**Como descobrir sua URL:**
1. Dashboard → Projeto → Service
2. Aba "Settings" → Seção "Domains"
3. Clique "Generate Domain"
4. URL é exibida e ativa imediatamente

**Limites do plano grátis:**
- $5 de crédito grátis/mês
- Suficiente para desenvolvimento e testes

---

### 🎨 Render

**Vantagens:**
- ✅ SSL grátis
- ✅ Deploy automático
- ✅ PostgreSQL grátis
- ✅ Preview de PR

**URL Format:**
```
https://[seu-nome-escolhido].onrender.com
```

**Como descobrir sua URL:**
1. Dashboard → Service
2. URL está no topo da página
3. Formato: `https://nome-do-servico.onrender.com`

**Limites do plano grátis:**
- Serviços dormem após 15min inatividade
- Podem levar ~30s para acordar

---

### ▲ Vercel (Frontend apenas)

**Vantagens:**
- ✅ CDN global
- ✅ Deploy instantâneo
- ✅ Preview automático de PRs
- ✅ Analytics incluído

**URL Format:**
```
https://[repo-name].vercel.app
ou
https://[repo-name]-[usuario].vercel.app
```

**Como descobrir sua URL:**
1. Vercel Dashboard → Projeto
2. URL principal exibida no topo
3. Pode adicionar domínio customizado grátis

---

### 💧 DigitalOcean / VPS

**Vantagens:**
- ✅ Controle total
- ✅ Recursos dedicados
- ✅ Sem limites de sleep

**URL:**
```
http://SEU_IP:8081 (sem domínio)
https://seudominio.com (com domínio)
```

**Como configurar domínio:**
1. Compre domínio (Namecheap, Google Domains, etc)
2. Configure DNS A record apontando para IP do VPS
3. Instale nginx no VPS
4. Configure reverse proxy
5. Instale SSL com Let's Encrypt

**Custo:**
- ~$6/mês (DigitalOcean droplet básico)
- Domínio: ~$10-15/ano

---

### 📦 GitHub Container Registry (GHCR)

**Vantagens:**
- ✅ Integrado ao GitHub
- ✅ Grátis para públicos
- ✅ Controle de versão

**URLs das imagens:**
```
ghcr.io/[usuario]/myps-frontend:latest
ghcr.io/[usuario]/myps-backend:latest
```

**Como descobrir suas URLs:**
1. GitHub → Seu perfil → Packages
2. Ou: `https://github.com/SEU_USUARIO?tab=packages`
3. Clique no package para ver comandos pull

**Usar em produção:**
```bash
docker pull ghcr.io/SEU_USUARIO/myps-frontend:latest
docker run -d -p 8081:8081 ghcr.io/SEU_USUARIO/myps-frontend:latest
```

---

## Quick Reference: URLs por Plataforma

| Plataforma | URL Padrão | Customizável? | Exemplo |
|------------|------------|---------------|---------|
| Railway | `*.up.railway.app` | ✅ Sim | `myps-prod.up.railway.app` |
| Render | `*.onrender.com` | ✅ Sim | `myps.onrender.com` |
| Vercel | `*.vercel.app` | ✅ Sim | `myps.vercel.app` |
| Netlify | `*.netlify.app` | ✅ Sim | `myps.netlify.app` |
| Heroku | `*.herokuapp.com` | ✅ Sim | `myps.herokuapp.com` |
| Google Cloud Run | `*.run.app` | ❌ Não | `myps-xyz123.run.app` |
| Azure | `*.azurewebsites.net` | ✅ Sim | `myps.azurewebsites.net` |
| VPS (sem domínio) | `http://IP:PORT` | N/A | `http://45.33.12.45:8081` |
| VPS (com domínio) | `https://seudominio.com` | ✅ Total | `https://app.myps.com` |
| GHCR | `ghcr.io/usuario/repo` | ❌ Não | `ghcr.io/user/myps-frontend` |

---

## Troubleshooting Deploy

### ❌ GitHub Actions falha no build

**Problema:** Build step falha

**Solução:**
```bash
# Teste localmente primeiro:
docker compose build

# Se funcionar local, verifique:
# 1. Arquivo Dockerfile está correto
# 2. Paths estão corretos no workflow
# 3. Secrets configurados
```

---

### ❌ Deploy funciona mas app não carrega

**Problema:** 404 ou erro de conexão

**Solução:**
```bash
# Verifique:
# 1. Porta correta na plataforma
# 2. Health check endpoint configurado
# 3. Variáveis de ambiente setadas
# 4. Database conectado

# Logs:
# Railway: Dashboard → Logs
# Render: Dashboard → Logs
# VPS: docker compose logs -f
```

---

### ❌ Frontend não conecta ao backend

**Problema:** CORS error ou connection refused

**Solução:**
```bash
# 1. Configure CORS no Django
# 2. Use URL correta do backend no frontend
# 3. Variável de ambiente BACKEND_URL
# 4. Verifique ALLOWED_HOSTS no Django
```

---

### ❌ Database connection failed

**Problema:** Backend não conecta ao banco

**Solução:**
```bash
# 1. Verifique connection string
# 2. Credentials corretos
# 3. Banco criado na plataforma
# 4. Run migrations:
docker compose exec jupyter_notebook python manage.py migrate
```

---

## Next Steps After Deploy

1. ✅ **Configure domínio customizado** (opcional)
2. ✅ **Configure SSL/HTTPS** (automático na maioria das plataformas)
3. ✅ **Setup monitoring** (Sentry, DataDog, etc)
4. ✅ **Configure backups** automáticos do banco
5. ✅ **Setup CI/CD notifications** (Slack, Discord)
6. ✅ **Configure staging environment**
7. ✅ **Document APIs** com Swagger/OpenAPI
8. ✅ **Setup logging** centralizado

---

## Recomendação do BMad Orchestrator

Para começar rapidamente:

1. **Use Railway** para deploy inicial (grátis, simples)
2. **URL será:** `https://myps-frontend-production.up.railway.app`
3. **Depois migre** para VPS quando crescer

**Ou:**

1. **Use Vercel** para frontend (grátis, rápido)
2. **Use Render** para backend (grátis, banco incluído)
3. **URLs:**
   - Frontend: `https://myps.vercel.app`
   - Backend: `https://myps-api.onrender.com`

---

**Pronto para deploy!** 🚀

Quando criar o repositório no GitHub, volte aqui e siga o "Deployment Process" passo a passo.

---

*Documentation maintained by BMad Orchestrator*
*Version 1.0.0 - October 2025*
