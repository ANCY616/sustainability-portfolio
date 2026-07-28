IF DB_ID('sustainability') IS NULL
    CREATE DATABASE sustainability;
GO
USE sustainability;
GO
    
-- ============================================================
-- SETUP SCRIPT — Create energy_data table and insert data
-- Run this FIRST before running SQL_Queries.sql
-- ============================================================
    
-- Step 1: Delete the table if it already exists (so you can re-run safely)
IF OBJECT_ID('energy_data', 'U') IS NOT NULL
    DROP TABLE energy_data;

-- Step 2: Create the table
CREATE TABLE energy_data (
    Month        VARCHAR(10),
    Total_kWh    INT,
    HVAC_kWh     INT,
    Lighting_kWh INT,
    Equipment_kWh INT,
    Emissions_kgCO2e DECIMAL(10,1),
    Month_Num    INT
);

-- Step 3: Insert all 12 months of data
INSERT INTO energy_data VALUES ('Jan', 65485, 37918, 13952, 13615, 25100.4, 1);
INSERT INTO energy_data VALUES ('Feb', 63123, 35781, 13727, 13615, 24195.0, 2);
INSERT INTO energy_data VALUES ('Mar', 58396, 33530, 12714, 12152, 22383.2, 3);
INSERT INTO energy_data VALUES ('Apr', 56033, 31055, 12489, 12489, 21477.4, 4);
INSERT INTO energy_data VALUES ('May', 62222, 36681, 13052, 12489, 23849.7, 5);
INSERT INTO energy_data VALUES ('Jun', 72912, 44782, 14515, 13615, 27947.2, 6);
INSERT INTO energy_data VALUES ('Jul', 81127, 50973, 15527, 14627, 31096.0, 7);
INSERT INTO energy_data VALUES ('Aug', 78649, 48945, 15077, 14627, 30146.2, 8);
INSERT INTO energy_data VALUES ('Sep', 70324, 43207, 13615, 13502, 26955.2, 9);
INSERT INTO energy_data VALUES ('Oct', 65147, 38368, 13277, 13502, 24970.8, 10);
INSERT INTO energy_data VALUES ('Nov', 60534, 34655, 12827, 13052, 23202.7, 11);
INSERT INTO energy_data VALUES ('Dec', 66048, 38368, 13840, 13840, 25316.2, 12);

-- Step 4: Confirm it worked — you should see all 12 rows
SELECT * FROM energy_data;
