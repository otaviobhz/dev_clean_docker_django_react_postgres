# 📋 Fluxo de Trabalho - Guia Completo

## 🎯 Visão Geral

Este projeto usa **duas branches** para garantir que o código em produção seja sempre estável:

- **`dev`** → Branch de desenvolvimento (onde você trabalha)
- **`main`** → Branch de produção (só recebe código testado e pronto)

**Deploy automático** acontece apenas quando código é enviado para `main`.

---

## 🌿 Entendendo as Branches

### Branch `dev` (Desenvolvimento)
- É onde você trabalha no dia a dia
- Pode commitar à vontade sem medo
- NÃO dispara deploy automático
- É a sua "área de trabalho"

### Branch `main` (Produção)
- Só recebe código testado e aprovado
- **Qualquer push para main dispara deploy automático no VPS**
- É a branch "sagrada" - só código pronto entra aqui
- Reflete exatamente o que está rodando no servidor

---

## 🚀 Comandos Disponíveis

### 1️⃣ `commit` - Salvar Trabalho (SEM Deploy)

**Quando usar:**
- Quando você quer salvar seu progresso
- Código ainda não está pronto para produção
- Você está no meio de uma funcionalidade
- Quer fazer backup do código

**O que acontece:**
1. ✅ Commit é criado na branch `dev`
2. ✅ Push é enviado para GitHub (branch `dev`)
3. ❌ Deploy **NÃO** é executado

**Como usar:**
```bash
commit "fix: corrigindo bug no formulário"
commit "wip: trabalhando na feature X"
commit "refactor: melhorando código do componente Y"
```

**Resultado:**
```
✅ COMMIT SALVO EM DEV
ℹ️  Código salvo na branch 'dev' (desenvolvimento)
ℹ️  Deploy NÃO foi executado (só acontece na main)
```

---

### 2️⃣ `deploy` - Fazer Deploy (Merge dev→main)

**Quando usar:**
- Funcionalidade está pronta e testada
- Código está funcionando corretamente
- Você quer que vá para produção
- Quer atualizar o servidor VPS

**O que acontece:**
1. ✅ Faz commit das mudanças pendentes na `dev` (se houver)
2. ✅ Push da branch `dev` para GitHub
3. ✅ Faz merge de `dev` → `main`
4. ✅ Push da `main` para GitHub
5. 🚀 **Deploy automático é disparado no VPS!**
6. ✅ Volta para branch `dev` para você continuar trabalhando

**Como usar:**
```bash
deploy "feat: adicionar sistema de relatórios"
deploy "fix: corrigir bug crítico de segurança"
deploy "chore: atualizar dependências"
```

**Resultado:**
```
✅ DEPLOY INICIADO COM SUCESSO!
📊 Acompanhe o deploy em tempo real:
   https://github.com/otaviobhz/dev_clean_docker_django_react_postgres/actions

⏱️  Aguarde ~2-3 minutos para o deploy completar

🌐 Aplicação estará disponível em:
   - Frontend: http://10.147.20.52:8081
   - API: http://10.147.20.52:8001
```

---

## 📊 Fluxo de Trabalho Completo

### Cenário 1: Desenvolvendo uma Nova Feature

```bash
# 1. Fazer mudanças no código
vim src/components/NovoComponente.jsx

# 2. Salvar progresso (várias vezes se quiser)
commit "wip: começando novo componente"
# ... continua trabalhando ...
commit "wip: adicionando validação"
# ... continua trabalhando ...
commit "feat: finalizar novo componente"

# 3. Testar localmente
npm run dev

# 4. Quando estiver pronto e testado
deploy "feat: adicionar componente de notificações"

# 5. Aguardar ~2-3 minutos
# 6. Acessar http://10.147.20.52:8081 e verificar
```

### Cenário 2: Correção de Bug

```bash
# 1. Identificar e corrigir bug
vim src/utils/helpers.js

# 2. Se quiser salvar antes de testar
commit "wip: investigando bug"

# 3. Corrigir o bug
# ... editar código ...

# 4. Testar localmente
npm run dev

# 5. Quando estiver funcionando
deploy "fix: corrigir erro de validação"
```

### Cenário 3: Várias Mudanças Pequenas

```bash
# Durante o dia, você faz vários commits
commit "docs: atualizar README"
commit "style: ajustar cores do botão"
commit "refactor: melhorar função X"
commit "fix: corrigir typo"

# No final do dia, quando tudo está ok
deploy "chore: melhorias gerais e correções"
```

---

## 🔍 Verificando Status

### Ver em qual branch você está
```bash
git branch
```

Resultado:
```
* dev        ← asterisco mostra onde você está
  main
```

### Ver mudanças não commitadas
```bash
git status
```

### Ver histórico de commits
```bash
git log --oneline -10
```

---

## ⚠️ Situações Importantes

### "Esqueci de salvar antes de fazer deploy"
**Não tem problema!** O comando `deploy` salva automaticamente qualquer mudança pendente antes de fazer o merge.

### "Fiz deploy mas tem um bug"
```bash
# 1. Corrigir o bug rapidamente
vim src/problema.js

# 2. Deploy imediato
deploy "hotfix: corrigir bug crítico em produção"
```

### "Quero ver o que está em produção"
```bash
# Mudar para branch main temporariamente
git checkout main

# Ver o código que está rodando
cat src/arquivo.js

# Voltar para dev
git checkout dev
```

### "Cometi na branch errada"
Se você acidentalmente commitou na `main`:
```bash
# Voltar para dev
git checkout dev

# Trazer as mudanças
git cherry-pick <commit-hash>
```

---

## 🚨 Regras Importantes

### ❌ NÃO FAÇA:
1. **NÃO commite direto na `main`**
   - Sempre trabalhe na `dev`
   - Use `deploy` para levar código para `main`

2. **NÃO faça push manual para `main`**
   - O comando `deploy` faz isso automaticamente
   - Push manual pode causar conflitos

3. **NÃO delete a branch `dev`**
   - É sua branch principal de trabalho

### ✅ FAÇA:
1. **Sempre trabalhe na `dev`**
   - É para isso que ela existe

2. **Use `commit` frequentemente**
   - Salve seu progresso várias vezes
   - É melhor ter muitos commits pequenos

3. **Use `deploy` quando estiver pronto**
   - Código testado e funcionando
   - Pronto para ir para produção

4. **Teste localmente antes de fazer deploy**
   ```bash
   npm run dev  # testar frontend
   # ou
   docker compose up  # testar aplicação completa
   ```

---

## 🎓 Convenções de Commits

Use prefixos para organizar seus commits:

- **feat:** Nova funcionalidade
  ```bash
  commit "feat: adicionar filtro de busca"
  deploy "feat: sistema de chat completo"
  ```

- **fix:** Correção de bug
  ```bash
  commit "fix: corrigir erro de validação"
  deploy "fix: resolver problema de login"
  ```

- **refactor:** Melhoria de código (sem mudar funcionalidade)
  ```bash
  commit "refactor: simplificar função de autenticação"
  ```

- **style:** Mudanças visuais
  ```bash
  commit "style: ajustar espaçamento dos botões"
  ```

- **docs:** Documentação
  ```bash
  commit "docs: atualizar guia de instalação"
  ```

- **chore:** Tarefas gerais
  ```bash
  commit "chore: atualizar dependências"
  ```

- **wip:** Work in Progress (trabalho em andamento)
  ```bash
  commit "wip: começando implementação do dashboard"
  ```

- **hotfix:** Correção urgente em produção
  ```bash
  deploy "hotfix: corrigir bug crítico de segurança"
  ```

---

## 📈 Exemplo de Dia de Trabalho

```bash
# 09:00 - Começar trabalho
commit "wip: começando feature de relatórios"

# 10:30 - Salvar progresso
commit "wip: adicionar componente de gráficos"

# 12:00 - Almoço (salvar antes)
commit "wip: implementar filtros de data"

# 14:00 - Continuar
commit "wip: adicionar exportação para Excel"

# 16:00 - Finalizar e testar localmente
npm run dev
# ... testar tudo ...

# 16:30 - Feature pronta, fazer deploy
deploy "feat: sistema completo de relatórios"

# 17:00 - Verificar em produção
# Abrir http://10.147.20.52:8081
# ✅ Tudo funcionando!

# Fim do dia ✨
```

---

## 🔧 Troubleshooting

### Conflito ao fazer merge
Se aparecer conflito durante o `deploy`:
```bash
# 1. Ver quais arquivos têm conflito
git status

# 2. Abrir e resolver conflitos manualmente
vim arquivo-com-conflito.js

# 3. Marcar como resolvido
git add arquivo-com-conflito.js

# 4. Continuar o merge
git commit -m "Merge branch 'dev' into 'main'"

# 5. Enviar para produção
git push origin main

# 6. Voltar para dev
git checkout dev
```

### Deploy não está funcionando
1. Verificar GitHub Actions:
   ```
   https://github.com/otaviobhz/dev_clean_docker_django_react_postgres/actions
   ```

2. Verificar runner no servidor:
   ```bash
   ssh otavio@10.147.20.52
   cd ~/actions-runner
   sudo ./svc.sh status
   ```

3. Ver logs do deploy:
   - Acessar link do GitHub Actions
   - Clicar no workflow que está rodando
   - Ver detalhes dos logs

---

## 🎯 Resumo Rápido

| Comando | Quando usar | Deploy? |
|---------|-------------|---------|
| `commit "mensagem"` | Salvar progresso | ❌ NÃO |
| `deploy "mensagem"` | Código pronto para produção | ✅ SIM |

**Lembre-se:**
- 🟢 **dev** = área de trabalho (livre para experimentar)
- 🔴 **main** = produção (só código testado)
- 🚀 **deploy** = merge dev→main + dispara deploy automático

---

## 📚 Links Úteis

- **GitHub Actions (ver deploys):**
  https://github.com/otaviobhz/dev_clean_docker_django_react_postgres/actions

- **Frontend em Produção:**
  http://10.147.20.52:8081

- **API em Produção:**
  http://10.147.20.52:8001

- **Documentação Completa:**
  - `docs/SETUP-GITHUB-RUNNER.md` - Como funciona o runner
  - `docs/COMO-TESTAR-GITHUB-ACTIONS.md` - Como testar workflows
  - `docs/DEPLOY-RAILWAY-GUIA.md` - Deploy alternativo (Railway)

---

## ✨ Dicas Profissionais

1. **Commit frequentemente na dev**
   - Não tenha medo de commitar
   - É melhor ter muitos commits pequenos

2. **Teste antes de fazer deploy**
   - Sempre rode localmente antes
   - Verifique se tudo funciona

3. **Use mensagens descritivas**
   - "fix: corrigir login" ✅
   - "mudanças" ❌

4. **Deploy só quando estiver 100% pronto**
   - Produção não é lugar para testar
   - Use `dev` para experimentar

5. **Acompanhe o deploy no GitHub Actions**
   - Veja se completou com sucesso
   - Verifique os logs se der erro

---

**Criado em:** 2025-10-01
**Última atualização:** 2025-10-01
**Versão:** 1.0
