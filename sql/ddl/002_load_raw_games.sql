INSERT INTO raw.raw_games
SELECT
  'data/raw/games/year=2024/week=1.json' AS source_file,
  now() AS ingested_at,
  json AS payload
FROM read_json_objects('data/raw/games/year=2024/week=1.json');
