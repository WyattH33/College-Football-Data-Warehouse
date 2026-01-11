
CREATE OR REPLACE TABLE staging.stg_games AS
SELECT
  -- ids / time
  CAST(json_extract(payload, '$.id') AS BIGINT)                              AS game_id,
  CAST(json_extract(payload, '$.season') AS INTEGER)                         AS season,
  CAST(json_extract(payload, '$.week') AS INTEGER)                           AS week,
  json_extract_string(payload, '$.seasonType')                               AS season_type,
  CAST(json_extract_string(payload, '$.startDate') AS TIMESTAMP)             AS start_date_utc,
  CAST(json_extract(payload, '$.startTimeTBD') AS BOOLEAN)                   AS start_time_tbd,
  CAST(json_extract(payload, '$.completed') AS BOOLEAN)                      AS completed,

  -- context
  CAST(json_extract(payload, '$.neutralSite') AS BOOLEAN)                    AS neutral_site,
  CAST(json_extract(payload, '$.conferenceGame') AS BOOLEAN)                 AS conference_game,
  CAST(json_extract(payload, '$.attendance') AS INTEGER)                     AS attendance,
  CAST(json_extract(payload, '$.venueId') AS INTEGER)                        AS venue_id,
  json_extract_string(payload, '$.venue')                                    AS venue,

  -- home
  CAST(json_extract(payload, '$.homeId') AS INTEGER)                          AS home_id,
  json_extract_string(payload, '$.homeTeam')                                  AS home_team,
  json_extract_string(payload, '$.homeClassification')                        AS home_classification,
  json_extract_string(payload, '$.homeConference')                            AS home_conference,
  CAST(json_extract(payload, '$.homePoints') AS INTEGER)                      AS home_points,
  CAST(json_extract(payload, '$.homePregameElo') AS INTEGER)                  AS home_pregame_elo,
  CAST(json_extract(payload, '$.homePostgameElo') AS INTEGER)                 AS home_postgame_elo,
  CAST(json_extract(payload, '$.homePostgameWinProbability') AS DOUBLE)       AS home_postgame_win_probability,

  -- away
  CAST(json_extract(payload, '$.awayId') AS INTEGER)                          AS away_id,
  json_extract_string(payload, '$.awayTeam')                                  AS away_team,
  json_extract_string(payload, '$.awayClassification')                        AS away_classification,
  json_extract_string(payload, '$.awayConference')                            AS away_conference,
  CAST(json_extract(payload, '$.awayPoints') AS INTEGER)                      AS away_points,
  CAST(json_extract(payload, '$.awayPregameElo') AS INTEGER)                  AS away_pregame_elo,
  CAST(json_extract(payload, '$.awayPostgameElo') AS INTEGER)                 AS away_postgame_elo,
  CAST(json_extract(payload, '$.awayPostgameWinProbability') AS DOUBLE)       AS away_postgame_win_probability,

  -- misc
  CAST(json_extract(payload, '$.excitementIndex') AS DOUBLE)                  AS excitement_index,
  json_extract_string(payload, '$.highlights')                                AS highlights,
  json_extract_string(payload, '$.notes')                                     AS notes,

  -- lineage
  source_file,
  ingested_at

FROM raw.raw_games;
