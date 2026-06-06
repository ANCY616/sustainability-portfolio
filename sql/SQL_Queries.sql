-- ============================================================
-- SQL PORTFOLIO — SUSTAINABILITY ENERGY DATA ANALYSIS
-- ============================================================
-- Author:      Ancy Antony | LEED AP O+M | MSc Sustainable Engineering
-- Dataset:     Simulated monthly energy data — 12-month building dataset
-- Building:    5,000 m2 commercial office, UAE region
-- Context:     Benchmarked against Emirates Green Building Council
--              figures and UAE Ministry of Energy grid emission factor
--              (0.4 kg CO2/kWh). HVAC-dominated load profile.
-- Purpose:     Demonstrate SQL querying skills applied to sustainability
--              data — for portfolio and ESG analyst role applications
-- Queries:     16 queries covering SELECT, WHERE, ORDER BY, GROUP BY,
--              SUM, AVG, COUNT, MIN, MAX, TOP, DISTINCT, BETWEEN,
--              ROUND, ISNULL, IS NULL, subqueries, HAVING
-- ============================================================

-- ============================================================
-- QUERY 1: SELECT ALL — View Full Dataset
-- ============================================================
-- Show all energy and emissions data across all 12 months
SELECT *
FROM energy_data

-- ============================================================
-- QUERY 2: SELECT COLUMNS — Monthly CO2 Figures
-- ============================================================
-- Show month and CO2 figures only — starting point for carbon reporting
SELECT Month, CO2_kg
FROM energy_data

-- ============================================================
-- QUERY 3: WHERE — Find High Emission Months
-- ============================================================
-- Filter months where CO2 exceeded 2500 kg — priority months for intervention
SELECT Month, CO2_kg
FROM energy_data
WHERE CO2_kg > 2500

-- ============================================================
-- QUERY 4: ORDER BY — Rank Months by Carbon Emissions
-- ============================================================
-- Sort months from highest to lowest CO2 — worst performers appear first
SELECT Month, CO2_kg
FROM energy_data
ORDER BY CO2_kg DESC

-- ============================================================
-- QUERY 5: IS NULL — Check for Missing Data
-- ============================================================
-- Check for missing CO2 data — gaps are a compliance risk in ESG reporting
SELECT Month, CO2_kg
FROM energy_data
WHERE CO2_kg IS NULL

-- ============================================================
-- QUERY 6: SUM + GROUP BY — Monthly CO2 Totals
-- ============================================================
-- Add up total CO2 for each month — foundation of a Scope 2 carbon report
SELECT Month, SUM(CO2_kg) AS Tally
FROM energy_data
GROUP BY Month

-- ============================================================
-- QUERY 7: AVG — Average HVAC Consumption
-- ============================================================
-- Calculate average HVAC energy across the whole year — baseline for efficiency targets
SELECT AVG(HVAC_kWh) AS Average
FROM energy_data

-- ============================================================
-- QUERY 8: COUNT — Peak HVAC Months
-- ============================================================
-- Count months where HVAC exceeded 4000 kWh — scopes seasonal BMS interventions
SELECT COUNT(*) AS High_HVAC_Months
FROM energy_data
WHERE HVAC_kWh > 4000

-- ============================================================
-- QUERY 9: TOP 3 — Highest Energy Months
-- ============================================================
-- Find the 3 highest energy consumption months — primary targets for demand reduction
SELECT TOP 3 Month, Total_kWh
FROM energy_data
ORDER BY Total_kWh DESC

-- ============================================================
-- QUERY 10: MAX SUBQUERY — Peak Energy Month
-- ============================================================
-- Find the single peak energy month — drives BMS scheduling and demand response strategy
SELECT Month, Total_kWh
FROM energy_data
WHERE Total_kWh = (SELECT MAX(Total_kWh) FROM energy_data)

-- ============================================================
-- QUERY 11: MIN SUBQUERY — Best Performing Month
-- ============================================================
-- Find the month with the lowest CO2 emissions — best performing month of the year
SELECT Month, CO2_kg
FROM energy_data
WHERE CO2_kg = (SELECT MIN(CO2_kg) FROM energy_data)

-- ============================================================
-- QUERY 12: BETWEEN — Normal Operating Range
-- ============================================================
-- Find months with moderate energy use between 5000 and 7000 kWh — identifies normal operating range
SELECT Month, Total_kWh
FROM energy_data
WHERE Total_kWh BETWEEN 5000 AND 7000

-- ============================================================
-- QUERY 13: DISTINCT — Unique CO2 Values
-- ============================================================
-- Show all unique CO2 values — removes duplicates to see distinct emission levels
SELECT DISTINCT CO2_kg
FROM energy_data

-- ============================================================
-- QUERY 14: HAVING — Filter Groups After Aggregation
-- ============================================================
-- Find months where total CO2 exceeded 2500 — HAVING filters after grouping, WHERE filters before
SELECT Month, SUM(CO2_kg) AS Total_CO2
FROM energy_data
GROUP BY Month
HAVING SUM(CO2_kg) > 2500

-- ============================================================
-- QUERY 15: ROUND — HVAC Percentage per Month
-- ============================================================
-- Calculate HVAC energy as a percentage of total energy per month — highest share months need urgent efficiency intervention
SELECT Month, ROUND(HVAC_kWh * 100.0 / Total_kWh, 1) AS HVAC_Percent
FROM energy_data
ORDER BY HVAC_Percent DESC

-- ============================================================
-- QUERY 16: ISNULL — Handle Missing Data
-- ============================================================
-- Replace missing CO2 values with 0 — ensures no gaps in ESG reporting data
SELECT Month, ISNULL(CO2_kg, 0) AS CO2_Cleaned
FROM energy_data