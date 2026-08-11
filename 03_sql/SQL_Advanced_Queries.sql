CREATE TABLE ghg_data (
    site_id VARCHAR(10),
    site_name VARCHAR(50),
    month VARCHAR(10),
    year INT,
    scope1_co2_t DECIMAL(10,2),
    scope2_co2_t DECIMAL(10,2),
    scope3_co2_t DECIMAL(10,2),
    energy_kwh DECIMAL(10,2),
    employees INT
);

INSERT INTO ghg_data VALUES
('DXB01','Dubai_Office','Jan',2025, 2.10, 25.10, 8.50, 65485, 42),
('DXB01','Dubai_Office','Feb',2025, 2.00, 24.20, 7.20, 63123, 42),
('DXB01','Dubai_Office','Mar',2025, 1.90, 22.38, 9.10, 58396, 42),
('DXB01','Dubai_Office','Apr',2025, 1.80, 21.48, 6.80, 56033, 42),
('DXB01','Dubai_Office','May',2025, 2.00, 23.85, 7.50, 62222, 42),
('DXB01','Dubai_Office','Jun',2025, 2.30, 27.95, 6.20, 72912, 42),
('DXB01','Dubai_Office','Jul',2025, 2.50, 31.10, 5.80, 81127, 42),
('DXB01','Dubai_Office','Aug',2025, 2.40, 30.15, 5.50, 78649, 42),
('DXB01','Dubai_Office','Sep',2025, 2.20, 26.96, 7.90, 70324, 42),
('DXB01','Dubai_Office','Oct',2025, 2.10, 24.97, 8.80, 65147, 42),
('DXB01','Dubai_Office','Nov',2025, 1.90, 23.20, 9.50, 60534, 42),
('DXB01','Dubai_Office','Dec',2025, 2.10, 25.32, 10.20, 66048, 42),
('AUH01','AbuDhabi_Warehouse','Jan',2025, 4.50, 21.47, 3.20, 95000, 58),
('AUH01','AbuDhabi_Warehouse','Feb',2025, 4.20, 20.68, 3.00, 91500, 58),
('AUH01','AbuDhabi_Warehouse','Mar',2025, 3.90, 19.14, 3.40, 84700, 58),
('AUH01','AbuDhabi_Warehouse','Apr',2025, 3.70, 18.36, 3.10, 81250, 58),
('AUH01','AbuDhabi_Warehouse','May',2025, 4.10, 20.39, 3.30, 90200, 58),
('AUH01','AbuDhabi_Warehouse','Jun',2025, 4.80, 23.89, 2.90, 105700, 58),
('AUH01','AbuDhabi_Warehouse','Jul',2025, 5.20, 26.58, 2.70, 117600, 58),
('AUH01','AbuDhabi_Warehouse','Aug',2025, 5.00, 25.76, 2.80, 114000, 58),
('AUH01','AbuDhabi_Warehouse','Sep',2025, 4.60, 23.05, 3.50, 102000, 58),
('AUH01','AbuDhabi_Warehouse','Oct',2025, 4.30, 21.36, 3.60, 94500, 58),
('AUH01','AbuDhabi_Warehouse','Nov',2025, 4.00, 19.84, 3.80, 87800, 58),
('AUH01','AbuDhabi_Warehouse','Dec',2025, 4.40, 21.65, 4.00, 95800, 58);


SELECT COUNT(*) FROM ghg_data;

-- Query 1 — CTE — Total emissions per site per year
-- Business Question: What are the total emissions per site per year?
WITH SiteYearTotals AS (
    SELECT site_name, year,
    SUM(scope1_co2_t + scope2_co2_t + scope3_co2_t) AS total_co2_t
    FROM ghg_data
    GROUP BY site_name, year
)
SELECT * FROM SiteYearTotals ORDER BY site_name, year;

-- Query 2 — Window Function — Running total of Scope 1 emissions by month
-- Business Question: What is the running total of Scope 1 emissions by month, per site?
WITH Ordered AS (
    SELECT *, CASE month WHEN 'Jan' THEN 1 WHEN 'Feb' THEN 2 WHEN 'Mar' THEN 3 WHEN 'Apr' THEN 4 WHEN 'May' THEN 5 WHEN 'Jun' THEN 6 WHEN 'Jul' THEN 7 WHEN 'Aug' THEN 8 WHEN 'Sep' THEN 9 WHEN 'Oct' THEN 10 WHEN 'Nov' THEN 11 WHEN 'Dec' THEN 12 END AS month_num
    FROM ghg_data
)
SELECT site_name, month, year, scope1_co2_t,
SUM(scope1_co2_t) OVER (PARTITION BY site_name ORDER BY year, month_num) AS running_total_scope1
FROM Ordered
ORDER BY site_name, year, month_num;

-- Query 3 — Window Function — Rank sites by total emissions
-- Business Question: Which site has the highest total emissions?
SELECT site_name,
SUM(scope1_co2_t + scope2_co2_t + scope3_co2_t) AS total_emissions,
RANK() OVER (ORDER BY SUM(scope1_co2_t + scope2_co2_t + scope3_co2_t) DESC) AS emissions_rank
FROM ghg_data
GROUP BY site_name;

-- Query 4 — CASE statement — Flag each month as 'Above Target' or 'On Track'
-- Business Question: Which months exceeded the Scope 2 budget of 50 tonnes?
SELECT site_name, month, year, scope2_co2_t,
CASE WHEN scope2_co2_t > 50 THEN 'Above Target' ELSE 'On Track' END AS target_status
FROM ghg_data
ORDER BY site_name, year;

-- Query 5 — CTE + calculation — Carbon intensity per employee per site
-- Business Question: What is the carbon intensity per employee, per site?
WITH SiteTotals AS (
    SELECT site_name,
    SUM(scope1_co2_t + scope2_co2_t + scope3_co2_t) AS total_co2_t,
    AVG(employees) AS avg_employees
    FROM ghg_data
    GROUP BY site_name
)
SELECT site_name, total_co2_t, avg_employees,
total_co2_t / avg_employees AS intensity_per_employee
FROM SiteTotals;

-- Query 6 — Window Function with LAG() — Month-on-month change in total emissions
-- Business Question: How did total emissions change from one month to the next?
WITH Ordered AS (
    SELECT *, CASE month WHEN 'Jan' THEN 1 WHEN 'Feb' THEN 2 WHEN 'Mar' THEN 3 WHEN 'Apr' THEN 4 WHEN 'May' THEN 5 WHEN 'Jun' THEN 6 WHEN 'Jul' THEN 7 WHEN 'Aug' THEN 8 WHEN 'Sep' THEN 9 WHEN 'Oct' THEN 10 WHEN 'Nov' THEN 11 WHEN 'Dec' THEN 12 END AS month_num,
    (scope1_co2_t + scope2_co2_t + scope3_co2_t) AS total_co2_t
    FROM ghg_data
)
SELECT site_name, month, year, total_co2_t,
LAG(total_co2_t) OVER (PARTITION BY site_name ORDER BY year, month_num) AS prior_month_total,
total_co2_t - LAG(total_co2_t) OVER (PARTITION BY site_name ORDER BY year, month_num) AS mom_change
FROM Ordered
ORDER BY site_name, year, month_num;

-- Query 7 — CASE + GROUP BY — Categorise months as Peak or Off-Peak
-- Business Question: How do average emissions compare between peak and off-peak months?
SELECT site_name,
CASE WHEN month IN ('Jun','Jul','Aug') THEN 'Peak' ELSE 'Off-Peak' END AS season,
AVG(scope1_co2_t + scope2_co2_t + scope3_co2_t) AS avg_total_emissions
FROM ghg_data
GROUP BY site_name, CASE WHEN month IN ('Jun','Jul','Aug') THEN 'Peak' ELSE 'Off-Peak' END
ORDER BY site_name, season;

-- Query 8 — Subquery — Find the month with the highest emissions across all sites
-- Business Question: In which month were total emissions (all sites combined) highest?
SELECT month, year, SUM(scope1_co2_t + scope2_co2_t + scope3_co2_t) AS total_all_sites
FROM ghg_data
GROUP BY month, year
HAVING SUM(scope1_co2_t + scope2_co2_t + scope3_co2_t) = (
    SELECT MAX(monthly_total) FROM (
        SELECT SUM(scope1_co2_t + scope2_co2_t + scope3_co2_t) AS monthly_total
        FROM ghg_data
        GROUP BY month, year
    ) AS MonthlyTotals
);