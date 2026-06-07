CREATE EXTENSION IF NOT EXISTS vector;

CREATE TABLE IF NOT EXISTS documentos (
    id          SERIAL PRIMARY KEY,
    nombre      VARCHAR(255) NOT NULL,
    tipo        VARCHAR(50),
    -- 'politica_midtech' | 'iso27001' | 'rgpd' | 'ens'
    fecha_carga TIMESTAMP DEFAULT NOW(),
    hash_md5    VARCHAR(32) UNIQUE
    -- evita cargar el mismo doc dos veces
);

CREATE TABLE IF NOT EXISTS chunks (
    id            SERIAL PRIMARY KEY,
    documento_id  INTEGER REFERENCES documentos(id) ON DELETE CASCADE,
    contenido     TEXT NOT NULL,
    embedding     vector(768),
    metadata      JSONB,
    created_at    TIMESTAMP DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_chunks_embedding
    ON chunks USING ivfflat (embedding vector_cosine_ops)
    WITH (lists = 50);

CREATE INDEX IF NOT EXISTS idx_chunks_doc
    ON chunks(documento_id);

CREATE TABLE IF NOT EXISTS conversaciones (
    id          SERIAL PRIMARY KEY,
    session_id  VARCHAR(100) NOT NULL,
    rol         VARCHAR(20)  NOT NULL,
    mensaje     TEXT NOT NULL,
    capacidad   VARCHAR(20),
    created_at  TIMESTAMP DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_conv_session
    ON conversaciones(session_id);

CREATE TABLE IF NOT EXISTS gap_analysis (
    id                   SERIAL PRIMARY KEY,
    session_id           VARCHAR(100),
    area_normativa       VARCHAR(255),
    carencia_detectada   TEXT,
    criticidad           VARCHAR(10),
    referencia_normativa VARCHAR(255),
    created_at           TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS mejoras (
    id                   SERIAL PRIMARY KEY,
    session_id           VARCHAR(100),
    mejora_propuesta     TEXT,
    normativa_justifica  VARCHAR(255),
    prioridad            VARCHAR(10),
    esfuerzo_estimado    VARCHAR(10),
    created_at           TIMESTAMP DEFAULT NOW()
);