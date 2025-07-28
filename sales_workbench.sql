create database store;
use store;

#--------------------DASHBOARD 1----------------------------------------------------------------------------------------

#card valus for sales,profit and quantity:
SELECT 
count(sales) as count_of_sales,
sum(profit) as sum_of_profit,
sum(quantity) as sum_of_quantity
from sales;

#sum of sales by segments

SELECT segment,sum(sales) from sales
group by segment;

#sum of profit by category and region

SELECT category , region,sum(profit)
from sales group by category,region
order by sum(profit) desc;

#Sum of profit by customer_name with filtering till top 10:

SELECT customer_name,sum(profit) from sales
group by customer_name order by sum(profit)
desc limit 10;


#Sum of Sales and Sum of Profit by Order Date
SELECT Order_Date ,sum(profit) ,sum(sales)
from sales group by Order_date;

#--------------------DASHBOARD 2----------------------------------------------------------------------------------------

#Sum of Profit by State
SELECT state, sum(profit) from sales
group by state order by sum(profit) ;

#Sum of Profit and Count of Returns by Region
SELECT region , sum(profit) ,count(region) from sales
group by region order by sum(profit) desc;

#sum of sales and profits in different category as per different regions:
SELECT sum(sales) ,sum(profit) ,category ,region 
from sales
group by category , region order by 
sum(sales) desc;

#display state ,sum of sales  sum of profit , returns ,sum of profit margin and sum of quantity as per state:
SELECT state ,sum(sales) ,sum(profit),count(returns),round(sum(profit)/sum(sales),2) as profit_margin,sum(quantity) 
from sales group by state;

#Sum of Profit and Sum of Quantity by Segment
SELECT segment,sum(profit) ,sum(quantity) from sales 
group by segment;

#Sum of Sales by Customer Name


#--------------------Extra queries-------------------------

#What is the total sales, total profit, and total quantity sold?
SELECT SUM(Sales) AS Total_Sales ,SUM(Profit) AS Total_Profit ,SUM(Quantity) AS Total_Quantity from sales;




#What are the total sales and profit by year and month?
SELECT YEAR(Order_Date) as Year, MONTH(Order_Date) as Month ,
		SUM(Sales) as Monthly_Sales ,SUM(Profit) as Monthly_Profit 
        from sales group by YEAR(Order_Date), MONTH(Order_Date) 
        order by Year ,Month;


#What is the total sales by each segment?
SELECT segment,SUM(sales),COUNT(sales) from sales group by segment;


#Who are the top 10 most profitable customers?
SELECT Customer_Name ,SUM(Profit) as total_profit from sales 
		group by Customer_name order by total_profit desc limit 10;


#What are sales, profit, and return counts by region?
SELECT Region,SUM(Sales),SUM(Profit),Count(Returns) from Sales group by region ;


#State-wise Profit and Sales
SELECT State ,SUM(Profit) ,SUM(Sales) from sales group by State;


#What is the performance of each Category and Sub-Category?
SELECT Category,Sub_Category ,SUM(Profit),SUM(Sales) from sales group by Category,Sub_Category ;


#What is the return rate for each customer?

SELECT Customer_name ,COUNT(Returns) as return_count, COUNT(DISTINCT(Order_Id)) as total_order , 
ROUND(COUNT(Returns)/COUNT(DISTINCT(Order_Id)) ,2)  as return_rate
from sales group by Customer_name;

#What is the average shipping Date per order?
SELECT Order_ID ,AVG(Ship_Date) from sales group by Order_ID;

#Which sub-categories have the most returns?
SELECT Sub_Category , COUNT(returns) as return_count from sales group by Sub_Category
order by  COUNT(DISTINCT(returns)) desc limit 10;

#Calculate profit margin by product.

SELECT Product_Name ,SUM(Profit),SUM(sales) ,
ROUND(SUM(Profit)/SUM(sales),2) as Profit_Margin 
from sales group by Product_Name ;

#Sales and profit for orders placed between 1,Jan-2019 and 6,jan-2019.

SELECT Order_ID, Order_Date, Sales, Profit from sales
WHERE Order_Date BETWEEN '01-01-2019' AND '06-01-2019';

# Find all orders where profit was above 100$.
SELECT Order_id ,Profit from sales where Profit>100 order by profit desc;


#Compare total sales and profit for returned vs non-returned orders.

SELECT 
	CASE 
		WHEN Returns is NULL THEN 'Not Returned'
        ELSE 'Returned'
        END as return_status,
	SUM(Sales) , SUM(profit) from sales 
group by return_status;


#Join sales and payment_info        
        
SELECT s.Order_ID ,s.Sales , p.Payment_Type ,p.Payment_Status
from sales s 
join Payment_info p ON s.Order_ID=p.Order_ID;

#Join sales with employees by region
SELECT e.Employee_Name ,s.Region from Employees e
join sales s ON e.Region=s.Region group by e.Employee_Name ,S.Region;


#Find customers who used PayPal and had returns.

SELECT distinct s.Customer_ID from sales s join 
payment_info p on s.Order_ID=p.Order_ID
where p.Payment_Type='PayPal' and s.Returns>0;


#Profit margin per category.
SELECT category, sum(profit)/nullif(sum(sales),0) as profit_margin
from sales group by Category;


#Products with the highest return rate.
SELECT Product_ID,COUNT(*) AS total_orders,sum(returns) as tota_returns,
round(sum(returns)/count(*),2) as return_rate from sales
group by Product_ID order by return_rate desc limit 10;

#Find customers with more than 3 orders and total sales over 5000
SELECT Customer_ID, COUNT(Order_ID) as total_order ,count(sales) as total_sales
from sales group by Customer_ID having total_order>3 and total_sales>5000;

#Subquery: Get states with profit higher than the average state profit.

WITH stateProfit AS (
	select state , sum(profit) as total_profit
    from sales group by state
),
AvgProfit AS (
	select avg(total_profit) as avg_profit
    from stateProfit
)
SELECT sp.state ,sp.total_profit
from stateProfit sp , AvgProfit ap 
where sp.total_Profit > ap.Avg_Profit;

#Left join to get orders with or without payment info
SELECT s.Order_ID , p.Payment_status from sales s left join 
Payment_info p on s.Order_ID = p.Order_id;

#Orders that have no payment record (NULL check)
SELECT s.Order_ID from sales s left join 
Payment_info p on s.Order_ID = p.Order_ID where p.payment_status is NULL;

#Region-wise total profit managed by each employee
SELECT SUM(s.profit) ,s.region ,e.employee_Name 
from employees e join sales s on e.region = s.region 
group by e.employee_Name,s.region;

#Find orders with 'Failed' payment
SELECT s.Order_ID ,p.Payment_status from sales s 
join Payment_info p on s.Order_ID = p.Order_ID
where p.payment_status ='FAILED';

#return count per employee
SELECT count(s.returns) , e.employee_Name from sales s
join employees e on  e.employee_ID = s.Customer_ID
where s.returns > 0 group by e.employee_Name;

#Join on multiple keys: sales with payment_info and employees
SELECT s.Order_ID ,e.Employee_Name ,p.Payment_Type
from sales s 
join employees e on e.employee_ID=s.Customer_ID
join payment_Info p on s.order_ID=p.Order_ID;

#Self-join to find multiple orders by same customer
SELECT s1.Customer_ID , s1.Order_ID as order1 ,
s2.Order_ID as order2 from sales s1 
join sales s2 on s1.Customer_ID=s2.Customer_ID
and s1.Order_ID=s2.Order_ID;

#Orders where sales are above the average
SELECT * from sales where sales >
(select avg(sales) from sales);

#Top 3 profitable regions
SELECT Region,sum(profit) as total_profit
from sales group by region order by total_profit 
desc limit 3;

#Find most used payment method
SELECT payment_Type from payment_info 
group by payment_type order by count(Payment_type)
desc limit 1;

#Customers with more than 5 orders
SELECT Customer_ID ,count(Order_ID) from sales group by 
Customer_ID order by count(Order_ID) >5;

#Find all returns in top-selling state

SELECT * from sales where state=(
	select state from sales 
    group by state
    order by sum(sales) desc 
    limit 1
);

#Customer with highest total sales
SELECT Customer_ID from sales 
group by Customer_ID
order by sum(sales) desc limit 1;

#Recent 5 orders with payment status
SELECT s.order_ID ,s.Order_date ,p.Payment_status
from sales s 
join payment_info p on s.Order_ID=p.Order_ID 
Order by s.Order_date desc limit 5;
 
#Longest shipping delay
SELECT * ,DATEDIFF(Ship_Date, Order_Date) as Delay
from sales
order by Delay desc limit 1;

 
