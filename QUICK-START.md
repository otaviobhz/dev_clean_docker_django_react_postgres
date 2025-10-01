# 🚀 Quick Start - Custom Commands

Comandos personalizados para deploy e commit fácil!

## ⚡ Setup Rápido (Execute UMA VEZ)

```bash
source scripts/setup-aliases.sh
```

## 📦 Comandos Disponíveis

### `deploy` - Commit + Push + Deploy Automático

```bash
deploy "feat: adicionar nova funcionalidade"
```

✅ Faz tudo: commit → push → deploy no VPS

---

### `commit` - Commit + Push (SEM Deploy)

```bash
commit "docs: atualizar README"
```

✅ Apenas: commit → push (útil para docs, testes, etc)

---

## 💡 Exemplos de Uso

```bash
# Desenvolvimento normal (sem deploy ainda)
commit "feat: adicionar formulário de login"
commit "test: adicionar testes do formulário"

# Quando estiver pronto para produção
deploy "release: sistema de login completo"
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
Trabalhar → commit → commit → commit → deploy
            (sem deploy enquanto desenvolve)    (deploy quando pronto)
```

---

**Dúvidas?** Veja a documentação completa em `.bmad-core/data/custom-commands.md`
