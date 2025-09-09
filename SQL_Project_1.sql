-- Database Setup
CREATE DATABASE retail_sales_database;
CREATE TABLE retail_sale_analysis
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
-- Data Exploration & Cleaning
SELECT * FROM retail_sale_analysis;
SELECT COUNT(*) FROM retail_sale_analysis;
SELECT COUNT(DISTINCT customer_id) FROM retail_sale_analysis;
SELECT DISTINCT category FROM retail_sale_analysis;

SELECT * FROM retail_sale_analysis
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

-- DATA ANALYSIS AND FINDINGS
-- 1. Write a SQL query to retrieve all columns for sales made on '2022-11-05:
SELECT * FROM retail_sale_analysis
WHERE sale_date = '2022-11-05';

-- 2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and 
-- the quantity sold is more than 4 in the month of Nov-2022:
SELECT * FROM retail_sale_analysis
WHERE category = 'Clothing' 
AND quantity >= 4 
AND sale_date BETWEEN '2022-10-01' AND '2022-10-31'

-- 3. Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT SUM(total_sale), category from retail_sale_analysis
GROUP BY category
ORDER BY category

-- 4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT round(AVG(age), 2)FROM retail_sale_analysis
WHERE category = 'Beauty'

-- 5. Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * FROM retail_sale_analysis
WHERE total_sale > 1000

-- 6. Write a SQL query to find the total number of transactions (transaction_id) 
-- made by each gender in each category.

SELECT count(transactions_id), gender, category FROM retail_sale_analysis
GROUP BY gender, category
order by category

-- 7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT Year, Month, ROUND(AVG(total_sale)::numeric, 2) as average_sales
FROM
	(select *,
	extract(year from sale_date)as Year,
	extract(month from sale_date)as Month
	from retail_sale_analysis)
GROUP BY Month, Year
ORDER BY AVG(total_sale) DESC
LIMIT 2

-- 8.Write a SQL query to find the top 5 customers based on the highest total sales
SELECT customer_id, SUM(total_sale) AS total_sales FROM retail_sale_analysis
GROUP BY customer_id 
ORDER BY SUM(total_sale) DESC
limit 5

-- 9. Write a SQL query to find the number of unique customers who purchased items from each category.:
SELECT COUNT(DISTINCT customer_id), category FROM retail_sale_analysis
GROUP BY category

-- 10. Write a SQL query to create each shift 
-- and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
select shift, count(*) as total_orders
from
	(select *,
	case 
	when extract(hour from sale_time) < 12 then 'Morning'
	when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
	else 'Evening'
	end as shift
	from retail_sale_analysis)
group by shift

-- END















	