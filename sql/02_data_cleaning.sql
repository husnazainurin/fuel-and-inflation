-- Set target database
USE FuelInflationDB

--------- FuelPrice ----------
-- View table
SELECT *
FROM FuelPrice

-- Select relevant columns
ALTER TABLE FuelPrice
DROP COLUMN ron95_budi95, ron95_skps, diesel_skds, diesel_budi, diesel_eastmsia

-- Drop series_type change_weekly (This can be derived using previous value)
DELETE FROM FuelPrice
WHERE series_type = 'change_weekly'

-- Downsample to 1 row per month, aggregate using mean
SELECT
    DATEFROMPARTS(YEAR(date), MONTH(date), 1) AS date,
    AVG(ron95) AS ron95,
    AVG(ron97) AS ron97,
    AVG(diesel) AS diesel
INTO FuelPrice_Monthly
FROM FuelPrice
GROUP BY DATEFROMPARTS(YEAR(date), MONTH(date), 1);

DROP TABLE FuelPrice;
EXEC sp_rename 'FuelPrice_Monthly', 'FuelPrice';

--------- Inflation ----------
-- View table
SELECT *
FROM Inflation







