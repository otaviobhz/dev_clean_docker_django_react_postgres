# 🚀 Quick Start - Scripts de Deploy e Commit

Scripts `.sh` para deploy e commit fácil - **SEM necessidade de aliases!**

## 📦 Comandos Disponíveis

### Deploy - Commit + Push + Deploy Automático

```bash
./scripts/commands/deploy.sh "feat: adicionar nova funcionalidade"
```

✅ Faz tudo: commit → push → deploy no VPS

---

### Commit - Commit + Push (SEM Deploy)

```bash
./scripts/commands/commit.sh "docs: atualizar README"
```

✅ Apenas: commit → push (útil para docs, testes, etc)

---

## 💡 Exemplos de Uso

```bash
# Desenvolvimento normal (sem deploy ainda)
./scripts/commands/commit.sh "feat: adicionar formulário de login"
./scripts/commands/commit.sh "test: adicionar testes do formulário"

# Quando estiver pronto para produção
./scripts/commands/deploy.sh "release: sistema de login completo"
```

## 🌐 URLs de Acesso (Após Deploy)

- Frontend: http://10.147.20.52:8081
- API: http://10.147.20.52:8001
- Jupyter: http://10.147.20.52:9000
- PgAdmin: http://10.147.20.52:5051

## 📚 Documentação Completa

- **Comandos Detalhados:** `.bmad-core/data/custom-commands.md`
- **Deploy VPS:** `docs/DEPLOY-VPS-GUIA.md`
- **GitHub Actions:** `.github/workflows/deploy-vps.yml`

---

## 🎯 Fluxo Recomendado

```
Trabalhar → ./scripts/commands/commit.sh → commit → commit → ./scripts/commands/deploy.sh
            (sem deploy enquanto desenvolve)                  (deploy quando pronto)
```

---

## 🔄 Usar em Outros Projetos

Para copiar os scripts para outro projeto:

```bash
./scripts/copy-to-project.sh /caminho/do/novo-projeto
```

Depois é só usar:
```bash
cd /caminho/do/novo-projeto
./scripts/commands/deploy.sh "mensagem"
./scripts/commands/commit.sh "mensagem"
```

---

**Dúvidas?** Veja a documentação completa em `.bmad-core/data/custom-commands.md`
