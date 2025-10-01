"""
API views for sample_project using Django Ninja.
"""
from ninja import NinjaAPI
from django.db import connection
from datetime import datetime

api = NinjaAPI()


@api.get("/health")
def health_check(request):
    """
    Health check endpoint that verifies backend and database connectivity.

    Returns:
        dict: Status of backend and database with timestamp
    """
    response = {
        "status": "ok",
        "backend": "operational",
        "database": "disconnected",
        "timestamp": datetime.now().isoformat()
    }

    # Check database connection
    try:
        with connection.cursor() as cursor:
            cursor.execute("SELECT 1")
            cursor.fetchone()
        response["database"] = "connected"
    except Exception as e:
        response["status"] = "error"
        response["error"] = str(e)

    return response


@api.get("/")
def root(request):
    """
    Root API endpoint with basic information.
    """
    return {
        "message": "Sample Project API",
        "version": "1.0.0",
        "endpoints": {
            "health": "/api/health",
            "docs": "/api/docs"
        }
    }
