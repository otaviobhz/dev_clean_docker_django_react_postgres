# Sample Project - Full Stack Template

A production-ready full-stack template with **React**, **Django Ninja**, and **PostgreSQL**, fully Dockerized for easy deployment.

## 🚀 Quick Start

### Prerequisites
- Docker Desktop (Windows/Linux)
- Git

### Getting Started

1. **Clone the repository** (or use this template)
   ```bash
   git clone <your-repo-url>
   cd sample_project
   ```

2. **Start all services**
   ```bash
   docker compose up --build
   ```

3. **Access the services**
   - **Frontend Dashboard**: http://localhost:8081
   - **Backend API**: http://localhost:8001/api/
   - **API Docs**: http://localhost:8001/api/docs
   - **Jupyter Notebook**: http://localhost:9000
   - **PgAdmin**: http://localhost:5051

## 📊 Status Dashboard

The frontend includes a built-in status dashboard that shows real-time health checks for:
- ✅ Frontend (React)
- ✅ Backend API (Django Ninja)
- ✅ Database (PostgreSQL)

Visit http://localhost:8081 after starting the services to see all status indicators.

## 🛠️ Technology Stack

### Frontend
- **React** 18.2.0
- **React Scripts** 5.0.1
- Custom Status Dashboard

### Backend
- **Python** 3.x
- **Django** (latest)
- **Django Ninja** (API framework)
- **Jupyter Notebook** (development environment)

### Database
- **PostgreSQL** 15
- **PgAdmin** 4 (database administration)

### DevOps
- **Docker & Docker Compose**
- Fully containerized setup
- Cross-platform (Windows/Linux)

## 📡 Service Ports

| Service          | Port  | Description                    |
|------------------|-------|--------------------------------|
| Frontend         | 8081  | React application              |
| Backend API      | 8001  | Django Ninja REST API          |
| Jupyter Notebook | 9000  | Development notebooks          |
| PostgreSQL       | 5433  | Database server                |
| PgAdmin          | 5051  | Database administration UI     |

## 🔧 Development

### Development Mode

For development with hot-reload:

```bash
docker compose -f docker-compose.dev.yml up
```

### Database Access

**PgAdmin Credentials:**
- Email: `admin@sample_project.com`
- Password: `12345`

**PostgreSQL Connection:**
- Host: `postgres_db` (from containers) or `localhost` (from host)
- Port: `5433`
- Database: `sample_project_db`
- User: `admin`
- Password: `12345`

### API Endpoints

#### Health Check
```bash
curl http://localhost:8001/api/health
```

Response:
```json
{
  "status": "ok",
  "backend": "operational",
  "database": "connected",
  "timestamp": "2025-09-30T..."
}
```

#### API Root
```bash
curl http://localhost:8001/api/
```

## 📁 Project Structure

```
sample_project/
├── backend/
│   ├── django_project/      # Django application
│   │   ├── api/              # Django Ninja API app
│   │   └── django_project/   # Django settings
│   ├── database/
│   │   ├── init/             # Database initialization scripts
│   │   ├── backups/          # Database backups
│   │   └── pgadmin-config/   # PgAdmin configuration
│   ├── Dockerfile
│   └── requirements.txt
├── frontend/
│   ├── public/
│   ├── src/
│   │   ├── components/       # React components
│   │   │   ├── Dashboard.jsx
│   │   │   └── StatusIndicator.jsx
│   │   ├── App.js
│   │   └── index.js
│   ├── Dockerfile
│   └── package.json
├── docs/
│   ├── brainstorming-session-results.md
│   └── stories/
├── docker-compose.yml        # Production config
├── docker-compose.dev.yml    # Development config
└── README.md
```

## 🧪 Testing

1. **Start the stack**
   ```bash
   docker compose up --build
   ```

2. **Check container status**
   ```bash
   docker compose ps
   ```

3. **View logs**
   ```bash
   docker compose logs -f
   ```

4. **Verify services**
   - Frontend: Open http://localhost:8081 - should show green checkmarks
   - Backend API: `curl http://localhost:8001/api/health`
   - Database: Connect via PgAdmin at http://localhost:5051

## 🔄 Common Commands

### Stop all services
```bash
docker compose down
```

### Stop and remove volumes (fresh start)
```bash
docker compose down -v
```

### Rebuild specific service
```bash
docker compose up --build frontend
```

### View service logs
```bash
docker compose logs -f backend
docker compose logs -f frontend
docker compose logs -f postgres_db
```

### Execute commands in container
```bash
docker compose exec backend bash
docker compose exec frontend sh
```

## 📝 Customization

This is a blank template ready for your project. Here's what to customize:

1. **Database Schema**: Edit `backend/database/init/01_create_tables.sql`
2. **API Endpoints**: Add to `backend/django_project/api/views.py`
3. **Frontend Components**: Add to `frontend/src/components/`
4. **Environment Variables**: Create `.env` files based on `.env.example`

## 🚨 Troubleshooting

### Containers won't start
```bash
docker compose down -v
docker compose up --build
```

### Port conflicts
Check if ports are already in use:
```bash
# Windows
netstat -ano | findstr "8081"
netstat -ano | findstr "8001"

# Linux
lsof -i :8081
lsof -i :8001
```

### Database connection issues
- Ensure PostgreSQL container is healthy: `docker compose ps`
- Check logs: `docker compose logs postgres_db`
- Verify connection in PgAdmin

### Frontend can't reach backend
- Verify backend is running: `curl http://localhost:8001/api/health`
- Check browser console for CORS errors
- Ensure containers are on same network

## 📚 Additional Resources

- [Django Ninja Documentation](https://django-ninja.rest-framework.com/)
- [React Documentation](https://react.dev/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## 📄 License

This is a template project - customize and use as needed for your projects.

---

**Template Version**: 1.0.0
**Created**: 2025-09-30
**Template Framework**: PostgreSQL + Django Ninja + React + Docker
