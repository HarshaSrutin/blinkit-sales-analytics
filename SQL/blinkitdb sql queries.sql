CREATE DATABASE blinkitdb;
CREATE TABLE blinkit_data (
    item_fat_content VARCHAR(50),
    item_identifier VARCHAR(20),
    item_type VARCHAR(100),
    outlet_establishment_year INT,
    outlet_identifier VARCHAR(20),
    outlet_location_type VARCHAR(50),
    outlet_size VARCHAR(30),
    outlet_type VARCHAR(100),
    item_visibility DECIMAL(10,6),
    item_weight DECIMAL(10,2),
    sales DECIMAL(12,4),
    rating DECIMAL(3,2)
);
USE blinkitdb;
-- 1. View the Blinkit dataset
SELECT * FROM blinkit_data;

UPDATE blinkit_data
SET item_fat_content =
    CASE
        WHEN item_fat_content IN ('LF', 'low fat') THEN 'Low Fat'
        WHEN item_fat_content = 'reg' THEN 'Regular'
        ELSE item_fat_content
    END;

-- 2. Total Sales
SELECT SUM(SALES) AS total_sales
FROM blinkit_data;

-- 3. Average Sales
SELECT CAST(AVG(SALES) AS DECIMAL(10,2)) AS average_sales
FROM blinkit_data;

-- 4. Number of Items 
SELECT COUNT(*) AS number_of_items
FROM blinkit_data;

-- 5. Average Rating
SELECT CAST(AVG(rating) AS DECIMAL(10,2)) AS average_rating
FROM blinkit_data;

SET SQL_SAFE_UPDATES = 1;


    
    SELECT DISTINCT item_fat_content FROM blinkit_data;
    
    -- A1. Total Sales (millions)
SELECT  
      CAST(SUM(sales) / 1000000.0 AS DECIMAL(10,2)) AS Total_Sales_Million
      FROM blinkit_data;
      
	-- A2. Average Sales
SELECT
    CAST(AVG(sales) AS SIGNED) AS Avg_Sales
FROM blinkit_data;

-- B. Total Sales by Fat Content
SELECT
    item_fat_content,
    CAST(SUM(sales) AS DECIMAL(10,2)) AS Total_Sales
FROM blinkit_data
GROUP BY item_fat_content;

-- C. Total Sales by Item Type
SELECT
    item_type,
    CAST(SUM(sales) AS DECIMAL(10,2)) AS Total_Sales
FROM blinkit_data
GROUP BY item_type
ORDER BY Total_Sales DESC;

-- D.Fat Content by Outlet Location for Total Sales
SELECT
    outlet_location_type,
    SUM(IF(item_fat_content = 'Low Fat', sales, 0)) AS Low_Fat,
    SUM(IF(item_fat_content = 'Regular', sales, 0)) AS Regular
FROM blinkit_data
GROUP BY outlet_location_type
ORDER BY outlet_location_type;

-- E. Total Sales by Outlet Establishment Year
SELECT
    outlet_establishment_year,
    CAST(SUM(sales) AS DECIMAL(10,2)) AS Total_Sales
FROM blinkit_data
GROUP BY outlet_establishment_year
ORDER BY outlet_establishment_year DESC;

-- F. Percentage of Sales by Outlet Size
SELECT
    outlet_size,
    SUM(sales) AS Total_Sales,
    CAST(SUM(sales) * 100.0 / (SELECT SUM(sales) FROM blinkit_data) AS DECIMAL(10,2)) AS Sales_Percentage
FROM blinkit_data
GROUP BY outlet_size
ORDER BY Total_Sales DESC;

-- G. Sales by Outlet Location
SELECT
    outlet_location_type,
    CAST(SUM(sales) AS DECIMAL(10,2)) AS Total_Sales
FROM blinkit_data
GROUP BY outlet_location_type
ORDER BY Total_Sales DESC;

-- H. All Metrics by Outlet Type
SELECT
    outlet_type,
    CAST(SUM(sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST(AVG(sales) AS DECIMAL(10,0)) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    CAST((SUM(SALES)*100/(SELECT SUM(SALES) FROM BLINKIT_DATA)) AS DECIMAL (10,2)) AS Total_percentage_Sales,
    CAST(AVG(rating) AS DECIMAL(10,2)) AS Avg_Rating,
    CAST(AVG(item_visibility) AS DECIMAL(10,2)) AS Item_Visibility
FROM blinkit_data
GROUP BY outlet_type
ORDER BY Total_Sales DESC;

-- I. All Metrics by Outlet Location type

SELECT
    outlet_location_type,
    CAST(SUM(sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST(AVG(sales) AS DECIMAL(10,0)) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    CAST((SUM(SALES)*100/(SELECT SUM(SALES) FROM BLINKIT_DATA)) AS DECIMAL (10,2)) AS Total_percentage_Sales,
    CAST(AVG(rating) AS DECIMAL(10,2)) AS Avg_Rating,
    CAST(AVG(item_visibility) AS DECIMAL(10,2)) AS Item_Visibility
FROM blinkit_data
GROUP BY outlet_location_type
ORDER BY Total_Sales DESC;


CREATE USER 'powerbi'@'localhost' IDENTIFIED BY 'Powerstar@369';

GRANT SELECT ON blinkitdb.* TO 'powerbi'@'localhost';



