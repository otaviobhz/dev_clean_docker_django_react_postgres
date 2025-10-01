import React, { useState, useEffect } from 'react';
import StatusIndicator from './StatusIndicator';
import './Dashboard.css';

const Dashboard = () => {
  const [frontendStatus, setFrontendStatus] = useState('ok');
  const [backendStatus, setBackendStatus] = useState('checking');
  const [databaseStatus, setDatabaseStatus] = useState('checking');
  const [lastCheck, setLastCheck] = useState(null);
  const [error, setError] = useState(null);

  const checkHealth = async () => {
    try {
      setError(null);
      setBackendStatus('checking');
      setDatabaseStatus('checking');

      const response = await fetch('http://localhost:8001/api/health', {
        mode: 'cors',
        headers: {
          'Content-Type': 'application/json',
        },
      });

      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }

      const data = await response.json();

      setBackendStatus(data.backend || 'error');
      setDatabaseStatus(data.database || 'error');
      setLastCheck(new Date().toLocaleTimeString());

    } catch (err) {
      console.error('Health check failed:', err);
      setError(err.message);
      setBackendStatus('error');
      setDatabaseStatus('error');
    }
  };

  useEffect(() => {
    // Check immediately on mount
    checkHealth();

    // Then check every 10 seconds
    const interval = setInterval(checkHealth, 10000);

    return () => clearInterval(interval);
  }, []);

  return (
    <div className="dashboard-container">
      <div className="dashboard-card">
        <header className="dashboard-header">
          <h1>Sample Project Status Dashboard</h1>
          <p className="subtitle">Full Stack Template - Health Check</p>
        </header>

        <div className="status-grid">
          <StatusIndicator
            serviceName="Frontend"
            status={frontendStatus}
          />
          <StatusIndicator
            serviceName="Backend API"
            status={backendStatus}
          />
          <StatusIndicator
            serviceName="Database"
            status={databaseStatus}
          />
        </div>

        {error && (
          <div className="error-message">
            <strong>Connection Error:</strong> {error}
            <p className="error-hint">Make sure the backend is running on port 8001</p>
          </div>
        )}

        <div className="dashboard-footer">
          <button onClick={checkHealth} className="refresh-button">
            Refresh Status
          </button>
          {lastCheck && (
            <p className="last-check">Last checked: {lastCheck}</p>
          )}
        </div>

        <div className="info-section">
          <h3>Service Information</h3>
          <ul className="info-list">
            <li><strong>Frontend:</strong> React App running on port 8081</li>
            <li><strong>Backend:</strong> Django Ninja API on port 8001</li>
            <li><strong>Database:</strong> PostgreSQL on port 5433</li>
            <li><strong>Jupyter:</strong> Notebook server on port 9000</li>
            <li><strong>PgAdmin:</strong> Database admin on port 5051</li>
          </ul>
        </div>
      </div>
    </div>
  );
};

export default Dashboard;
