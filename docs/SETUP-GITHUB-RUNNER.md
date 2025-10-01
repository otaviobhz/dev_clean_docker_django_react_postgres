# 🔧 Setup GitHub Self-Hosted Runner

## Por Que Precisamos Disso?

O GitHub Actions não consegue acessar o IP ZeroTier (10.147.20.52) porque é uma rede privada.

A solução é instalar um **GitHub Runner** dentro do próprio servidor VPS, para que os workflows rodem localmente.

---

## 📋 Como Funciona:

### ANTES (Não Funciona):
```
GitHub Actions (Nuvem Microsoft)
    ↓ tenta SSH
10.147.20.52 (ZeroTier)
    ❌ TIMEOUT
```

### DEPOIS (Funciona):
```
GitHub Actions
    ↓ envia comando
GitHub Runner (Dentro do VPS)
    ↓ executa localmente
Deploy funciona! ✅
```

---

## 🚀 Instalação do Runner no VPS

### Passo 1: Conectar no Servidor

```bash
ssh otavio@10.147.20.52
```

### Passo 2: Criar Diretório para o Runner

```bash
mkdir -p ~/actions-runner
cd ~/actions-runner
```

### Passo 3: Baixar o Runner

```bash
# Para Linux x64
curl -o actions-runner-linux-x64-2.311.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.311.0/actions-runner-linux-x64-2.311.0.tar.gz

# Extrair
tar xzf ./actions-runner-linux-x64-2.311.0.tar.gz
```

### Passo 4: Configurar o Runner

```bash
./config.sh --url https://github.com/otaviobhz/dev_clean_docker_django_react_postgres --token SEU_TOKEN_AQUI
```

**Para obter o TOKEN:**

1. Acesse: https://github.com/otaviobhz/dev_clean_docker_django_react_postgres/settings/actions/runners/new
2. Copie o token que aparece na página
3. Cole no comando acima

### Passo 5: Instalar como Serviço (Opcional mas Recomendado)

```bash
sudo ./svc.sh install
sudo ./svc.sh start
```

### Passo 6: Verificar Status

```bash
sudo ./svc.sh status
```

---

## 🔧 Atualizar o Workflow do GitHub Actions

Depois de instalar o runner, edite `.github/workflows/deploy-vps.yml`:

```yaml
jobs:
  deploy:
    name: Deploy to VPS via ZeroTier
    runs-on: self-hosted  # ← Mude para self-hosted

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Deploy locally
        run: |
          cd /Projetos_Oficial/dev/dev_clean_docker_django_react_postgres
          git pull origin main
          cp .env.production .env
          docker compose -f docker-compose.prod.yml down
          docker compose -f docker-compose.prod.yml up -d --build
          docker compose -f docker-compose.prod.yml ps
```

---

## ✅ Vantagens do Self-Hosted Runner:

1. ✅ Acesso direto à rede ZeroTier
2. ✅ Deploy totalmente automático
3. ✅ Não precisa de SSH
4. ✅ Logs no GitHub Actions
5. ✅ Funciona com qualquer tipo de rede privada

---

## 🆘 Troubleshooting

### Runner não inicia

```bash
cd ~/actions-runner
./run.sh
```

### Ver logs

```bash
sudo journalctl -u actions.runner.* -f
```

### Parar o runner

```bash
sudo ./svc.sh stop
```

### Remover o runner

```bash
sudo ./svc.sh uninstall
./config.sh remove --token SEU_TOKEN
```

---

## 🎯 Alternativa Mais Simples:

Se não quiser instalar o runner, use o **deploy manual**:

```bash
./deploy-manual.sh
```

É rápido e funciona perfeitamente!

---

## 📚 Documentação Oficial:

- https://docs.github.com/en/actions/hosting-your-own-runners
