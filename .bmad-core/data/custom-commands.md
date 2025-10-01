# Custom Commands - Deploy & Commit System

## 📋 Visão Geral

Este projeto possui comandos personalizados para gerenciar deploys e commits de forma profissional e documentada.

## 🎯 Comandos Disponíveis

### 1. `deploy` - Deploy Completo

**Descrição:** Faz commit, push e trigger automático do deploy no VPS ZeroTier

**Uso:**
```bash
deploy "mensagem do commit"
```

**Comportamento:**
1. ✅ Adiciona todos os arquivos modificados (git add .)
2. ✅ Cria commit com mensagem fornecida
3. ✅ Faz push para o GitHub
4. ✅ Aciona o workflow de deploy no VPS
5. ✅ Mostra URL para acompanhar o deploy

**Exemplos:**
```bash
deploy "feat: adicionar sistema de autenticação"
deploy "fix: corrigir bug no formulário de login"
deploy "refactor: melhorar performance da API"
```

**Resultado:**
- Código é enviado ao GitHub
- Deploy automático é iniciado no VPS (10.147.20.52)
- Aplicação é atualizada automaticamente

---

### 2. `commit` - Commit Sem Deploy

**Descrição:** Faz commit e push SEM acionar o deploy (apenas atualiza o código no GitHub)

**Uso:**
```bash
commit "mensagem do commit"
```

**Comportamento:**
1. ✅ Adiciona todos os arquivos modificados (git add .)
2. ✅ Cria commit com mensagem fornecida
3. ✅ Faz push para o GitHub
4. ❌ NÃO aciona deploy automático

**Exemplos:**
```bash
commit "docs: atualizar README com instruções"
commit "chore: atualizar dependências do projeto"
commit "style: formatar código com prettier"
```

**Resultado:**
- Código é enviado ao GitHub
- Deploy NÃO é acionado
- Útil para documentação, testes, ou mudanças que não precisam ir para produção imediatamente

---

## 🛠️ Setup Inicial

### Instalação dos Comandos

Execute uma vez no terminal:

```bash
source scripts/setup-aliases.sh
```

### Tornar Permanente (Opcional)

Para os comandos estarem sempre disponíveis, adicione ao seu `~/.bashrc` ou `~/.zshrc`:

```bash
echo 'source /home/otavio/Projetos_Oficial/myps/scripts/setup-aliases.sh' >> ~/.bashrc
```

Depois recarregue:
```bash
source ~/.bashrc
```

---

## 📁 Estrutura de Arquivos

```
myps/
├── scripts/
│   ├── commands/
│   │   ├── deploy.sh       # Script do comando deploy
│   │   └── commit.sh       # Script do comando commit
│   └── setup-aliases.sh    # Configuração dos aliases
└── .bmad-core/
    └── data/
        └── custom-commands.md  # Esta documentação
```

---

## 🔄 Fluxo de Trabalho Recomendado

### Cenário 1: Desenvolvimento Normal
```bash
# Trabalhe no código...
# Quando terminar:
commit "feat: implementar nova funcionalidade"

# Continue trabalhando...
commit "test: adicionar testes unitários"

# Quando estiver pronto para produção:
deploy "release: versão 1.2.0 com novas features"
```

### Cenário 2: Hotfix Urgente
```bash
# Corrija o bug...
deploy "fix: corrigir erro crítico na autenticação"
# Deploy é feito imediatamente!
```

### Cenário 3: Atualizações de Documentação
```bash
# Atualize docs...
commit "docs: melhorar documentação da API"
# Não aciona deploy desnecessário
```

---

## 🎨 Convenções de Commit

Use prefixos semânticos nas mensagens:

- **feat:** Nova funcionalidade
- **fix:** Correção de bug
- **docs:** Apenas documentação
- **style:** Formatação, ponto e vírgula, etc
- **refactor:** Refatoração de código
- **test:** Adição ou correção de testes
- **chore:** Manutenção, deps, config

**Exemplos:**
```bash
deploy "feat: adicionar autenticação JWT"
deploy "fix: corrigir vazamento de memória"
commit "docs: atualizar guia de contribuição"
commit "chore: atualizar pacotes npm"
```

---

## 🚀 Deploy Pipeline

### O que acontece quando você usa `deploy`:

```
┌─────────────────────┐
│  deploy "mensagem"  │
└──────────┬──────────┘
           │
           ▼
    ┌─────────────┐
    │  git add .  │
    └──────┬──────┘
           │
           ▼
    ┌─────────────┐
    │ git commit  │
    └──────┬──────┘
           │
           ▼
    ┌─────────────┐
    │  git push   │
    └──────┬──────┘
           │
           ▼
┌──────────────────────┐
│ GitHub Actions       │
│ Trigger Workflow     │
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│ VPS (10.147.20.52)   │
│ - git pull           │
│ - docker rebuild     │
│ - restart services   │
└──────────────────────┘
```

---

## 🔐 Configuração de Secrets

Para os comandos funcionarem, certifique-se de ter configurado no GitHub:

**Settings → Secrets → Actions:**

```
VPS_HOST = 10.147.20.52
VPS_USERNAME = otavio
VPS_PASSWORD = otarau10
```

---

## 🐛 Troubleshooting

### Comando não encontrado
```bash
# Execute novamente o setup:
source scripts/setup-aliases.sh
```

### Deploy não está funcionando
```bash
# Verifique se o GitHub CLI está instalado:
gh --version

# Se não estiver, instale:
# Ubuntu/Debian:
sudo apt install gh

# MacOS:
brew install gh
```

### Ver logs do último deploy
```bash
# Acesse:
# https://github.com/otaviobhz/dev_clean_docker_django_react_postgres/actions
```

---

## 📊 Monitoramento

### Acompanhar Deploy em Tempo Real

Após usar `deploy`, você pode:

1. **Via Web:** Link será mostrado automaticamente
2. **Via CLI:** `gh run list` e `gh run view`
3. **No Servidor:** `ssh otavio@10.147.20.52` e ver logs Docker

### Status da Aplicação

```bash
# Verificar containers no VPS:
ssh otavio@10.147.20.52
cd /Projetos_Oficial/dev/dev_clean_docker_django_react_postgres
docker compose -f docker-compose.prod.yml ps
```

---

## 💡 Dicas Profissionais

1. **Use `commit` para WIP:** Commits de trabalho em progresso
2. **Use `deploy` para releases:** Apenas quando estiver pronto para produção
3. **Sempre teste localmente** antes de fazer deploy
4. **Acompanhe os logs** após cada deploy
5. **Use branches** para features grandes, depois merge e deploy

---

## 📝 Changelog

| Versão | Data       | Descrição                          |
|--------|------------|------------------------------------|
| 1.0.0  | 2025-10-01 | Criação dos comandos deploy/commit |

---

## 🆘 Suporte

- **Documentação VPS:** `docs/DEPLOY-VPS-GUIA.md`
- **GitHub Actions:** `.github/workflows/deploy-vps.yml`
- **Scripts:** `scripts/commands/`

---

*Documentação gerada e mantida pelo BMAD System*
