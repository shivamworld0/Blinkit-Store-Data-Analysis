-- Distinct item types
SELECT DISTINCT `Item Type` FROM stores;

-- Store count by outlet type
SELECT `Outlet Type`, COUNT(DISTINCT `Outlet Identifier`) AS Store_count FROM stores GROUP BY `Outlet Type`;

-- Average sales per item
SELECT `Item Identifier`, ROUND(AVG(sales), 2) AS avg_sales FROM stores GROUP BY `Item Identifier` LIMIT 10;

-- Top 5 items with highest sales
SELECT `Item Type`, ROUND(SUM(sales),2) AS Total_sales FROM stores GROUP BY `Item Type` ORDER BY Total_sales DESC LIMIT 5;

-- Average item weight by item type
SELECT `Item Type`, ROUND(AVG(`Item Weight`), 2) AS avg_weight FROM stores GROUP BY `Item Type`;

-- Outlet with highest total sales
SELECT `Outlet Identifier`, ROUND(SUM(Sales),2) AS Total_sales FROM stores GROUP BY `Outlet Identifier` ORDER BY Total_sales DESC LIMIT 1;

-- Total sales by item fat content
SELECT `Iteam Fat Content`, ROUND(SUM(sales), 2) AS total_sales FROM stores GROUP BY `Iteam Fat Content`;

-- Outlet size with highest average rating
SELECT `Outlet Size`, ROUND(AVG(Rating), 2) AS AVG_Rating FROM stores GROUP BY `Outlet Size` ORDER BY AVG_Rating DESC LIMIT 1;

-- Outlet establishment trend
SELECT `Outlet Establishment Year`, COUNT(DISTINCT `Outlet Establishment Year`) AS Outlet_Count FROM stores GROUP BY `Outlet Establishment Year` ORDER BY `Outlet Establishment Year`;

-- Correlation between item visibility and sales
SELECT 
  CASE
    WHEN `Item Visibility` < 0.05 THEN 'Low Visibility'
    WHEN `Item Visibility` < 0.15 THEN 'Mid Visibility'
    ELSE 'High Visibility'
  END AS Visibility_group,
  ROUND(AVG(Sales), 2) AS Avg_sales
FROM stores
GROUP BY Visibility_group;

-- Sales performance across outlet location types
SELECT `Outlet Location Type`, ROUND(AVG(Sales), 2) AS Avg_Sales FROM stores GROUP BY `Outlet Location Type` ORDER BY Avg_Sales DESC;

-- Top-performing item type in each outlet
SELECT t.`Outlet Identifier`, t.`Item Type`, t.Total_Sales
FROM (
  SELECT `Outlet Identifier`, `Item Type`, SUM(Sales) AS Total_Sales,
         RANK() OVER (PARTITION BY `Outlet Identifier` ORDER BY SUM(Sales) DESC) AS rnk
  FROM stores
  GROUP BY `Outlet Identifier`, `Item Type`
) t
WHERE t.rnk = 1;
