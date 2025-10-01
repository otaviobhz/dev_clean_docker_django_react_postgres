# ⚡ Comandos Rápidos - Cheat Sheet

## 🎯 Comandos Principais

### Salvar Trabalho (SEM Deploy)
```bash
commit "mensagem"
```
- Salva na branch `dev`
- NÃO faz deploy
- Use quando código ainda não está pronto

### Fazer Deploy (Código Pronto)
```bash
deploy "mensagem"
```
- Merge `dev` → `main`
- Dispara deploy automático
- Aguarde 2-3 minutos
- Acesse: http://10.147.20.52:8081

---

## 📝 Exemplos Práticos

### Salvando progresso
```bash
commit "wip: trabalhando na feature X"
commit "fix: corrigindo bug Y"
commit "refactor: melhorando código Z"
```

### Fazendo deploy
```bash
deploy "feat: nova funcionalidade pronta"
deploy "fix: corrigir bug crítico"
deploy "chore: atualizar versão"
```

---

## 🔍 Comandos Git Úteis

### Ver status
```bash
git status
```

### Ver branch atual
```bash
git branch
```

### Ver histórico
```bash
git log --oneline -10
```

### Trocar de branch
```bash
git checkout dev   # voltar para dev
git checkout main  # ver produção
```

---

## 🌐 URLs Importantes

| Serviço | URL |
|---------|-----|
| Frontend | http://10.147.20.52:8081 |
| API | http://10.147.20.52:8001 |
| Jupyter | http://10.147.20.52:9000 |
| PgAdmin | http://10.147.20.52:5051 |
| GitHub Actions | https://github.com/otaviobhz/dev_clean_docker_django_react_postgres/actions |

---

## ✅ Regras de Ouro

1. ✅ Trabalhe sempre na `dev`
2. ✅ Use `commit` frequentemente
3. ✅ Teste antes de fazer `deploy`
4. ✅ Use `deploy` só quando estiver pronto
5. ❌ NÃO commite direto na `main`

---

## 🚨 Resolução Rápida de Problemas

### Deploy não funcionou?
```bash
# Ver logs
https://github.com/otaviobhz/dev_clean_docker_django_react_postgres/actions

# Ver runner no servidor
ssh otavio@10.147.20.52
cd ~/actions-runner
sudo ./svc.sh status
```

### Preciso desfazer último commit?
```bash
git reset --soft HEAD~1  # desfaz commit mas mantém mudanças
```

### Quero descartar todas as mudanças?
```bash
git reset --hard HEAD  # ⚠️ CUIDADO: perde todas as mudanças
```

---

## 📋 Convenções de Commit

| Prefixo | Uso | Exemplo |
|---------|-----|---------|
| `feat:` | Nova funcionalidade | `feat: adicionar login` |
| `fix:` | Correção de bug | `fix: corrigir validação` |
| `refactor:` | Melhoria de código | `refactor: simplificar função` |
| `style:` | Mudanças visuais | `style: ajustar cores` |
| `docs:` | Documentação | `docs: atualizar README` |
| `chore:` | Tarefas gerais | `chore: atualizar deps` |
| `wip:` | Trabalho em andamento | `wip: começando feature` |
| `hotfix:` | Correção urgente | `hotfix: bug crítico` |

---

## 🔄 Fluxo Visual

```
┌─────────────────────────────────────────┐
│  1. Trabalhar na dev                    │
│     git checkout dev                    │
│                                         │
│  2. Fazer mudanças                      │
│     vim src/componente.jsx              │
│                                         │
│  3. Salvar progresso (quantas vezes     │
│     quiser)                             │
│     commit "wip: trabalhando"           │
│                                         │
│  4. Testar localmente                   │
│     npm run dev                         │
│                                         │
│  5. Quando estiver pronto               │
│     deploy "feat: funcionalidade X"     │
│                                         │
│  6. Aguardar 2-3 minutos                │
│                                         │
│  7. Verificar em produção               │
│     http://10.147.20.52:8081            │
└─────────────────────────────────────────┘
```

---

## 💡 Dica do Dia

**Commite frequentemente na dev, faça deploy raramente para main!**

- `dev` = seu playground (experimente à vontade)
- `main` = produção (só código 100% pronto)

---

**Para guia completo:** Leia `docs/FLUXO-DE-TRABALHO.md`
