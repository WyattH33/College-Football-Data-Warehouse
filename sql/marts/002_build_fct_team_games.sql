
CREATE SCHEMA IF NOT EXISTS marts;

CREATE OR REPLACE TABLE marts.fct_team_games AS
WITH team_game_rows AS (
    -- Home team row (one row per game for the home team)
    SELECT
        game_id,
        season,
        week,
        season_type,
        start_date_utc,

        home_id AS team_id,
        home_team AS team,
        home_conference AS conference,
        home_classification AS classification,

        away_id AS opponent_id,
        away_team AS opponent,
        away_conference AS opponent_conference,
        away_classification AS opponent_classification,

        TRUE AS is_home,

        home_points AS points_for,
        away_points AS points_against,

        source_file,
        ingested_at
    FROM staging.stg_games

    UNION ALL

    -- Away team row (one row per game for the away team)
    SELECT
        game_id,
        season,
        week,
        season_type,
        start_date_utc,

        away_id AS team_id,
        away_team AS team,
        away_conference AS conference,
        away_classification AS classification,

        home_id AS opponent_id,
        home_team AS opponent,
        home_conference AS opponent_conference,
        home_classification AS opponent_classification,

        FALSE AS is_home,

        away_points AS points_for,
        home_points AS points_against,

        source_file,
        ingested_at
    FROM staging.stg_games
)
SELECT
    *,
    (points_for - points_against) AS margin,
    CASE
        WHEN points_for > points_against THEN TRUE
        WHEN points_for < points_against THEN FALSE
        ELSE NULL
    END AS win_flag
FROM team_game_rows;
