-- explore all countries our customers como from.

select distinct category , count( distinct subcategory) from gold.dim_products group by category order by 2 desc

select 
	min(order_date) as first_order_date,
	max(order_date) as last_order_date,
	DATEDIFF(year,min(order_date), max(order_date)) as order_range_years
from gold.fact_sales


-- find the total number of customers that has placed an order

select 
	count(distinct customer_key) as total_customers

from gold.fact_sales

-- MEASURES
select 'Total Sales' as measure_name,sum(sales_amount) as measure_value from gold.fact_sales
union all
select 'Total Quantity' as measure_name,sum(quantity) as measure_value from gold.fact_sales
union all
select 'Average `Price' as measure_name, avg(sales_amount) as average_sales_price from gold.fact_sales
union all
select 'Total Orders' as measure_name, count( distinct order_number) as total_orders from gold.fact_sales
union all
select 'Total Products' as measure_name, count(product_key) as total_products from gold.dim_products
union all
select 'Total Customers' as measure_name, count(customer_key) as total_customers from gold.dim_customers


-- Find total customers by countries

select 
	country, 
	count(customer_key)  as total_customers
from gold.dim_customers
group by country
order by total_customers desc

-- find total customers by gender
select
	gender,
	count(customer_key) as total_customers
from gold.dim_customers
group by gender
order by total_customers desc

-- find total products by category
select 
	category,
	count( product_key) as total_products
from gold.dim_products
group by category
order by total_products desc

-- what is the average costs in each category?

select 
	category,
	avg(cost) as avg_cost
from gold.dim_products
group by category
order by avg_cost desc

-- what is the total revenue generated for each categor

select 
	ds.category,
	sum(fs.sales_amount) as total_revenue
from gold.fact_sales as fs
left join gold.dim_products as ds
on ds.product_key = fs.product_key
group by category
order by total_revenue desc

-- what is the total revenue by each customer
select 
	dc.customer_number,
	dc.first_name,
	dc.lastname,
	sum(fs.sales_amount) as total_revenue
from gold.fact_sales as fs
left join gold.dim_customers as dc
on fs.customer_key = dc.customer_key
group by dc.customer_number, dc.first_name, dc.lastname
order by total_revenue desc