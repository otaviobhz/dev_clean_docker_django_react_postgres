#!/usr/bin/expect -f

# ============================================================================
# Script Expect para Setup Automático no Servidor VPS
# ============================================================================

set timeout 300

# Conectar via SSH
spawn ssh otavio@10.147.20.52

# Esperar por prompt de senha
expect {
    "password:" {
        send "otarau10\r"
    }
    "Password:" {
        send "otarau10\r"
    }
    "(yes/no" {
        send "yes\r"
        exp_continue
    }
}

# Esperar estar logado
expect {
    "otavio@*" {
        send "echo '✅ Conectado com sucesso!'\r"
    }
    "*$" {
        send "echo '✅ Conectado com sucesso!'\r"
    }
}

sleep 1

# Criar diretório
send "mkdir -p /Projetos_Oficial/dev\r"
expect "*$"

send "cd /Projetos_Oficial/dev\r"
expect "*$"

send "echo '📁 Criando estrutura...'\r"
expect "*$"

# Remover se existir
send "if \[ -d \"dev_clean_docker_django_react_postgres\" \]; then rm -rf dev_clean_docker_django_react_postgres; fi\r"
expect "*$"

# Clonar repositório
send "echo '📥 Clonando repositório...'\r"
expect "*$"

send "git clone https://github.com/otaviobhz/dev_clean_docker_django_react_postgres.git dev_clean_docker_django_react_postgres\r"
expect {
    "Cloning into" {
        expect "*$"
    }
    timeout {
        puts "Timeout ao clonar"
    }
}

# Entrar no diretório
send "cd dev_clean_docker_django_react_postgres\r"
expect "*$"

# Copiar .env
send "echo '⚙️ Configurando ambiente...'\r"
expect "*$"

send "cp .env.production .env\r"
expect "*$"

# Verificar Docker
send "echo '🐳 Verificando Docker...'\r"
expect "*$"

send "docker --version\r"
expect "*$"

send "docker compose version\r"
expect "*$"

# Mostrar estrutura
send "echo ''\r"
expect "*$"

send "echo '✅ Setup concluído!'\r"
expect "*$"

send "echo ''\r"
expect "*$"

send "pwd\r"
expect "*$"

send "ls -la | head -20\r"
expect "*$"

send "echo ''\r"
expect "*$"

send "echo '════════════════════════════════════════════════'\r"
expect "*$"

send "echo '  ✅ SETUP COMPLETO!'\r"
expect "*$"

send "echo '════════════════════════════════════════════════'\r"
expect "*$"

# Sair
send "exit\r"
expect eof
