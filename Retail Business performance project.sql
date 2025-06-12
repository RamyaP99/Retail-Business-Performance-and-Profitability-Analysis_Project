-- 1. Create a database and table:
CREATE DATABASE retail_analysis;
USE retail_analysis;

CREATE TABLE retail_transactions (
    TransactionID VARCHAR(20),
    Date DATE,
    CustomerID VARCHAR(20),
    Gender VARCHAR(10),
    Age INT,
    ProductCategory VARCHAR(100),
    Quantity INT,
    PricePerUnit FLOAT,
    TotalAmount FLOAT
);
-- drop table retail_transactions;

-- 2. Import Data
LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/retail_sales_dataset.csv"
INTO TABLE retail_transactions
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- 3. Clean Missing/Null Records:
-- Check for missing values
SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE WHEN TransactionID IS NULL THEN 1 ELSE 0 END) AS null_transaction,
    SUM(CASE WHEN CustomerID IS NULL THEN 1 ELSE 0 END) AS null_customer,
    SUM(CASE WHEN ProductCategory IS NULL THEN 1 ELSE 0 END) AS null_category,
    SUM(CASE WHEN TotalAmount IS NULL THEN 1 ELSE 0 END) AS null_amount
FROM retail_transactions;

-- Remove rows with critical missing values:
DELETE FROM retail_transactions
WHERE TransactionID IS NULL OR Date IS NULL OR CustomerID IS NULL;

SET SQL_SAFE_UPDATES = 0;

-- 4. Handle Anomalies:
SELECT * 
FROM retail_transactions 
WHERE ABS(TotalAmount - (Quantity * PricePerUnit)) > 0.01;

-- Remove or correct anomalies:
UPDATE retail_transactions 
SET TotalAmount = Quantity * PricePerUnit 
WHERE ABS(TotalAmount - (Quantity * PricePerUnit)) > 0.01;

-- Remove negative or zero quantities/prices:
DELETE FROM retail_transactions 
WHERE Quantity <= 0 OR PricePerUnit <= 0 OR TotalAmount <= 0;

-- Add Derived Columns:
ALTER TABLE retail_transactions
ADD Profit DECIMAL(10, 2);

UPDATE retail_transactions
SET Profit = TotalAmount * 0.4; -- 40% profit margin

-- 5. Calculate Profit Margins by Category
SELECT 
    ProductCategory,
    SUM(TotalAmount) AS TotalRevenue,
    SUM(Profit) AS TotalProfit,
    round((SUM(Profit) / SUM(TotalAmount)) * 100) AS ProfitMargin
FROM retail_transactions
GROUP BY ProductCategory
ORDER BY ProfitMargin ASC;


-- Customer Segment Analysis:

-- Analyze profitability by Gender and Age groups:
SELECT 
    Gender,
    CASE 
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age BETWEEN 25 AND 40 THEN '25-40'
        WHEN Age BETWEEN 41 AND 60 THEN '41-60'
        ELSE 'Over 60'
    END AS AgeGroup,
    ProductCategory,
    SUM(Profit) AS TotalProfit,
    SUM(TotalAmount) AS TotalRevenue,
    (SUM(Profit) / SUM(TotalAmount)) * 100 AS ProfitMargin
FROM retail_transactions
GROUP BY Gender, AgeGroup, ProductCategory
ORDER BY ProfitMargin ASC;
-- Purpose: Discover which age groups contribute the most revenue.

--  Revenue and Quantity by Month (Seasonal Trend)
SELECT 
    DATE_FORMAT(Date, '%Y-%m') AS Month,
    SUM(Quantity) AS TotalUnitsSold,
    ROUND(SUM(TotalAmount), 2) AS TotalRevenue
FROM retail_transactions
GROUP BY Month
ORDER BY Month;
-- Purpose: Detect sales seasonality or promotional impacts.

-- Average Revenue per Customer
SELECT 
    CustomerID,
    COUNT(*) AS NumTransactions,
    SUM(TotalAmount) AS TotalSpent,
    ROUND(AVG(TotalAmount), 2) AS AvgSpendPerTransaction
FROM retail_transactions
GROUP BY CustomerID
ORDER BY TotalSpent DESC
LIMIT 10;
-- Purpose: Recognize top spending customers and loyalty potential.

-- Daily Revenue Trend (Granular)
SELECT 
    Date,
    ROUND(SUM(TotalAmount), 2) AS DailyRevenue
FROM retail_transactions
GROUP BY Date
ORDER BY Date;
-- 

-- Identifying Slow-Moving Categories
SELECT 
    ProductCategory,
    COUNT(DISTINCT Date) AS DaysSold,
    SUM(Quantity) AS TotalUnitsSold,
    ROUND(SUM(Quantity) / COUNT(DISTINCT Date), 2) AS AvgDailyUnits
FROM retail_transactions
GROUP BY ProductCategory
ORDER BY AvgDailyUnits ASC;
-- Purpose: Spot categories with low daily movement (slow movers).

SET SQL_SAFE_UPDATES = 1;
