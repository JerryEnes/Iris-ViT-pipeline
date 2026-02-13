@'
CREATE TABLE IF NOT EXISTS iris_features (
    id SERIAL PRIMARY KEY,
    user_id VARCHAR(100),
    feature_vector JSONB,
    image_path TEXT,
    quality_score FLOAT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS vein_features (
    id SERIAL PRIMARY KEY,
    user_id VARCHAR(100),
    feature_vector JSONB,
    image_path TEXT,
    quality_score FLOAT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS authentication_logs (
    id SERIAL PRIMARY KEY,
    user_id VARCHAR(100),
    iris_score FLOAT,
    vein_score FLOAT,
    fusion_score FLOAT,
    decision BOOLEAN,
    response_time_ms INTEGER,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
'@ | Out-File -FilePath docker\postgres-init\init.sql -Encoding UTF8 -Force
