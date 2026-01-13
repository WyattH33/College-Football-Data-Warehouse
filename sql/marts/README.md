## Marts

Marts contain analytics-ready tables designed around specific questions.

### marts.fct_team_games

**Grain:** one row per team per game (two rows per game)

**Purpose:**  
Enable team-level analysis without home/away conditional logic.

**Key fields:**
- team, opponent
- points_for, points_against
- margin
- win_flag
- season, week

**Notes:**
- Built from `staging.stg_games`
- Uses `UNION ALL` to preserve one row per team-game appearance
- Rebuildable from raw via staging
