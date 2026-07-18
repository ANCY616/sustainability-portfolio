USE sustainability;
GO
-- ============================================================
-- SQL PORTFOLIO — SUSTAINABILITY ENERGY DATA ANALYSIS
-- ============================================================
-- Author:      Ancy Antony | LEED AP O+M | MSc Sustainable Engineering
-- Dataset:     Benchmarked monthly energy data — 12-month building dataset
-- Building:    5,000 m2 commercial office, UAE region
-- Context:     Benchmarked against Emirates Green Building Council
--              figures and UAE Ministry of Energy grid emission factor
--              (0.3833 kg CO2e/kWh · Source: DEWA Sustainability Report 2025). 
--              VAC-dominated load profile.
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
SELECT Month, Total_kWh
FROM energy_data
WHERE Total_kWh > 6000

-- ============================================================
-- QUERY 3: WHERE — Find High Emission Months
-- ============================================================
-- Filter months where CO2 exceeded 2500 kg — priority months for intervention
SELECT Month, Emissions_kgCO2e
FROM energy_data
WHERE Emissions_kgCO2e > 2500
ORDER BY Emissions_kgCO2e DESC

-- ============================================================
-- QUERY 4: ORDER BY — Rank Months by Carbon Emissions
-- ============================================================
-- Sort months from highest to lowest CO2 — worst performers appear first
SELECT Month, HVAC_kWh
FROM energy_data
ORDER BY HVAC_kWh DESC

-- ============================================================
-- QUERY 5: IS NULL — Check for Missing Data
-- ============================================================
-- Check for missing CO2 data — gaps are a compliance risk in ESG reporting
SELECT Month, Emissions_kgCO2e
FROM energy_data
WHERE Emissions_kgCO2e IS NULL

-- ============================================================
-- QUERY 6: SUM + GROUP BY — Monthly CO2 Totals
-- ============================================================
-- Add up total CO2 for each month — foundation of a Scope 2 carbon report
SELECT Month, SUM(Emissions_kgCO2e) AS Total_Emissions
FROM energy_data
GROUP BY Month

-- ============================================================
-- QUERY 7: AVG — Average HVAC Consumption
-- ============================================================
-- Calculate average HVAC energy across the whole year — baseline for efficiency targets
SELECT AVG(HVAC_kWh) AS Avg_HVAC,
       AVG(Lighting_kWh) AS Avg_Lighting
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
SELECT Month, Emissions_kgCO2e
FROM energy_data
WHERE Emissions_kgCO2e = (SELECT MAX(Emissions_kgCO2e) FROM energy_data)

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
SELECT Month, Emissions_kgCO2e
FROM energy_data
WHERE Emissions_kgCO2e = (SELECT MIN(Emissions_kgCO2e) FROM energy_data)

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
SELECT DISTINCT Emissions_kgCO2e
FROM energy_data

-- ============================================================
-- QUERY 14: HAVING — Filter Groups After Aggregation
-- ============================================================
-- Find months where total CO2 exceeded 2500 — HAVING filters after grouping, WHERE filters before
SELECT Month, SUM(Emissions_kgCO2e) AS Total_CO2
FROM energy_data
GROUP BY Month
HAVING SUM(Emissions_kgCO2e) > 2500

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
SELECT Month, ISNULL(Emissions_kgCO2e, 0) AS CO2_Cleaned
FROM energy_data
