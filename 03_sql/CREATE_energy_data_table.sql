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
INSERT INTO energy_data VALUES ('Jan', 5820, 3370, 1240, 1210, 2230.8, 1);
INSERT INTO energy_data VALUES ('Feb', 5610, 3180, 1220, 1210, 2150.3, 2);
INSERT INTO energy_data VALUES ('Mar', 5190, 2980, 1130, 1080, 1989.3, 3);
INSERT INTO energy_data VALUES ('Apr', 4980, 2760, 1110, 1110, 1908.5, 4);
INSERT INTO energy_data VALUES ('May', 5530, 3260, 1160, 1110, 2119.6, 5);
INSERT INTO energy_data VALUES ('Jun', 6480, 3980, 1290, 1210, 2483.8, 6);
INSERT INTO energy_data VALUES ('Jul', 7210, 4530, 1380, 1300, 2763.6, 7);
INSERT INTO energy_data VALUES ('Aug', 6990, 4350, 1340, 1300, 2679.3, 8);
INSERT INTO energy_data VALUES ('Sep', 6250, 3840, 1210, 1200, 2395.6, 9);
INSERT INTO energy_data VALUES ('Oct', 5790, 3410, 1180, 1200, 2219.3, 10);
INSERT INTO energy_data VALUES ('Nov', 5380, 3080, 1140, 1160, 2062.2, 11);
INSERT INTO energy_data VALUES ('Dec', 5870, 3410, 1230, 1230, 2250.0, 12);

-- Step 4: Confirm it worked — you should see all 12 rows
SELECT * FROM energy_data;
