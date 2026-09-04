# SQL — Building Energy Data Analysis

24 T-SQL queries applied to a 12-month building energy dataset — 16 
foundational queries (Days 8–10) plus 8 advanced queries (Day 27). 
Building: 5,000 m² commercial office, UAE region.

What this demonstrates: SELECT, WHERE, ORDER BY, GROUP BY, HAVING, SUM, 
AVG, COUNT, MIN, MAX, DISTINCT, BETWEEN, ROUND, ISNULL, IS NULL, 
subqueries, CTEs, window functions, LAG(), CASE.

Cross-validated against the Power BI dashboard using the same dataset — 
confirms HVAC drives ~60% of peak summer (Jun–Aug) energy use, consistent 
across both tools. Queries run on Microsoft SQL Server 2022 Express.

Certifications: Microsoft Learn T-SQL — all 6 modules complete. 
LEED AP O+M | MSc Sustainable Engineering.

Files:
- SQL_Queries.sql (16 foundational queries — Days 8–10)
- CREATE_energy_data_table.sql (creates the database, table, and loads 
  all 12 months of data — run this first)

Day 27 — Advanced Queries: CTEs, window functions, LAG(), CASE, and a 
subquery on a new GHG dataset (24+ rows, 2 sites). 
See 03_SQL/Day27_Advanced_Queries.
