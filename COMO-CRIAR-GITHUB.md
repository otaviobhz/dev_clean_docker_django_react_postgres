# Como Criar o Repositório GitHub com o Script

## 📋 Passo a Passo Completo

### **Passo 1: Obter o Token do GitHub**

1. **Acesse:** https://github.com/settings/tokens/new

2. **Preencha:**
   - **Note:** `MyPS Deploy Token`
   - **Expiration:** `90 days` (ou No expiration)
   - **Select scopes:** Marque **`repo`** (todos os sub-items serão marcados automaticamente)

3. **Clique em:** `Generate token`

4. **COPIE O TOKEN!** (começa com `ghp_...`)
   ⚠️ **ATENÇÃO:** Você só verá o token UMA VEZ! Guarde-o!

---

### **Passo 2: Configure o Token no Terminal**

No seu terminal WSL/Linux, execute:

```bash
export GH_TOKEN=ghp_seu_token_aqui
```

**Substitua** `ghp_seu_token_aqui` pelo token que você copiou!

**Para verificar se funcionou:**
```bash
echo $GH_TOKEN
# Deve mostrar seu token
```

---

### **Passo 3: Execute o Script**

```bash
# Certifique-se de estar no diretório do projeto
cd /home/otavio/Projetos_Oficial/myps

# Execute o script (PRIVADO por padrão)
python3 utils/create_github_from_existing.py --name dev_clean_docker_django_react_postgres

# OU para criar PÚBLICO (recomendado para portfolio):
python3 utils/create_github_from_existing.py --name dev_clean_docker_django_react_postgres --public

# OU com descrição:
python3 utils/create_github_from_existing.py \
  --name dev_clean_docker_django_react_postgres \
  --description "Full Stack Template - Django + React + PostgreSQL with Docker" \
  --public
```

---

### **Passo 4: O Script Vai Fazer Automaticamente:**

1. ✅ Verificar se git está inicializado (se não, inicializa)
2. ✅ Verificar se há mudanças (se sim, faz commit)
3. ✅ Criar repositório no GitHub com a API
4. ✅ Configurar remote origin (SSH)
5. ✅ Fazer push do código

---

### **Passo 5: Verificar se Funcionou**

Depois que o script rodar, você verá:

```
🎉 Tudo pronto! Repositório criado e código enviado!
🔗 URL: https://github.com/SEU_USUARIO/dev_clean_docker_django_react_postgres
```

**Acesse a URL** para ver seu repositório no GitHub! 🚀

---

## 🔧 Opções do Script

```bash
# Criar privado (padrão)
python3 utils/create_github_from_existing.py --name NOME_DO_REPO

# Criar público
python3 utils/create_github_from_existing.py --name NOME_DO_REPO --public

# Com descrição
python3 utils/create_github_from_existing.py --name NOME_DO_REPO --description "Minha descrição"

# Usar HTTPS em vez de SSH
python3 utils/create_github_from_existing.py --name NOME_DO_REPO --https

# Criar em organização
python3 utils/create_github_from_existing.py --name NOME_DO_REPO --org minha-org

# Mudar branch padrão
python3 utils/create_github_from_existing.py --name NOME_DO_REPO --branch main
```

---

## ❌ Troubleshooting

### Erro: "GH_TOKEN não encontrado"

**Solução:**
```bash
export GH_TOKEN=ghp_seu_token_aqui
```

---

### Erro: "ModuleNotFoundError: No module named 'requests'"

**Solução:**
```bash
pip install requests
# ou
pip3 install requests
```

---

### Erro: "O repositório já existe"

**Soluções:**
1. Escolha outro nome
2. OU delete o repo existente no GitHub primeiro
3. OU use outro nome: `dev_clean_docker_django_react_postgres_v2`

---

### Erro: "401 Unauthorized"

**Soluções:**
1. Token expirado - crie um novo
2. Token inválido - copie corretamente
3. Verifique: `echo $GH_TOKEN`

---

### Erro: "403 Forbidden"

**Soluções:**
1. Token sem permissão `repo` - crie novo token com scope correto
2. Rate limit - aguarde alguns minutos

---

### Erro: "Permission denied (publickey)"

Você está usando SSH mas não tem chave configurada.

**Soluções:**
1. Use `--https` no script
2. OU configure SSH: https://docs.github.com/en/authentication/connecting-to-github-with-ssh

---

## 🔑 Como Configurar SSH (Opcional)

Se você quiser usar SSH em vez de HTTPS:

```bash
# 1. Gerar chave SSH
ssh-keygen -t ed25519 -C "seu@email.com"

# 2. Copiar chave pública
cat ~/.ssh/id_ed25519.pub

# 3. Adicionar no GitHub:
# https://github.com/settings/ssh/new
# Cole a chave pública

# 4. Testar
ssh -T git@github.com
# Deve mostrar: "Hi username! You've successfully authenticated"
```

---

## 📝 Resumo do Comando Completo

```bash
# 1. Configure o token
export GH_TOKEN=ghp_seu_token_aqui

# 2. Execute o script
python3 utils/create_github_from_existing.py \
  --name dev_clean_docker_django_react_postgres \
  --description "Full Stack Template - Django + React + PostgreSQL with Docker" \
  --public

# 3. Pronto! 🎉
```

---

## 🎯 Próximos Passos Após Criar o Repositório

1. ✅ Acesse: https://github.com/SEU_USUARIO/dev_clean_docker_django_react_postgres
2. ✅ Vá em: `Settings` → `Secrets and variables` → `Actions`
3. ✅ Configure os secrets necessários (se quiser fazer deploy)
4. ✅ GitHub Actions vai rodar automaticamente no próximo push!

---

**Boa sorte! 🚀**
