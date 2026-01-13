# College-Football-Data-Warehouse

Goal:
Build a production-style data warehouse for college football analytics
using SQL-first design.

Primary Skills:
- SQL (joins, aggregations, window functions)
- Schema design (star/snowflake)
- Data ingestion and transformation
- Query performance and correctness

End State:
- Raw data → cleaned warehouse tables
- Reproducible pipelines
- Answer real football questions via SQL

Rules:
- SQL before Python
- Every session produces an artifact
- No dashboards until warehouse works

### Ingest games (example)
python ingest_games.py --season 2024 --week 1

Tomorrows Objective:
- Build a season-level team fact mart and validate aggregation logic using Week 1 data.
