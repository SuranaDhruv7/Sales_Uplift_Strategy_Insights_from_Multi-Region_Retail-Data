-- 1. 📊 Total sales amount per region for the last quarter.

SELECT Region, 
SUM(TotalAmount) AS TotalSales
FROM RetailTransactions
WHERE Date >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
GROUP BY Region;

-- 2. 📦 Top 5 best-selling products (by revenue).

SELECT ProductName, 
       SUM(TotalAmount) AS TotalRevenue
FROM RetailTransactions
GROUP BY ProductName
ORDER BY TotalRevenue DESC
LIMIT 5;

-- 3. 🛍 Monthly sales trend across all regions.

SELECT DATE_FORMAT(Date, '%Y-%m') AS Month,
       SUM(TotalAmount) AS MonthlySales
FROM RetailTransactions
GROUP BY Month
ORDER BY Month;

-- 4. 🏆 Region-wise contribution to total sales (as a %).

SELECT Region, 
ROUND(SUM(TotalAmount) * 100 / (SELECT SUM(TotalAmount) FROM RetailTransactions), 2) 
AS PercentageContribution
FROM RetailTransactions
GROUP BY Region
ORDER BY PercentageContribution DESC;

-- 5. 🔁 Compare Online vs Offline sales across all months.

SELECT DATE_FORMAT(Date, '%Y-%m') AS Month,
       SalesChannel,
       SUM(TotalAmount) AS ChannelSales
FROM RetailTransactions
GROUP BY Month, SalesChannel
ORDER BY Month, SalesChannel;

-- 6. 📈 Sales trend by Category – Which categories are rising/falling?

SELECT DATE_FORMAT(Date, '%Y-%m') AS Month,
       Category,
       SUM(TotalAmount) AS CategorySales
FROM RetailTransactions
GROUP BY Month, Category
ORDER BY Month, Category;

-- 7. 🎯 List customers who purchased more than 10 times.

SELECT CustomerID,
       COUNT(*) AS NumberOfPurchases
FROM RetailTransactions
GROUP BY CustomerID
HAVING COUNT(*) > 10
ORDER BY NumberOfPurchases DESC;