# Como Testar GitHub Actions

## 🎯 3 Formas de Testar

---

## 📱 Método 1: Pelo Site do GitHub (Mais Fácil)

### **Passo 1: Acesse a aba Actions**
```
https://github.com/otaviobhz/dev_clean_docker_django_react_postgres/actions
```

### **Passo 2: Você verá seus workflows:**

| Workflow | Quando Roda | Status |
|----------|-------------|--------|
| **CI/CD Pipeline** | Push para main | ✅ ou ❌ |
| **Docker Compose Deploy** | Push para main | ✅ ou ❌ |
| **Preview Pull Request** | Abrir PR | ✅ ou ❌ |

### **Passo 3: Entender os Status**

**✅ Verde (Success)** = Tudo funcionou!
**❌ Vermelho (Failure)** = Teve erro (normal no início)
**🟡 Amarelo (In Progress)** = Está rodando
**⚪ Cinza (Skipped)** = Pulado

### **Passo 4: Ver Detalhes do Erro**

1. Clique no workflow com ❌
2. Clique no job que falhou
3. Expanda o step que deu erro
4. Leia a mensagem de erro

---

## 🔧 Método 2: Executar Manualmente

### **Via GitHub (Interface)**

1. **Acesse:** https://github.com/otaviobhz/dev_clean_docker_django_react_postgres/actions

2. **Clique** em um workflow (ex: "CI/CD Pipeline")

3. **Clique** no botão **"Run workflow"** (canto direito)

4. **Escolha** a branch: `main`

5. **Clique** em **"Run workflow"** verde

6. **Aguarde** o workflow rodar

7. **Veja** o resultado

### **Via GitHub CLI (Terminal)**

```bash
# Instalar GitHub CLI (se não tiver)
# Windows: winget install GitHub.cli
# Linux: curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg

# Fazer login
gh auth login

# Listar workflows
gh workflow list

# Executar workflow manualmente
gh workflow run "CI/CD Pipeline"

# Ver status
gh run list

# Ver detalhes de um run
gh run view
```

---

## 🧪 Método 3: Testar com Push (Mais Real)

### **Teste 1: Fazer uma Mudança Pequena**

```bash
# 1. Editar README
echo "## Test GitHub Actions" >> README.md

# 2. Commit
git add README.md
git commit -m "test: trigger GitHub Actions"

# 3. Push (vai disparar os workflows)
git push origin main

# 4. Ver no navegador:
# https://github.com/otaviobhz/dev_clean_docker_django_react_postgres/actions
```

### **Teste 2: Criar um Pull Request**

```bash
# 1. Criar nova branch
git checkout -b test-pr

# 2. Fazer mudança
echo "# Test PR" >> README.md
git add README.md
git commit -m "test: create PR"

# 3. Push da branch
git push origin test-pr

# 4. Criar PR no GitHub:
# https://github.com/otaviobhz/dev_clean_docker_django_react_postgres/compare/main...test-pr

# 5. O workflow "Preview Pull Request" vai rodar!
```

---

## 🐛 Troubleshooting: Erros Comuns

### ❌ Erro: "test job failed"

**Causa:** Testes não configurados ainda

**Solução:** Isso é normal! Os workflows têm placeholders para testes.

**Para corrigir temporariamente**, edite `.github/workflows/ci-cd.yml`:

```yaml
# Procure esta linha:
- name: Run backend tests
  run: |
    # cd backend/django_project
    # python manage.py test
    echo "Backend tests placeholder - configure when tests are added"

# Já está como placeholder, então não deve falhar
```

---

### ❌ Erro: "Docker build failed"

**Causa:** Problema no Dockerfile ou falta de dependências

**Solução:**

1. Teste local primeiro:
```bash
docker compose build
```

2. Se funcionar local mas falhar no GitHub:
   - Verifique se todos os arquivos estão no Git
   - Verifique caminhos nos Dockerfiles

---

### ❌ Erro: "Permission denied" ou "403 Forbidden"

**Causa:** Falta de permissão para GitHub Container Registry

**Solução:**

1. Vá em: `Settings` → `Actions` → `General`
2. Role até "Workflow permissions"
3. Selecione: **"Read and write permissions"**
4. Clique em **"Save"**

---

### ❌ Erro: "secrets.DOCKERHUB_USERNAME not found"

**Causa:** Secrets opcionais não configurados

**Solução:**

**Opção 1 (Simples):** Comentar o job opcional no workflow:

```yaml
# Edite .github/workflows/ci-cd.yml
# Comente o job inteiro:

# deploy-docker-hub:
#   name: Deploy to Docker Hub
#   ... todo o job
```

**Opção 2 (Completo):** Configure os secrets:

1. GitHub → Seu repo → Settings → Secrets → Actions
2. New repository secret
3. Adicione os secrets necessários

---

### ❌ Erro: "No space left on device"

**Causa:** Runner do GitHub sem espaço

**Solução:** Adicione cleanup no workflow:

```yaml
- name: Free Disk Space
  run: |
    docker system prune -af
    sudo rm -rf /usr/share/dotnet
    sudo rm -rf /opt/ghc
```

---

## 📊 Ver Logs Completos

### **Via GitHub (Web)**

1. Actions → Workflow run → Job → Step
2. Clique em qualquer step para expandir
3. Copie os logs se necessário

### **Via GitHub CLI**

```bash
# Ver último run
gh run view

# Ver logs de um job específico
gh run view --log

# Baixar logs
gh run download
```

### **Via API**

```bash
# Listar runs
curl -H "Authorization: Bearer $GH_TOKEN" \
  https://api.github.com/repos/otaviobhz/dev_clean_docker_django_react_postgres/actions/runs

# Ver logs de um run específico
curl -H "Authorization: Bearer $GH_TOKEN" \
  https://api.github.com/repos/otaviobhz/dev_clean_docker_django_react_postgres/actions/runs/RUN_ID/logs
```

---

## 🎯 Checklist de Testes

### ✅ Teste Básico (5 min)

- [ ] Acesse: https://github.com/SEU_USUARIO/dev_clean_docker_django_react_postgres/actions
- [ ] Veja se os workflows rodaram
- [ ] Clique em um workflow
- [ ] Veja se tem ✅ ou ❌
- [ ] Se ❌, leia o erro

### ✅ Teste Manual (10 min)

- [ ] Actions → Workflow → "Run workflow"
- [ ] Escolha branch `main`
- [ ] Clique "Run workflow"
- [ ] Aguarde completar
- [ ] Verifique resultado

### ✅ Teste com Push (15 min)

- [ ] Edite um arquivo
- [ ] `git add .`
- [ ] `git commit -m "test"`
- [ ] `git push origin main`
- [ ] Veja Actions rodar automaticamente
- [ ] Verifique resultado

### ✅ Teste com Pull Request (20 min)

- [ ] `git checkout -b test-pr`
- [ ] Faça mudança
- [ ] `git push origin test-pr`
- [ ] Crie PR no GitHub
- [ ] Veja workflow "Preview PR" rodar
- [ ] Verifique comentário no PR

---

## 🔍 Entender o que Cada Workflow Faz

### **1. CI/CD Pipeline** (`.github/workflows/ci-cd.yml`)

**Quando roda:** Push para main/master ou PR

**O que faz:**
1. ✅ **Job: test**
   - Instala Python e Node.js
   - Instala dependências
   - Roda linters (flake8)
   - Build do frontend
   - Roda testes (placeholder)

2. ✅ **Job: build** (só se test passar)
   - Build das imagens Docker (frontend e backend)
   - Push para GitHub Container Registry
   - Usa cache para ser mais rápido

3. ⚠️ **Jobs opcionais** (precisam de secrets):
   - `deploy-docker-hub`: Push para Docker Hub
   - `deploy-vps`: Deploy via SSH
   - `deploy-railway`: Deploy no Railway
   - `deploy-render`: Deploy no Render
   - `deploy-aws-ecs`: Deploy na AWS

4. ✅ **Job: notify**
   - Mostra status do deploy

---

### **2. Docker Compose Deploy** (`.github/workflows/docker-compose-deploy.yml`)

**Quando roda:** Push para main/master ou manual

**O que faz:**
1. Build com docker-compose
2. Inicia serviços
3. Aguarda serviços subirem
4. Faz health checks
5. Roda migrations
6. Mostra info de deploy

**Use para:** Testar se o stack completo funciona

---

### **3. Preview Pull Request** (`.github/workflows/preview-pr.yml`)

**Quando roda:** Abrir/atualizar Pull Request

**O que faz:**
1. Build das imagens
2. Inicia ambiente de preview
3. Comenta no PR com URLs
4. Cleanup quando PR fecha

**Use para:** Ver mudanças antes de mergear

---

## 📈 Monitorar GitHub Actions

### **Via GitHub Insights**

1. Actions → aba "All workflows"
2. Veja estatísticas:
   - Success rate
   - Tempo médio
   - Workflows mais rodados

### **Via Email**

GitHub envia email quando:
- ❌ Workflow falha
- ✅ Workflow volta a funcionar

Configure em: Settings → Notifications

### **Via Badges**

Adicione badge no README:

```markdown
![CI/CD](https://github.com/otaviobhz/dev_clean_docker_django_react_postgres/actions/workflows/ci-cd.yml/badge.svg)
```

---

## 🚀 Próximos Passos

Após testar e garantir que funciona:

1. ✅ Configure secrets para deploy (se quiser)
2. ✅ Adicione testes reais
3. ✅ Configure deploy automático
4. ✅ Adicione notificações (Slack/Discord)
5. ✅ Configure ambientes (staging/production)

---

## 📝 Comandos Rápidos

```bash
# Ver status atual
gh run list --limit 5

# Executar workflow
gh workflow run "CI/CD Pipeline"

# Ver logs do último run
gh run view --log

# Cancelar run em andamento
gh run cancel

# Re-run de um workflow falhado
gh run rerun

# Baixar artefatos
gh run download
```

---

## 🎯 Teste Agora Mesmo!

**Comando rápido para testar:**

```bash
# 1. Fazer mudança
echo "# GitHub Actions Test" >> README.md

# 2. Commit e push
git add README.md
git commit -m "test: GitHub Actions"
git push origin main

# 3. Ver resultado
# https://github.com/otaviobhz/dev_clean_docker_django_react_postgres/actions
```

**Deve levar ~2-5 minutos para completar!**

---

**Boa sorte! 🚀**
