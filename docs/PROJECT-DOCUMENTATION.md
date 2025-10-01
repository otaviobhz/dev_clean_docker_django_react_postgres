# MyPS - Full Stack Project Documentation

**Project Name:** MyPS (My Project Sample)
**Version:** 1.0.0
**Created:** October 2025
**Documentation Type:** BMad Comprehensive Project Documentation
**Last Updated:** October 1, 2025

---

## 📋 Table of Contents

1. [Executive Summary](#executive-summary)
2. [Project Overview](#project-overview)
3. [Architecture & Technology Stack](#architecture--technology-stack)
4. [Directory Structure](#directory-structure)
5. [Services Configuration](#services-configuration)
6. [Development Workflow](#development-workflow)
7. [Deployment & Testing](#deployment--testing)
8. [API Documentation](#api-documentation)
9. [Troubleshooting Guide](#troubleshooting-guide)
10. [BMad Framework Integration](#bmad-framework-integration)
11. [Future Roadmap](#future-roadmap)

---

## Executive Summary

### Project Purpose

MyPS is a **production-ready full-stack template** designed as a reusable framework for rapid application development. Born from the transformation of a specific project ("discogs") into a generalized template, it provides a complete, containerized development environment that works out-of-the-box.

### Key Features

- ✅ **100% Containerized** - All services run in Docker containers
- ✅ **Cross-Platform** - Works on Windows and Linux (WSL2)
- ✅ **Production-Ready** - Follows DevOps best practices
- ✅ **Full-Stack** - React frontend + Django Ninja backend + PostgreSQL database
- ✅ **Status Dashboard** - Real-time health monitoring of all services
- ✅ **Hot Reload** - Development mode with automatic code reloading
- ✅ **BMad Method Integration** - Built using BMad development methodology

### Quick Stats

| Metric | Value |
|--------|-------|
| Services | 5 (Frontend, Backend, Database, PgAdmin, Jupyter) |
| Languages | Python, JavaScript, SQL |
| Frameworks | Django, React, Django Ninja |
| Database | PostgreSQL 15 |
| Container Runtime | Docker Compose |
| Development Method | BMad Method™ |

---

## Project Overview

### What is MyPS?

MyPS is a blank, ready-to-use full-stack project template that provides:

1. **Complete Development Environment** - No local dependencies required beyond Docker
2. **Working Validation Dashboard** - Visual confirmation that all services are operational
3. **Modern Tech Stack** - Industry-standard technologies pre-configured
4. **BMad Integration** - Full BMad Method framework with agents, workflows, and tools

### Origin Story

MyPS was created through a systematic transformation process:

- **Source:** "discogs" project (music database application)
- **Transformation Date:** September 30, 2025
- **Method Used:** BMad brainstorming session with SCAMPER technique
- **Goal:** Create reusable blank template with zero project-specific logic

The transformation process included:
- Systematic renaming (discogs → sample_project)
- Port standardization (+1 increment pattern)
- Removal of business-specific logic
- Addition of status dashboard
- Full BMad framework integration

### Design Philosophy

1. **Simplicity First** - One command to start everything
2. **Visual Validation** - Dashboard proves everything works
3. **DevOps Ready** - Containerized for easy deployment
4. **Developer Experience** - Hot reload, clear logs, minimal friction
5. **Method-Driven** - Built with and for the BMad Method

---

## Architecture & Technology Stack

### System Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                        User Browser                          │
└────────────────────┬────────────────────────────────────────┘
                     │
                     │ HTTP :8081
                     ▼
┌─────────────────────────────────────────────────────────────┐
│                 Frontend Container (React)                   │
│  • React 18.2.0                                             │
│  • Status Dashboard                                          │
│  • Hot Reload (Dev Mode)                                     │
└────────────────────┬────────────────────────────────────────┘
                     │
                     │ API Calls :8001
                     ▼
┌─────────────────────────────────────────────────────────────┐
│            Backend Container (Django + Jupyter)              │
│  • Django Ninja REST API                                     │
│  • Jupyter Notebook :9000                                    │
│  • Python 3.10                                              │
│  • Health Check Endpoints                                    │
└────────────────────┬────────────────────────────────────────┘
                     │
                     │ PostgreSQL :5432 (internal)
                     ▼
┌─────────────────────────────────────────────────────────────┐
│            Database Container (PostgreSQL 15)                │
│  • PostgreSQL 15                                            │
│  • Persistent Storage                                        │
│  • Health Checks                                            │
└────────────────────┬────────────────────────────────────────┘
                     │
                     │ Admin :80 (internal)
                     ▼
┌─────────────────────────────────────────────────────────────┐
│              PgAdmin Container (Database UI)                 │
│  • PgAdmin 4                                                │
│  • Web-based DB Management                                   │
└─────────────────────────────────────────────────────────────┘
```

### Technology Stack

#### Frontend Stack
- **Framework:** React 18.2.0
- **Build Tool:** React Scripts 5.0.1
- **Language:** JavaScript (ES6+)
- **Styling:** CSS3 + Custom Components
- **HTTP Client:** Native Fetch API
- **Container:** Node.js Alpine

#### Backend Stack
- **Framework:** Django (latest)
- **API Framework:** Django Ninja 1.0+
- **Language:** Python 3.10
- **WSGI Server:** Django Development Server
- **Notebook:** Jupyter Notebook 6.4.3
- **Database Driver:** psycopg2-binary 2.9+
- **CORS:** django-cors-headers 4.0+

#### Database Stack
- **Database:** PostgreSQL 15
- **Admin Tool:** PgAdmin 4 (latest)
- **Connection Pooling:** Django default
- **Migrations:** Django migrations system

#### DevOps Stack
- **Containerization:** Docker
- **Orchestration:** Docker Compose
- **Networks:** Docker bridge network
- **Volumes:** Named volumes for persistence
- **Platform:** Linux (WSL2 compatible)

### Service Ports

| Service | Internal Port | External Port | URL |
|---------|---------------|---------------|-----|
| Frontend (React) | 8081 | 8081 | http://localhost:8081 |
| Backend API | 8001 | 8001 | http://localhost:8001/api/ |
| Jupyter Notebook | 9000 | 9000 | http://localhost:9000 |
| PostgreSQL | 5432 | 5433 | localhost:5433 |
| PgAdmin | 80 | 5051 | http://localhost:5051 |

**Port Increment Pattern:** All ports are +1 from the original "discogs" project to prevent conflicts.

### Network Architecture

All services run on a custom Docker bridge network named `app_network`:

```yaml
networks:
  app_network:
    driver: bridge
```

**Internal Service Communication:**
- Frontend → Backend: `http://jupyter_notebook:8001`
- Backend → Database: `postgres_db:5432`
- PgAdmin → Database: `postgres_db:5432`

**External Access:**
- All services accessible via `localhost` on their external ports
- Cross-Origin Resource Sharing (CORS) configured for frontend-backend communication

---

## Directory Structure

### Root Level Structure

```
myps/
├── .bmad-core/                  # BMad Core Framework
├── .bmad-creative-writing/      # BMad Creative Writing Bundle
├── .bmad-infrastructure-devops/ # BMad Infrastructure Bundle
├── .claude/                     # Claude Code Configuration
├── backend/                     # Django Backend Application
├── config/                      # Configuration Files
├── data/                        # Application Data
├── database/                    # Database Scripts & Config
├── dbdata/                      # Database Persistent Storage
├── docs/                        # Project Documentation
├── frontend/                    # React Frontend Application
├── logs/                        # Application Logs
├── utils/                       # Utility Scripts
├── workingdir/                  # Working Directory for Processing
├── docker-compose.yml           # Production Configuration
├── docker-compose.dev.yml       # Development Configuration
├── README.md                    # Project README
└── *.bat                        # Windows Startup Scripts
```

### Backend Directory (`/backend`)

```
backend/
├── database/
│   ├── backups/                 # Database backup files
│   ├── init/
│   │   └── 01_create_tables.sql # Database initialization
│   ├── migrations/              # Database migrations
│   └── pgadmin-config/          # PgAdmin configuration
├── django_project/
│   ├── api/                     # Django Ninja API app
│   │   ├── views.py            # API endpoints (health, root)
│   │   └── ...
│   └── django_project/          # Django settings
│       ├── settings.py         # Main configuration
│       ├── urls.py             # URL routing
│       └── wsgi.py             # WSGI application
├── notebooks/                   # Jupyter notebooks
├── scripts/                     # Backend utility scripts
├── src/                         # Source code modules
├── tests/                       # Backend tests
├── Dockerfile                   # Backend container definition
├── docker-entrypoint.sh        # Container startup script
└── requirements.txt            # Python dependencies
```

### Frontend Directory (`/frontend`)

```
frontend/
├── public/                      # Static public files
├── src/
│   ├── components/
│   │   ├── Dashboard.jsx       # Main status dashboard
│   │   ├── Dashboard.css       # Dashboard styles
│   │   ├── StatusIndicator.jsx # Service status component
│   │   └── StatusIndicator.css # Status styles
│   ├── hooks/                  # Custom React hooks
│   ├── pages/                  # Page components
│   ├── services/               # API service layer
│   ├── utils/                  # Utility functions
│   ├── App.js                  # Root component
│   ├── App.css                 # App styles
│   ├── index.js                # React entry point
│   └── index.css               # Global styles
├── Dockerfile                   # Production frontend container
├── Dockerfile.dev              # Development frontend container
└── package.json                # Node.js dependencies
```

### BMad Framework Structure

```
.bmad-core/
├── agents/                      # BMad agent definitions
├── checklists/                  # Validation checklists
├── data/                        # Knowledge base & data
├── tasks/                       # Reusable task definitions
├── templates/                   # Document templates
├── utils/                       # Utility resources
└── core-config.yaml            # Core BMad configuration

.bmad-creative-writing/          # Creative writing bundle
.bmad-infrastructure-devops/     # Infrastructure bundle
```

### Documentation Directory (`/docs`)

```
docs/
├── architecture/               # Architecture documentation
│   ├── coding-standards.md
│   ├── tech-stack.md
│   └── source-tree.md
├── prd/                        # Product requirements (sharded)
├── qa/                         # QA documentation
├── stories/                    # Development stories
│   └── 1.0.sample-project-template-transformation.md
├── brainstorming-session-results.md
└── PROJECT-DOCUMENTATION.md    # This file
```

---

## Services Configuration

### Frontend Service (React)

**Container Name:** `sample_project_frontend_react` (production) / `sample_project_frontend_react_dev` (development)

**Base Image:** Node.js Alpine

**Key Configuration:**
```yaml
frontend:
  build:
    context: ./frontend
    dockerfile: Dockerfile      # or Dockerfile.dev
  ports:
    - "8081:8081"
  environment:
    - NODE_ENV=development
    - CHOKIDAR_USEPOLLING=true  # For hot reload in Docker
  volumes:
    - ./frontend:/app           # Dev mode only
    - /app/node_modules         # Dev mode only
  networks:
    - app_network
```

**Key Features:**
- Hot reload in development mode
- Builds optimized production bundle
- CORS-enabled API calls
- Real-time status dashboard

**Environment Variables:**
- `NODE_ENV`: development | production
- `CHOKIDAR_USEPOLLING`: Enable file watching in Docker
- `WATCHPACK_POLLING`: Enable webpack polling

---

### Backend Service (Django + Jupyter)

**Container Name:** `sample_project_backend` (production) / `sample_project_backend_dev` (development)

**Base Image:** Python 3.10

**Key Configuration:**
```yaml
jupyter_notebook:
  build:
    context: .
    dockerfile: ./backend/Dockerfile
  ports:
    - "9000:9000"  # Jupyter
    - "8001:8001"  # Django API
  volumes:
    - ./:/app
  environment:
    - PYTHONPATH=/app
  depends_on:
    - postgres_db
  networks:
    - app_network
```

**Key Features:**
- Django Ninja REST API
- Jupyter Notebook environment
- Database connectivity with health checks
- CORS configuration
- Auto-reload on code changes

**Environment Variables:**
- `PYTHONPATH`: Python module search path
- `POSTGRES_HOST`: Database hostname (postgres_db)
- `POSTGRES_PORT`: Database port (5432 internal)
- `POSTGRES_DB`: Database name (sample_project_db)
- `POSTGRES_USER`: Database user (admin)
- `POSTGRES_PASSWORD`: Database password (12345)

**Entrypoint Script:**
- Starts Jupyter Notebook on port 9000
- Starts Django development server on port 8001
- Both run concurrently in background

---

### Database Service (PostgreSQL)

**Container Name:** `postgres_sample_project` (production) / `postgres_sample_project_dev` (development)

**Base Image:** postgres:15

**Key Configuration:**
```yaml
postgres_db:
  image: postgres:15
  environment:
    POSTGRES_DB: sample_project_db
    POSTGRES_USER: admin
    POSTGRES_PASSWORD: 12345
    PGDATA: /var/lib/postgresql/data/pgdata
  ports:
    - "5433:5432"
  volumes:
    - ./dbdata/postgres:/var/lib/postgresql/data
    - ./backend/database/init:/docker-entrypoint-initdb.d
    - ./backend/database/backups:/backups
  networks:
    - app_network
  healthcheck:
    test: ["CMD-SHELL", "pg_isready -U admin -d sample_project_db"]
    interval: 30s
    timeout: 10s
    retries: 5
```

**Key Features:**
- PostgreSQL 15 with persistent storage
- Health check monitoring
- Automatic initialization from SQL scripts
- Backup directory mounted

**Connection Details:**
- **From containers:** `postgres_db:5432`
- **From host:** `localhost:5433`
- **Database:** sample_project_db
- **Username:** admin
- **Password:** 12345

---

### PgAdmin Service (Database Admin UI)

**Container Name:** `pgadmin_sample_project` (production) / `pgadmin_sample_project_dev` (development)

**Base Image:** dpage/pgadmin4:latest

**Key Configuration:**
```yaml
pgadmin:
  image: dpage/pgadmin4:latest
  environment:
    PGADMIN_DEFAULT_EMAIL: admin@sampleproject.com
    PGADMIN_DEFAULT_PASSWORD: 12345
    PGADMIN_CONFIG_SERVER_MODE: 'False'
    PGADMIN_CONFIG_MASTER_PASSWORD_REQUIRED: 'False'
  ports:
    - "5051:80"
  volumes:
    - ./dbdata/pgadmin:/var/lib/pgadmin
  depends_on:
    postgres_db:
      condition: service_healthy
  networks:
    - app_network
```

**Access Credentials:**
- **URL:** http://localhost:5051
- **Email:** admin@sampleproject.com
- **Password:** 12345

**Note:** Email format updated (removed underscore) to fix validation issues with latest PgAdmin version.

---

### Docker Volumes

```yaml
volumes:
  postgres_data:    # PostgreSQL data persistence
  pgadmin_data:     # PgAdmin configuration persistence
```

**Persistent Data Locations:**
- PostgreSQL: `./dbdata/postgres/`
- PgAdmin: `./dbdata/pgadmin/`

---

### Docker Network

```yaml
networks:
  app_network:
    driver: bridge
```

All services communicate through the `app_network` bridge network, enabling container-to-container communication by service name.

---

## Development Workflow

### Initial Setup

**Prerequisites:**
- Docker Desktop installed (Windows/Linux)
- Git (optional, for version control)

**Setup Steps:**

1. **Clone or Copy Project**
   ```bash
   cd /path/to/projects
   # Clone from repo or copy template
   ```

2. **Verify Directory Structure**
   ```bash
   ls -la
   # Should see: backend/, frontend/, docker-compose.yml, etc.
   ```

3. **No Additional Setup Required**
   - No local Python installation needed
   - No local Node.js installation needed
   - All dependencies are containerized

### Starting Development Environment

**Development Mode (with hot reload):**
```bash
docker compose -f docker-compose.dev.yml up --build
```

**Production Mode:**
```bash
docker compose up --build
```

**Detached Mode (background):**
```bash
docker compose -f docker-compose.dev.yml up -d
```

**Windows Helper Scripts:**
- `start.bat` - Start in foreground
- `start-detached.bat` - Start in background
- `stop.bat` - Stop all services
- `restart.bat` - Restart all services

### Service Access During Development

Once started, access services at:

| Service | URL | Credentials |
|---------|-----|-------------|
| **Frontend Dashboard** | http://localhost:8081 | None |
| **Backend API** | http://localhost:8001/api/ | None |
| **API Docs** | http://localhost:8001/api/docs | None |
| **Jupyter Notebook** | http://localhost:9000 | Token in logs |
| **PgAdmin** | http://localhost:5051 | admin@sampleproject.com / 12345 |
| **PostgreSQL** | localhost:5433 | admin / 12345 |

### Making Code Changes

**Frontend Changes:**
1. Edit files in `frontend/src/`
2. Save file
3. Hot reload automatically updates browser
4. Check browser console for errors

**Backend Changes:**
1. Edit files in `backend/django_project/`
2. Save file
3. Django auto-reloads
4. Check container logs for errors

**Database Changes:**
1. Edit `backend/database/init/*.sql`
2. Stop containers and remove volumes:
   ```bash
   docker compose down -v
   ```
3. Rebuild and restart:
   ```bash
   docker compose up --build
   ```

### Viewing Logs

**All Services:**
```bash
docker compose -f docker-compose.dev.yml logs -f
```

**Specific Service:**
```bash
docker compose -f docker-compose.dev.yml logs -f frontend
docker compose -f docker-compose.dev.yml logs -f jupyter_notebook
docker compose -f docker-compose.dev.yml logs -f postgres_db
```

**Last N Lines:**
```bash
docker compose -f docker-compose.dev.yml logs --tail=50 frontend
```

### Stopping Development Environment

**Graceful Stop:**
```bash
docker compose -f docker-compose.dev.yml down
```

**Stop and Remove Volumes (fresh start):**
```bash
docker compose -f docker-compose.dev.yml down -v
```

**Stop Specific Service:**
```bash
docker compose -f docker-compose.dev.yml stop frontend
```

### Container Management

**Check Status:**
```bash
docker compose -f docker-compose.dev.yml ps
```

**Execute Commands in Container:**
```bash
# Backend shell
docker compose -f docker-compose.dev.yml exec jupyter_notebook bash

# Frontend shell
docker compose -f docker-compose.dev.yml exec frontend sh

# PostgreSQL CLI
docker compose -f docker-compose.dev.yml exec postgres_db psql -U admin -d sample_project_db
```

**Restart Single Service:**
```bash
docker compose -f docker-compose.dev.yml restart frontend
```

**Rebuild Single Service:**
```bash
docker compose -f docker-compose.dev.yml up --build frontend
```

### BMad Method Workflow

**Using BMad Agents:**

1. **Activate Orchestrator:**
   ```
   /BMad:agents:bmad-orchestrator
   ```

2. **Switch to Developer Agent:**
   ```
   *agent dev
   ```

3. **Run Development Commands:**
   ```
   *develop-story    # Implement story tasks
   *run-tests        # Execute tests
   *review-qa        # Apply QA fixes
   *explain          # Learn from implementation
   ```

**BMad Configuration:**
Located in `.bmad-core/core-config.yaml`:
- Story location: `docs/stories/`
- Architecture docs: `docs/architecture/`
- PRD location: `docs/prd/`
- QA location: `docs/qa/`

---

## Deployment & Testing

### Testing the Installation

**Complete System Test:**
```bash
# 1. Start all services
docker compose -f docker-compose.dev.yml up -d

# 2. Wait for startup (30 seconds)
sleep 30

# 3. Check container status
docker compose -f docker-compose.dev.yml ps

# 4. Test backend API
curl http://localhost:8001/api/health

# 5. Test frontend
curl http://localhost:8081

# 6. Open browser dashboard
# Navigate to: http://localhost:8081
# Verify all 3 indicators are green
```

**Individual Service Tests:**

**Backend Health Check:**
```bash
curl http://localhost:8001/api/health
# Expected: {"status": "ok", "backend": "operational", "database": "connected", ...}
```

**Frontend Accessibility:**
```bash
curl -I http://localhost:8081
# Expected: HTTP/1.1 200 OK
```

**Database Connection:**
```bash
docker exec postgres_sample_project_dev psql -U admin -d sample_project_db -c "SELECT version();"
# Expected: PostgreSQL 15.x version string
```

**API Documentation:**
```bash
# Open in browser: http://localhost:8001/api/docs
# Should show Django Ninja interactive API docs
```

### Troubleshooting Tests

**If Backend Shows Red in Dashboard:**

1. Check backend logs:
   ```bash
   docker compose logs --tail=50 jupyter_notebook
   ```

2. Verify backend is running:
   ```bash
   curl http://localhost:8001/api/health
   ```

3. Check CORS configuration in `backend/django_project/django_project/settings.py`

**If Database Shows Red:**

1. Check PostgreSQL is running:
   ```bash
   docker compose ps postgres_db
   ```

2. Test database connection:
   ```bash
   docker exec postgres_sample_project_dev psql -U admin -d sample_project_db -c "SELECT 1;"
   ```

3. Review database logs:
   ```bash
   docker compose logs postgres_db
   ```

**If Frontend Can't Connect:**

1. Verify frontend compiled:
   ```bash
   docker compose logs frontend | grep "compiled"
   ```

2. Check browser console (F12) for errors

3. Verify CORS headers:
   ```bash
   curl -I http://localhost:8001/api/health
   # Look for: access-control-allow-origin: *
   ```

### Production Deployment Checklist

- [ ] Change all default passwords
- [ ] Set `DEBUG = False` in Django settings
- [ ] Configure proper `SECRET_KEY` in Django
- [ ] Set up environment variables (`.env` file)
- [ ] Configure `ALLOWED_HOSTS` in Django
- [ ] Set up SSL/TLS certificates
- [ ] Configure reverse proxy (nginx)
- [ ] Set up database backups
- [ ] Configure logging
- [ ] Set up monitoring (health checks)
- [ ] Review security settings
- [ ] Test full deployment pipeline

### Continuous Integration / Continuous Deployment

**Recommended CI/CD Pipeline:**

1. **Build Stage:**
   - Lint frontend code
   - Lint backend code
   - Run unit tests
   - Build Docker images

2. **Test Stage:**
   - Spin up containers
   - Run integration tests
   - Run end-to-end tests
   - Health check validation

3. **Deploy Stage:**
   - Push images to registry
   - Deploy to staging
   - Run smoke tests
   - Deploy to production

---

## API Documentation

### Base URL

**Development:** `http://localhost:8001/api/`
**Production:** `https://yourdomain.com/api/`

### Authentication

Currently, the API has **no authentication** (template baseline). Add authentication as needed for your project.

### Endpoints

#### 1. Health Check Endpoint

**GET** `/api/health`

**Description:** Returns the health status of the backend and database.

**Response:**
```json
{
  "status": "ok",
  "backend": "operational",
  "database": "connected",
  "timestamp": "2025-10-01T17:23:23.212129"
}
```

**Status Codes:**
- `200 OK` - All services operational
- `500 Internal Server Error` - Database connection failed

**Example:**
```bash
curl http://localhost:8001/api/health
```

---

#### 2. API Root Endpoint

**GET** `/api/`

**Description:** Returns basic API information and available endpoints.

**Response:**
```json
{
  "message": "Sample Project API",
  "version": "1.0.0",
  "endpoints": {
    "health": "/api/health",
    "docs": "/api/docs"
  }
}
```

**Status Codes:**
- `200 OK` - Success

**Example:**
```bash
curl http://localhost:8001/api/
```

---

#### 3. Interactive API Documentation

**GET** `/api/docs`

**Description:** Django Ninja auto-generated interactive API documentation (Swagger UI).

**Access:** http://localhost:8001/api/docs

**Features:**
- Interactive endpoint testing
- Request/response schemas
- Try-it-out functionality

---

### Adding New Endpoints

**Location:** `backend/django_project/api/views.py`

**Example:**
```python
@api.get("/example")
def example_endpoint(request):
    """
    Example endpoint description.
    """
    return {"message": "Hello World"}
```

**URL Routing:**
Endpoints are automatically registered through Django Ninja's `NinjaAPI()` instance.

---

### CORS Configuration

**Configured in:** `backend/django_project/django_project/settings.py`

```python
INSTALLED_APPS = [
    ...
    'corsheaders',
    ...
]

MIDDLEWARE = [
    ...
    'corsheaders.middleware.CorsMiddleware',
    ...
]

CORS_ALLOW_ALL_ORIGINS = True  # For development
```

**Production:** Configure specific allowed origins:
```python
CORS_ALLOWED_ORIGINS = [
    "https://yourdomain.com",
]
```

---

## Troubleshooting Guide

### Common Issues & Solutions

#### Issue 1: Containers Won't Start

**Symptoms:**
- `docker compose up` fails
- Containers exit immediately

**Solutions:**
1. Check Docker daemon is running:
   ```bash
   docker ps
   ```

2. Check for port conflicts:
   ```bash
   # Linux
   lsof -i :8081
   lsof -i :8001

   # Windows
   netstat -ano | findstr "8081"
   netstat -ano | findstr "8001"
   ```

3. Remove old containers and volumes:
   ```bash
   docker compose down -v
   docker compose up --build
   ```

4. Check logs for specific errors:
   ```bash
   docker compose logs
   ```

---

#### Issue 2: Permission Denied on Entrypoint

**Symptoms:**
- Backend container fails with "permission denied: /app/backend/docker-entrypoint.sh"

**Solution:**
```bash
chmod +x backend/docker-entrypoint.sh
docker compose restart jupyter_notebook
```

---

#### Issue 3: PgAdmin Email Validation Error

**Symptoms:**
- PgAdmin container restarts continuously
- Logs show: "does not appear to be a valid email address"

**Solution:**
Email must not contain underscores in domain. Already fixed in config:
```yaml
PGADMIN_DEFAULT_EMAIL: admin@sampleproject.com  # NOT admin@sample_project.com
```

---

#### Issue 4: Frontend Shows "Failed to Fetch"

**Symptoms:**
- Dashboard displays connection error
- Backend and database show red X

**Solutions:**

1. **Verify backend is running:**
   ```bash
   curl http://localhost:8001/api/health
   ```

2. **Check CORS is configured:**
   - Verify `corsheaders` in `INSTALLED_APPS`
   - Verify `CorsMiddleware` in `MIDDLEWARE`
   - Restart backend after changes

3. **Check browser console:**
   - Open DevTools (F12)
   - Look for CORS errors or network failures

4. **Verify network connectivity:**
   ```bash
   docker compose ps
   # All containers should be "Up"
   ```

---

#### Issue 5: Database Connection Refused

**Symptoms:**
- Backend shows "database: disconnected"
- Django can't connect to PostgreSQL

**Solutions:**

1. **Wait for PostgreSQL to be ready:**
   ```bash
   docker compose logs postgres_db | grep "ready to accept connections"
   ```

2. **Check database health:**
   ```bash
   docker compose ps postgres_db
   # Status should show "(healthy)"
   ```

3. **Verify connection settings:**
   Check `backend/django_project/django_project/settings.py`:
   ```python
   DATABASES = {
       'default': {
           'HOST': 'postgres_db',  # Must match service name
           'PORT': '5432',         # Internal port
           ...
       }
   }
   ```

4. **Test direct connection:**
   ```bash
   docker exec -it postgres_sample_project_dev psql -U admin -d sample_project_db -c "SELECT 1;"
   ```

---

#### Issue 6: Hot Reload Not Working

**Symptoms:**
- Frontend changes don't appear in browser
- Backend changes don't trigger reload

**Solutions:**

**Frontend:**
1. Verify dev mode:
   ```bash
   docker compose -f docker-compose.dev.yml ps
   ```

2. Check polling is enabled in `docker-compose.dev.yml`:
   ```yaml
   environment:
     - CHOKIDAR_USEPOLLING=true
     - WATCHPACK_POLLING=true
   ```

3. Restart frontend:
   ```bash
   docker compose -f docker-compose.dev.yml restart frontend
   ```

**Backend:**
1. Django auto-reload requires debug mode (already enabled)
2. Check logs for reload messages:
   ```bash
   docker compose logs -f jupyter_notebook
   ```

---

#### Issue 7: Jupyter Notebook Token Unknown

**Symptoms:**
- Can't access Jupyter at http://localhost:9000
- Asks for token

**Solution:**
Get token from logs:
```bash
docker compose logs jupyter_notebook | grep "token="
```

Look for line like:
```
http://localhost:9000/?token=abc123def456...
```

---

### Debugging Commands

**View all running containers:**
```bash
docker ps
```

**Inspect container details:**
```bash
docker inspect sample_project_backend_dev
```

**Check container resource usage:**
```bash
docker stats
```

**Enter container shell:**
```bash
docker compose exec jupyter_notebook bash
```

**View container networks:**
```bash
docker network ls
docker network inspect myps_app_network
```

**Remove all stopped containers:**
```bash
docker container prune
```

**Remove all unused images:**
```bash
docker image prune -a
```

---

## BMad Framework Integration

### What is BMad?

**BMad (Business Method for Agile Development)** is a comprehensive development methodology that integrates:
- AI-powered agent workflows
- Story-driven development
- Systematic task management
- Knowledge base integration
- Collaborative agent teams

### BMad Components in This Project

#### 1. BMad Core (`.bmad-core/`)

**Purpose:** Core BMad framework configuration and shared resources.

**Key Files:**
- `core-config.yaml` - Project configuration
- `agents/` - Shared agent definitions
- `tasks/` - Reusable task workflows
- `templates/` - Document templates
- `data/` - Knowledge base
- `utils/` - Utility resources

**Configuration:**
```yaml
devStoryLocation: docs/stories
devLoadAlwaysFiles:
  - docs/architecture/coding-standards.md
  - docs/architecture/tech-stack.md
  - docs/architecture/source-tree.md
slashPrefix: BMad
```

#### 2. BMad Creative Writing (`.bmad-creative-writing/`)

**Purpose:** Creative content generation and story development.

**Agents Available:**
- Plot Architect
- Character Psychologist
- World Builder
- Dialog Specialist
- Editor
- Beta Reader
- Book Critic
- Cover Designer
- Genre Specialist
- Narrative Designer

**When to Use:** Content creation, narrative design, documentation writing.

#### 3. BMad Infrastructure DevOps (`.bmad-infrastructure-devops/`)

**Purpose:** Infrastructure planning, deployment, and DevOps workflows.

**Agents Available:**
- Infrastructure Platform Agent

**Key Resources:**
- Infrastructure architecture templates
- Platform configuration templates
- Validation checklists
- Technical preferences

**When to Use:** Infrastructure planning, deployment strategies, DevOps automation.

### Using BMad Agents

#### Starting the BMad Orchestrator

```
/BMad:agents:bmad-orchestrator
```

The orchestrator provides:
- Agent transformation (`*agent <name>`)
- Workflow guidance (`*workflow-guidance`)
- Knowledge base access (`*kb-mode`)
- Task execution (`*task <name>`)
- Status tracking (`*status`)

#### Example Workflow: Development with BMad

1. **Start Orchestrator:**
   ```
   /BMad:agents:bmad-orchestrator
   ```

2. **Transform to Developer Agent:**
   ```
   *agent dev
   ```

3. **Load Current Story:**
   Agent automatically loads assigned story from `docs/stories/`

4. **Execute Development Task:**
   ```
   *develop-story
   ```

5. **Run Tests:**
   ```
   *run-tests
   ```

6. **Get Explanation (Learning Mode):**
   ```
   *explain
   ```

7. **Exit Agent:**
   ```
   *exit
   ```

### BMad Story Development

**Story Location:** `docs/stories/`

**Story Format:**
```markdown
# Story Title

**Status:** draft | ready-for-review | complete
**Agent Model Used:** <model-name>

## Story
<Description of feature/task>

## Tasks
- [ ] Task 1
  - [ ] Subtask 1.1
  - [ ] Subtask 1.2
- [ ] Task 2

## Acceptance Criteria
- Criterion 1
- Criterion 2

## Dev Agent Record
### Debug Log
- Issue 1 and resolution

### Completion Notes
- Implementation note 1

### File List
- file1.py
- file2.js

### Change Log
- Change 1
- Change 2
```

**Development Flow:**
1. Create story in `docs/stories/`
2. Set status to `ready-for-review`
3. Activate dev agent
4. Run `*develop-story`
5. Agent implements tasks sequentially
6. Agent updates Dev Agent Record sections
7. Story status changed to `complete`

### BMad Knowledge Base

**Access BMad Knowledge:**
```
*kb-mode
```

**Knowledge Base Contents:**
- BMad methodology documentation
- Elicitation techniques
- Development best practices
- Agent usage guides
- Workflow patterns

**Interactive Mode:**
The orchestrator presents topic areas and provides focused, contextual responses based on your selection.

### Creating Custom BMad Workflows

**Location:** `.bmad-core/workflows/` (create if needed)

**Example Workflow Definition:**
```yaml
id: custom-workflow
name: Custom Development Workflow
description: Step-by-step custom process
steps:
  - step: 1
    name: Planning
    tasks:
      - create-doc
      - validate-requirements
  - step: 2
    name: Implementation
    tasks:
      - develop-story
      - run-tests
```

**Invoke Workflow:**
```
*workflow custom-workflow
```

---

## Future Roadmap

### Short-Term Enhancements (1-3 months)

#### 1. Authentication System
- [ ] Add JWT authentication to backend
- [ ] Implement user registration/login
- [ ] Protected API endpoints
- [ ] Frontend auth state management

#### 2. Enhanced Dashboard
- [ ] Additional service metrics
- [ ] Response time monitoring
- [ ] Database query statistics
- [ ] Theme toggle (dark/light mode)

#### 3. Testing Framework
- [ ] Frontend unit tests (Jest + React Testing Library)
- [ ] Backend unit tests (pytest)
- [ ] Integration tests
- [ ] E2E tests (Cypress or Playwright)

#### 4. Environment Configuration
- [ ] `.env` file support
- [ ] Environment-specific configs
- [ ] Secrets management
- [ ] Configuration validation

#### 5. Documentation Expansion
- [ ] API usage examples
- [ ] Component library documentation
- [ ] Architecture decision records (ADRs)
- [ ] Video tutorials

### Mid-Term Goals (3-6 months)

#### 1. Template Generator CLI
- [ ] Interactive project creation tool
- [ ] Custom port configuration
- [ ] Feature selection (enable/disable services)
- [ ] Project name customization
- [ ] Automatic file generation

#### 2. Monitoring & Logging
- [ ] Centralized logging (ELK stack)
- [ ] Application performance monitoring
- [ ] Error tracking (Sentry integration)
- [ ] Custom metrics dashboard

#### 3. CI/CD Pipeline
- [ ] GitHub Actions workflow
- [ ] Automated testing
- [ ] Docker image building
- [ ] Deployment automation
- [ ] Environment promotion workflow

#### 4. Database Enhancements
- [ ] Migration management workflow
- [ ] Seed data system
- [ ] Backup automation
- [ ] Point-in-time recovery

#### 5. Security Hardening
- [ ] Security scanning (OWASP)
- [ ] Dependency vulnerability checking
- [ ] SSL/TLS configuration
- [ ] Rate limiting
- [ ] Input validation middleware

### Long-Term Vision (6-12 months)

#### 1. Multi-Project Template Variants

**Variants to Create:**
- [ ] **Minimal Template** - Bare essentials only
- [ ] **API-Only Template** - No frontend, pure backend
- [ ] **Microservices Template** - Multiple backend services
- [ ] **Serverless Template** - AWS Lambda/Azure Functions
- [ ] **Mobile Template** - React Native frontend

#### 2. Template Update System
- [ ] Version management for templates
- [ ] Update propagation to derived projects
- [ ] Migration scripts for major updates
- [ ] Changelog generation

#### 3. Plugin Architecture
- [ ] Plugin system for optional features
- [ ] Community plugin repository
- [ ] Plugin discovery and installation
- [ ] Plugin dependency management

#### 4. Advanced BMad Integration
- [ ] Automated story generation from requirements
- [ ] AI-powered code review agent
- [ ] Automated testing story generation
- [ ] Deployment story workflows

#### 5. Enterprise Features
- [ ] Multi-tenancy support
- [ ] Advanced RBAC (Role-Based Access Control)
- [ ] Audit logging
- [ ] Compliance reporting
- [ ] High availability configuration

### Research & Innovation

#### Areas for Exploration

1. **AI-Powered Development Assistant**
   - Context-aware code suggestions
   - Automated refactoring recommendations
   - Bug prediction and prevention

2. **Visual Development Tools**
   - Drag-and-drop component builder
   - Visual API designer
   - Database schema designer

3. **Performance Optimization**
   - Automated performance profiling
   - Bottleneck detection
   - Optimization recommendations

4. **Cloud-Native Features**
   - Kubernetes deployment configs
   - Service mesh integration
   - Cloud provider templates (AWS, Azure, GCP)

### Community & Ecosystem

#### Planned Community Initiatives

- [ ] Public template repository
- [ ] Community contribution guidelines
- [ ] Example projects showcase
- [ ] Template usage analytics
- [ ] Community forums/Discord
- [ ] Regular community calls
- [ ] Template certification program

### Feedback & Iteration

**We track:**
- User adoption metrics
- Common customization patterns
- Pain points and friction areas
- Feature requests
- Bug reports

**Feedback Channels:**
- GitHub Issues
- Community Discord
- Usage analytics
- User interviews

---

## Appendices

### Appendix A: Port Reference Table

| Service | Internal | External | Purpose |
|---------|----------|----------|---------|
| React Frontend | 8081 | 8081 | Web UI |
| Django API | 8001 | 8001 | REST API |
| Jupyter Notebook | 9000 | 9000 | Development |
| PostgreSQL | 5432 | 5433 | Database |
| PgAdmin | 80 | 5051 | DB Admin |

### Appendix B: Environment Variables Reference

**Backend (`docker-compose.yml`):**
```yaml
PYTHONPATH: /app
POSTGRES_HOST: postgres_db
POSTGRES_PORT: 5432
POSTGRES_DB: sample_project_db
POSTGRES_USER: admin
POSTGRES_PASSWORD: 12345
```

**Frontend (dev mode):**
```yaml
NODE_ENV: development
CHOKIDAR_USEPOLLING: true
WATCHPACK_POLLING: true
```

**Database:**
```yaml
POSTGRES_DB: sample_project_db
POSTGRES_USER: admin
POSTGRES_PASSWORD: 12345
PGDATA: /var/lib/postgresql/data/pgdata
```

**PgAdmin:**
```yaml
PGADMIN_DEFAULT_EMAIL: admin@sampleproject.com
PGADMIN_DEFAULT_PASSWORD: 12345
PGADMIN_CONFIG_SERVER_MODE: False
PGADMIN_CONFIG_MASTER_PASSWORD_REQUIRED: False
```

### Appendix C: BMad Command Reference

**Orchestrator Commands:**
- `*help` - Show command guide
- `*agent [name]` - Transform to agent
- `*workflow [name]` - Start workflow
- `*workflow-guidance` - Get workflow help
- `*task [name]` - Run task
- `*checklist [name]` - Execute checklist
- `*kb-mode` - Access knowledge base
- `*chat-mode` - Start chat mode
- `*status` - Show current status
- `*exit` - Exit agent

**Developer Agent Commands:**
- `*develop-story` - Implement story
- `*run-tests` - Execute tests
- `*review-qa` - Apply QA fixes
- `*explain` - Detailed explanation mode
- `*exit` - Return to orchestrator

### Appendix D: Useful Docker Commands

**Container Management:**
```bash
docker compose ps                    # List containers
docker compose logs -f               # Follow all logs
docker compose logs -f <service>     # Follow service logs
docker compose restart <service>     # Restart service
docker compose stop                  # Stop all
docker compose down                  # Stop and remove
docker compose down -v               # Stop, remove, delete volumes
```

**Debugging:**
```bash
docker compose exec <service> bash   # Enter container shell
docker inspect <container>           # Inspect container
docker stats                         # Resource usage
docker network inspect <network>     # Network details
```

**Cleanup:**
```bash
docker container prune               # Remove stopped containers
docker image prune                   # Remove unused images
docker image prune -a                # Remove all unused images
docker volume prune                  # Remove unused volumes
docker system prune                  # Remove all unused data
```

### Appendix E: Technology Documentation Links

**Frontend:**
- React: https://react.dev/
- React Scripts: https://create-react-app.dev/

**Backend:**
- Django: https://docs.djangoproject.com/
- Django Ninja: https://django-ninja.rest-framework.com/
- Python: https://docs.python.org/3/

**Database:**
- PostgreSQL: https://www.postgresql.org/docs/
- PgAdmin: https://www.pgadmin.org/docs/

**DevOps:**
- Docker: https://docs.docker.com/
- Docker Compose: https://docs.docker.com/compose/

**BMad:**
- BMad Method: [Internal knowledge base]

---

## Conclusion

MyPS represents a fully-integrated, production-ready full-stack template built with the BMad Method. It provides:

✅ Complete containerized development environment
✅ Modern technology stack (React + Django + PostgreSQL)
✅ Real-time service monitoring dashboard
✅ Hot reload development workflow
✅ Full BMad framework integration
✅ Comprehensive documentation
✅ Clear roadmap for future enhancements

The template is ready for immediate use as a foundation for new projects, while remaining flexible for customization and extension.

---

**Document Version:** 1.0.0
**Last Updated:** October 1, 2025
**Maintained By:** BMad Orchestrator
**License:** [To be determined by project owner]

---

*Generated using BMad Method™ Comprehensive Documentation Workflow*
