-- ==================== DASHBOARD 1 ====================

-- KPI Cards: Count of Sales, Sum of Profit, Sum of Quantity
SELECT 
    COUNT(*) as count_of_sales,
    SUM(Profit) as sum_of_profit,
    SUM(Quantity) as sum_of_quantity
FROM sales;

-- Sum of Sales by Segment (Pie Chart)
SELECT 
    Segment,
    SUM(Sales) as sum_of_sales
FROM sales 
GROUP BY Segment
ORDER BY SUM(Sales) DESC;

-- Count of Order ID, Sum of Profit and Average of Profit by Customer Name (Scatter Plot)
SELECT 
    Customer_Name,
    COUNT(DISTINCT Order_ID) as count_of_order_id,
    SUM(Profit) as sum_of_profit,
    AVG(Profit) as avg_of_profit
FROM sales 
GROUP BY Customer_Name;

-- Sum of Profit and Sum of Sales by Month (Bar Chart)
SELECT 
    MONTHNAME(Order_Date) as month_name,
    MONTH(Order_Date) as month_num,
    SUM(Profit) as sum_of_profit,
    SUM(Sales) as sum_of_sales
FROM sales 
GROUP BY MONTH(Order_Date), MONTHNAME(Order_Date)
ORDER BY month_num;

-- Sum of Sales, Sum of Profit and Count of Order ID by Region (Scatter Plot)
SELECT 
    Region,
    SUM(Sales) as sum_of_sales,
    SUM(Profit) as sum_of_profit,
    COUNT(DISTINCT Order_ID) as count_of_order_id
FROM sales 
GROUP BY Region;

-- ==================== DASHBOARD 2 ====================

-- Sum of Profit by State (Map Visualization)
SELECT 
    State,
    SUM(Profit) as sum_of_profit
FROM sales 
GROUP BY State
ORDER BY SUM(Profit) DESC;

-- Sum of Profit and Count of Returns by Region (Horizontal Bar Chart)
SELECT 
    Region,
    SUM(Profit) as sum_of_profit,
    COUNT(CASE WHEN Returns > 0 THEN 1 END) as count_of_returns
FROM sales 
GROUP BY Region
ORDER BY SUM(Profit) DESC;

-- Count of Order ID by Region and Payment Mode (Stacked Bar Chart)
SELECT 
    Region,
    Payment_Mode,
    COUNT(DISTINCT Order_ID) as count_of_order_id
FROM sales 
GROUP BY Region, Payment_Mode
ORDER BY Region, Payment_Mode;

-- Sum of Sales, Sum of Profit and Sum of Loss Amount by State (Line Chart)
SELECT 
    State,
    SUM(Sales) as sum_of_sales,
    SUM(Profit) as sum_of_profit,
    SUM(CASE WHEN Profit < 0 THEN ABS(Profit) ELSE 0 END) as sum_of_loss_amount
FROM sales 
GROUP BY State
ORDER BY State;

-- ==================== DASHBOARD 3 ====================

-- Sum of Profit and Sum of Quantity by Segment (Stacked Bar Chart)
SELECT 
    Segment,
    SUM(Profit) as sum_of_profit,
    SUM(Quantity) as sum_of_quantity
FROM sales 
GROUP BY Segment
ORDER BY SUM(Profit) DESC;

-- Sum of Loss Amount by Segment (Pie Chart)
SELECT 
    Segment,
    SUM(CASE WHEN Profit < 0 THEN ABS(Profit) ELSE 0 END) as sum_of_loss_amount
FROM sales 
WHERE Profit < 0
GROUP BY Segment;

-- Sum of Sales by Customer Name (Treemap)
SELECT 
    Customer_Name,
    SUM(Sales) as sum_of_sales
FROM sales 
GROUP BY Customer_Name
ORDER BY SUM(Sales) DESC
LIMIT 20; -- Top 20 for treemap visualization

-- Sum of Sales by Month and Segment (Area Chart)
SELECT 
    MONTHNAME(Order_Date) as month_name,
    MONTH(Order_Date) as month_num,
    Segment,
    SUM(Sales) as sum_of_sales
FROM sales 
GROUP BY MONTH(Order_Date), MONTHNAME(Order_Date), Segment
ORDER BY month_num, Segment;

-- ==================== DASHBOARD 4 ====================

-- Count of Category by Year and Sub-Category (Stacked Horizontal Bar Chart)
SELECT 
    YEAR(Order_Date) as year,
    Sub_Category,
    COUNT(*) as count_of_category
FROM sales 
GROUP BY YEAR(Order_Date), Sub_Category
ORDER BY year, Sub_Category;

-- Sum of Sales and Sum of Profit by Category (Line Chart)
SELECT 
    Category,
    SUM(Sales) as sum_of_sales,
    SUM(Profit) as sum_of_profit
FROM sales 
GROUP BY Category
ORDER BY Category;

-- Sum of Sales, Sum of Profit by Product Name (Line Chart with negative values)
SELECT 
    Product_Name,
    SUM(Sales) as sum_of_sales,
    SUM(Profit) as sum_of_profit
FROM sales 
GROUP BY Product_Name
ORDER BY SUM(Sales) DESC
LIMIT 25; -- Top 25 products for visualization

-- Count of Category by Sub-Category (Bar Chart)
SELECT 
    Sub_Category,
    COUNT(*) as count_of_category
FROM sales 
GROUP BY Sub_Category
ORDER BY COUNT(*) DESC;

-- ==================== DASHBOARD 5 ====================

-- Sum of Sales and Sum of Profit by Month (Radar Chart)
SELECT 
    MONTHNAME(Order_Date) as month_name,
    MONTH(Order_Date) as month_num,
    SUM(Sales) as sum_of_sales,
    SUM(Profit) as sum_of_profit
FROM sales 
GROUP BY MONTH(Order_Date), MONTHNAME(Order_Date)
ORDER BY month_num;

-- Sum of Sales by Month and Region (Area Chart)
SELECT 
    MONTHNAME(Order_Date) as month_name,
    MONTH(Order_Date) as month_num,
    Region,
    SUM(Sales) as sum_of_sales
FROM sales 
GROUP BY MONTH(Order_Date), MONTHNAME(Order_Date), Region
ORDER BY month_num, Region;

-- Detailed breakdown by Month and Region (Table format)
SELECT 
    MONTHNAME(Order_Date) as month,
    Region,
    SUM(Sales) as sum_of_sales
FROM sales 
GROUP BY MONTHNAME(Order_Date), MONTH(Order_Date), Region
ORDER BY MONTH(Order_Date), Region;

-- ==================== DASHBOARD 6 ====================

-- Count of Returns by Sub-Category (Horizontal Bar Chart)
SELECT 
    Sub_Category,
    COUNT(CASE WHEN Returns > 0 THEN 1 END) as count_of_returns
FROM sales 
GROUP BY Sub_Category
ORDER BY COUNT(CASE WHEN Returns > 0 THEN 1 END) DESC;

-- Sum of Profit and Sum of Loss Amount by Product Name (Treemap)
SELECT 
    Product_Name,
    SUM(CASE WHEN Profit > 0 THEN Profit ELSE 0 END) as sum_of_profit,
    SUM(CASE WHEN Profit < 0 THEN ABS(Profit) ELSE 0 END) as sum_of_loss_amount
FROM sales 
GROUP BY Product_Name
ORDER BY (SUM(CASE WHEN Profit > 0 THEN Profit ELSE 0 END) + SUM(CASE WHEN Profit < 0 THEN ABS(Profit) ELSE 0 END)) DESC
LIMIT 20;

-- Count of Returns by Region (Pie Chart)
SELECT 
    Region,
    COUNT(CASE WHEN Returns > 0 THEN 1 END) as count_of_returns
FROM sales 
GROUP BY Region
ORDER BY COUNT(CASE WHEN Returns > 0 THEN 1 END) DESC;

-- Sum of Loss Amount, Sum of Quantity and Sum of Loss Amount by Region and Segment (Scatter Plot)
SELECT 
    Region,
    Segment,
    SUM(CASE WHEN Profit < 0 THEN ABS(Profit) ELSE 0 END) as sum_of_loss_amount,
    SUM(Quantity) as sum_of_quantity
FROM sales 
GROUP BY Region, Segment;

-- ==================== ADDITIONAL UTILITY QUERIES ====================

-- Date range filter helper (for all dashboards)
SELECT 
    MIN(Order_Date) as min_date,
    MAX(Order_Date) as max_date
FROM sales;

-- Summary statistics for validation
SELECT 
    COUNT(DISTINCT Order_ID) as total_orders,
    COUNT(DISTINCT Customer_ID) as total_customers,
    COUNT(DISTINCT Product_ID) as total_products,
    SUM(Sales) as total_sales,
    SUM(Profit) as total_profit,
    SUM(Quantity) as total_quantity
FROM sales;