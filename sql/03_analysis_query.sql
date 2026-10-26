USE FuelInflationDB

-- View FuelPrice table
SELECT *
FROM FuelPrice


-- View latest inflation rate
SELECT TOP 1
        [date],
        division, 
        [index] - LAG([index]) OVER (
        ORDER BY date)
        AS inflation_rate
FROM Inflation
WHERE division = 'overall'
ORDER BY date DESC

-- Calculate average inflation rate
WITH InflationRate AS (
    SELECT
        [date],
        division, 
        [index],
        [index] - LAG([index]) OVER (
        ORDER BY date)
        AS inflation_rate
    FROM Inflation
    WHERE division = 'overall'
)
SELECT AVG(inflation_rate) AS average_inflation
FROM InflationRate

-- Calculate cumulative CPI change
SELECT * FROM Inflation WHERE date = '2026-01-01' AND division = 'overall'
SELECT * FROM Inflation WHERE date = '2026-01-01' AND division = 'overall'





WITH CPI_Range AS (
    SELECT
        MIN(date) AS First_Date,
        MAX(date) AS Last_Date
    FROM Inflation
)
SELECT
    First_CPI.[index] AS First_CPI,
    Last_CPI.[index] AS Last_CPI,
    Last_CPI.[index] - First_CPI.[index] AS Cum_Change
FROM CPI_Range AS R
JOIN Inflation AS First_CPI
    ON First_CPI.date = R.First_Date
JOIN Inflation AS Last_CPI
    ON Last_CPI.date = R.Last_Date
WHERE First_CPI.division = 'overall'
  AND Last_CPI.division = 'overall';




