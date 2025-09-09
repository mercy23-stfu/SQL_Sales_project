# Retail Sales Analysis SQL Project

## Project Overview

**Role**: Data Analyst

**Project Title**: Retail Sales Analysis 

**Database**: `retail_sale_database`

This project demonstrates my ability to apply core SQL techniques to clean, explore, and analyze real-world retail sales data. I created and managed a relational database in PostgreSQL, conducted exploratory data analysis (EDA), and answered business-focused questions using efficient and well-structured SQL queries.

## Objectives

1. Create and populate a retail sales database with the provided sales data to simulate a real-world business environment.
2. Identify and remove any records with missing or null values for data quality and completeness.
3. Perform basic exploratory data analysis to understand the dataset structure, trends and patterns.
4. Utilize SQL to answer specific business questions and derive insights from the sales data such as high-performing sales periods, product category performance etc.

## Dataset
The dataset contains retail transactions with the following key attributes:
**transactions_id INT PRIMARY KEY,
sale_date DATE,	
sale_time TIME,
customer_id INT,	
gender VARCHAR(10),
age INT,
category VARCHAR(35),
quantity INT,
price_per_unit FLOAT,	
cogs FLOAT,
total_sale FLOAT**

## Tools and Techniques
**Database:** PostgreSQL  
**Query Language:** SQL  
**Environment:** pgAdmin

## Project Structure

### 1. Database Setup

- **Database Creation**: The project started by creating a database named `retail_sales_database`.
- **Table Creation**: A table named `retail_sale_analysis` was created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
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
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_sale_analysis;
SELECT COUNT(DISTINCT customer_id) FROM retail_sale_analysis;
SELECT DISTINCT category FROM retail_sale_analysis;

SELECT * FROM retail_sales_database
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales_database
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **To retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT * FROM retail_sale_analysis
WHERE sale_date = '2022-11-05';
```

2. **To retrieve all transactions where the category is 'Clothing' and the quantity sold is equal to or more than 4 in the month of Nov-2022**:
```sql
SELECT * FROM retail_sale_analysis
WHERE category = 'Clothing' 
AND quantity >= 4 
AND sale_date BETWEEN '2022-10-01' AND '2022-10-31';
```

3. **To calculate the total sales (total_sale) for each category.**:
```sql
SELECT SUM(total_sale), category from retail_sale_analysis
GROUP BY category
ORDER BY category;
```

4. **To find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT round(AVG(age), 2)FROM retail_sale_analysis
WHERE category = 'Beauty';
```

5. **To find all transactions where the total_sale is greater than 1000.**:
```SELECT * FROM retail_sale_analysis
WHERE total_sale > 1000;
```

6. **To find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT count(transactions_id), gender, category FROM retail_sale_analysis
GROUP BY gender, category
order by category;
```

7. **To calculate the average sale for each month. Find out best selling month in each year**:
```sql
SELECT Year, Month, ROUND(AVG(total_sale)::numeric, 2) as average_sales
FROM
	(select *,
	extract(year from sale_date)as Year,
	extract(month from sale_date)as Month
	from retail_sale_analysis)
GROUP BY Month, Year
ORDER BY AVG(total_sale) DESC
LIMIT 2;
```

8. **To find the top 5 customers based on the highest total sales **:
```sql
SELECT customer_id, SUM(total_sale) AS total_sales FROM retail_sale_analysis
GROUP BY customer_id 
ORDER BY SUM(total_sale) DESC
limit 5;
```

9. **To find the number of unique customers who purchased items from each category.**:
```sql
SELECT COUNT(DISTINCT customer_id), category FROM retail_sale_analysis
GROUP BY category;
```

10. **To create shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
select shift, count(*) as total_orders
from
	(select *,
	case 
	when extract(hour from sale_time) < 12 then 'Morning'
	when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
	else 'Evening'
	end as shift
	from retail_sale_analysis)
group by shift;
```

## Key Findings
1. *Based on average total_sale, July, 2022 ranked first in the top two months.*
2. *The Electronic category had the highest volume of items sold.*
3. *The highest transaction count was in the clothing category from mean while the lowest was in the beauty category from men.*
4. *Generally, the female gender contributed more to the retail sale transaction*
5. *The clothing category had more transactions compared to the rest.*

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## Author - Mercy Aremu

**This project was an opportunity for me to apply and strengthen my SQL skills in a real-world business context. By setting up a retail sales database and working through each step of the data analysis process, from cleaning and exploring the data to writing queries.
The analysis uncovered valuable insights into sales performance, customer purchasing behavior, and seasonal trends.
Overall, this project showcases my ability to work with relational databases (PostgreSQL), write efficient and accurate SQL queriesand translate raw data into meaningful insights.**

## You can reach me via:**
-**Email Address**: (mercyaremu3@gmail.com)
  
I look forward to connecting with you!


