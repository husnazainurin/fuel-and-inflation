-- Create database, ensuring that no database is named FuelPrice and Inflation
IF OBJECT_ID('FuelPrice', 'U') IS NOT NULL
    DROP TABLE FuelPrice;

IF OBJECT_ID('Inflation', 'U') IS NOT NULL
    DROP TABLE Inflation;

CREATE DATABASE FuelInflationDB
USE FuelInflationDB


-- Create FuelPrice table
CREATE TABLE FuelPrice (
	series_type VARCHAR(20) NOT NULL,
	[date] DATE NOT NULL,
	ron95 DECIMAL(10, 2),
	ron97 DECIMAL(10, 2),
	diesel DECIMAL(10, 2),
	diesel_eastmsia DECIMAL(10,2),
	ron95_budi95 DECIMAL(10,2),
	ron95_skps DECIMAL(10,2),
	diesel_skds DECIMAL(10,2),
	diesel_budi DECIMAL(10,2)


	PRIMARY KEY ([date], series_type)
);

-- Create Inflation table
CREATE TABLE Inflation (
	[date] DATE NOT NULL,
	division VARCHAR (20) NOT NULL,
	[index] DECIMAL(10, 2) NOT NULL,

	PRIMARY KEY ([date], division)
)

-- Load dataset into the tables
--FuelPrice Table
BULK INSERT FuelPrice
FROM N'C:\Users\User\Documents\projects\fuel-and-inflation\data\fuelprice.csv'
WITH
(
    DATAFILETYPE = 'char',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);

--Inflation Table
BULK INSERT Inflation
FROM N'C:\Users\User\Documents\projects\fuel-and-inflation\data\cpi_2d_lowincome.csv'
WITH
(
    DATAFILETYPE = 'char',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);

-- View the tables
SELECT *
FROM FuelPrice

SELECT *
FROM Inflation