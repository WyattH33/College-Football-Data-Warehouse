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

Training Rules:
- Session length: 30–45 minutes
- 1 objective per session
- Artifact required (table, query, or pipeline)
- If stuck >10 min, write bad SQL, then improve

Tomorrows Objective:
- Load the raw game JSON files into a raw_games table in DuckDB and verify I can query the row count. git test. 
