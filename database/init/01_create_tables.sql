-- =========================================
-- SAMPLE PROJECT DATABASE INITIALIZATION
-- Arquivo: database/init/01_create_tables.sql
-- =========================================

\echo 'Initializing Sample Project database...'

-- Useful PostgreSQL extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";

-- Example table structure (customize for your project)
CREATE TABLE IF NOT EXISTS sample_data (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Index
CREATE INDEX IF NOT EXISTS idx_sample_data_name ON sample_data(name);

-- Auto-update timestamp function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Trigger for auto-update
DROP TRIGGER IF EXISTS update_sample_data_updated_at ON sample_data;
CREATE TRIGGER update_sample_data_updated_at
    BEFORE UPDATE ON sample_data
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

\echo 'Sample Project database structure created successfully!'
\echo 'Table: sample_data (example - customize as needed)'
