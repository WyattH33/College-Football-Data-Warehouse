CREATE SCHEMA IF NOT EXISTS raw;

CREATE TABLE IF NOT EXISTS raw.raw_games (
  source_file VARCHAR,
  ingested_at TIMESTAMP,
  payload JSON
);
