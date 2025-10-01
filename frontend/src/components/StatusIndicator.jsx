import React from 'react';
import './StatusIndicator.css';

const StatusIndicator = ({ serviceName, status }) => {
  const getStatusSymbol = () => {
    switch (status) {
      case 'ok':
      case 'connected':
      case 'operational':
        return '✓';
      case 'error':
      case 'disconnected':
        return '✗';
      case 'checking':
      case 'loading':
        return '...';
      default:
        return '?';
    }
  };

  const getStatusClass = () => {
    switch (status) {
      case 'ok':
      case 'connected':
      case 'operational':
        return 'status-ok';
      case 'error':
      case 'disconnected':
        return 'status-error';
      case 'checking':
      case 'loading':
        return 'status-checking';
      default:
        return 'status-unknown';
    }
  };

  return (
    <div className={`status-indicator ${getStatusClass()}`}>
      <span className="service-name">{serviceName}</span>
      <span className="status-symbol">{getStatusSymbol()}</span>
    </div>
  );
};

export default StatusIndicator;
