USE FuelInflationDB

-- View FuelPrice table
SELECT *
FROM FuelPrice

-- View Inflation table
SELECT *
FROM Inflation

-- PLANNING PHASE

-- Q: How have fuel prices and CPI changed over time in Malaysia?
-- Visualization:
--      Time-series graph
--          X-axis: Date
--          Y-axis 1: Lines, Fuel Price
--          Y-axis 2: Bar, Overall CPI


-- Q: When fuel prices change, does CPI tend to change in the same direction?
-- Visualization:
--      Scatter plot
--          X-axis: Change in Fuel Price (difference)
--          Y-axis: Overall CPI


-- Q: Does CPI respond immediately to fuel-price changes, or does the relationship appear later?
-- Visualization:
--      Cross-correlation Chart of Lag Variables
--          X-axis: Number of lags
--          Y-axis: Correlation coefficient



-- Q: Which fuel type has the strongest relationship with CPI changes?
-- Visualization:
--      Ranked Horizontal Bar Chart
--          X axis: Fuel Type
--          Y axis: Correlation coefficient


-- Q: Which consumer spending categories show the strongest relationship with fuel-price changes?
-- Visualization:
--

-- 




-- What can we conclude about the relationship between fuel prices and Malaysia's inflation?

-- Calculate chage from month to month
SELECT [date], ron95, ron97, diesel,
    ron95 - LAG(ron95) OVER (
    ORDER BY [date]
    ) AS ron95_change,

    ron97 - LAG(ron97) OVER (
        ORDER BY [date]
    ) AS ron97_change,

    diesel - LAG(diesel) OVER (
        ORDER BY [date]
    ) AS diesel_change
FROM FuelPrice






WITH FuelChanges AS (
    SELECT
        [date],
        ron95,
        ron97,
        diesel,

        ron95 - LAG(ron95) OVER (
            ORDER BY [date]
        ) AS ron95_change,

        ron97 - LAG(ron97) OVER (
            ORDER BY [date]
        ) AS ron97_change,

        diesel - LAG(diesel) OVER (
            ORDER BY [date]
        ) AS diesel_change

    FROM FuelPrice
)


SELECT *
FROM FuelChanges
ORDER BY [date];
