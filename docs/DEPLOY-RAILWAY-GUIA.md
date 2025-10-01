# Deploy no Railway - Guia Completo

## 🚂 Por que Railway?

- ✅ **Grátis para começar** ($5 crédito/mês)
- ✅ **Deploy automático** do GitHub
- ✅ **URL gerada automaticamente**
- ✅ **HTTPS grátis**
- ✅ **Banco PostgreSQL incluído**
- ✅ **Logs em tempo real**
- ✅ **Fácil rollback**

---

## 📋 Passo a Passo

### **Passo 1: Criar Conta**

1. Acesse: https://railway.app
2. Clique em **"Start a New Project"**
3. Faça login com **GitHub**
4. Autorize o Railway

---

### **Passo 2: Deploy do GitHub**

1. Clique em **"New Project"**
2. Selecione **"Deploy from GitHub repo"**
3. Procure: `dev_clean_docker_django_react_postgres`
4. Clique no repositório

---

### **Passo 3: Configurar Serviços**

Railway vai detectar automaticamente:
- ✅ Frontend (React)
- ✅ Backend (Django)
- ✅ PostgreSQL

**Aceite tudo e clique "Deploy"**

---

### **Passo 4: Aguardar Deploy**

Railway vai:
1. ✅ Buildar as imagens Docker
2. ✅ Criar banco PostgreSQL
3. ✅ Gerar URLs públicas
4. ✅ Configurar HTTPS

**Tempo:** ~3-5 minutos

---

### **Passo 5: Ver suas URLs**

1. No dashboard do Railway
2. Clique em cada serviço
3. Aba **"Settings"** → **"Domains"**
4. Clique **"Generate Domain"**

**Suas URLs:**
- Frontend: `https://dev-clean-docker-django-react-postgres-frontend.up.railway.app`
- Backend: `https://dev-clean-docker-django-react-postgres-backend.up.railway.app`

---

### **Passo 6: Configurar Variáveis de Ambiente**

1. Clique no serviço **Backend**
2. Aba **"Variables"**
3. Adicione:

```
POSTGRES_HOST=postgres.railway.internal
POSTGRES_DB=railway
POSTGRES_USER=postgres
POSTGRES_PASSWORD=[Auto gerado pelo Railway]
DJANGO_ALLOWED_HOSTS=*.railway.app
DJANGO_SECRET_KEY=[Gere uma chave]
```

4. Clique **"Save"**

---

### **Passo 7: Testar**

Acesse a URL do frontend:
```
https://sua-app.up.railway.app
```

Deve mostrar o dashboard com ✅✅✅

---

## 🔄 Deploy Automático com GitHub Actions

### **Opção 1: Deploy Manual pelo Railway (Recomendado)**

Railway já faz deploy automático quando você faz push!

**Sem precisar de GitHub Actions!**

---

### **Opção 2: Com GitHub Actions (Avançado)**

**1. Obter Railway Token:**

```bash
npm install -g @railway/cli
railway login
railway whoami
```

Copie o token que aparece.

**2. Adicionar Secret no GitHub:**

1. GitHub → Repositório → Settings → Secrets → Actions
2. New repository secret
3. Nome: `RAILWAY_TOKEN`
4. Value: Cole o token
5. Add secret

**3. Ativar Workflow:**

O workflow já está criado em `.github/workflows/deploy-railway.yml`

Próximo push vai fazer deploy automático!

---

## 📊 Monitorar Deploy

### **Ver Logs:**

1. Dashboard Railway → Serviço
2. Aba **"Deployments"**
3. Clique no deploy
4. Veja logs em tempo real

### **Ver Métricas:**

1. Dashboard → Serviço
2. Aba **"Metrics"**
3. Veja:
   - CPU usage
   - Memory usage
   - Network traffic

---

## 🐛 Troubleshooting

### **Erro: "Service failed to start"**

**Solução:**
1. Veja os logs
2. Procure por erros de porta
3. Railway usa `PORT` env var, não porta fixa

**Fixar:**
Edite `docker-compose.yml` para usar `$PORT`:
```yaml
ports:
  - "${PORT:-8081}:8081"  # Frontend
  - "${PORT:-8001}:8001"  # Backend
```

---

### **Erro: "Database connection failed"**

**Solução:**
1. Verifique variáveis de ambiente
2. Use o host interno: `postgres.railway.internal`
3. Não use `localhost`

---

### **Erro: "Out of credits"**

**Solução:**
1. Railway grátis tem $5/mês
2. Adicione cartão de crédito para mais
3. Ou otimize recursos (menos instâncias)

---

## 💰 Custos

### **Plano Gratuito:**
- ✅ $5 crédito/mês
- ✅ Suficiente para:
  - 1 frontend
  - 1 backend
  - 1 banco PostgreSQL
  - ~100-500h/mês de uso

### **Plano Pago:**
- 💳 $5/mês + uso
- ✅ Mais recursos
- ✅ Mais uptime
- ✅ Suporte prioritário

---

## 🎯 Próximos Passos

Depois do deploy:

1. ✅ Configure domínio customizado (se quiser)
2. ✅ Configure variáveis de produção
3. ✅ Configure backups do banco
4. ✅ Monitore uso de recursos
5. ✅ Configure alertas

---

## 🔗 Links Úteis

- Dashboard: https://railway.app/dashboard
- Docs: https://docs.railway.app
- Status: https://railway.statuspage.io

---

**Boa sorte com o deploy! 🚀**
