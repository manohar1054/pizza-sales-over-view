select * from pizza_sales  
---total rvenue----
select sum(total_price) as total_revenue from pizza_sales;
----average order value ------
select(sum(total_price)/count(distinct order_id)) as avg_order_value 
from pizza_sales
---total pizzas sold----
select sum(quantity) as total_pizza_sold from pizza_sales
---average pizzas per order-----
select cast(cast(sum(quantity) as decimal (10,2))/
cast (count(distinct order_id) as decimal(10,2)) as decimal(10,2))
as avg_pizzas_per_order
from pizza_sales
----total orders----

select count (distinct order_id)as total_orders from pizza_sales
----Daily trend for total orders-----
select datename (dw,order_date) as order_day, count (distinct order_id) as
total_orders
from pizza_sales
group by datename (dw,order_date)
---monthly trend for orders----
select datename (month,order_date) as month_name, count(distinct order_id)
as total_orders
from pizza_sales
group by datename (month,order_date)
---percentage of sales by pizza category-----
select pizza_category, cast(sum(total_price) as decimal(10,2)) as
total_revenue,
cast(sum(total_price)* 100/(select sum (total_price)from pizza_sales)
as decimal (10,2)) as pct
from pizza_sales
group by pizza_category
------percentage sales by pizza size-----
select pizza_size, cast(sum(total_price)
as decimal(10,2)) as total_revenue,
cast(sum(total_price)*100/ (select sum(total_price)from pizza_sales)
as decimal(10,2)) as pct
from pizza_sales
group by pizza_size
order by pizza_size
----total pizzas sold by pizza category------
select pizza_category, sum (quantity) as total_quantity_sold
from pizza_sales
where month(order_date)=2
group by pizza_category 
order by total_quantity_sold desc
----top 5 pizzas by revenue----
select top 5 pizza_name, sum (total_price) as total_revenue
from pizza_sales
group by pizza_name
order by total_revenue desc
-----top 5 pizzas by revenue-----
select top 5 pizza_name, sum (total_price) as total_revenue
from pizza_sales
group by pizza_name
order by total_revenue desc
------bottom 5 pizzas by revenue-----
select top 5 pizza_name, sum (total_price) as total_revenue
from pizza_sales 
group by pizza_name
order by total_revenue asc
---top 5 pizzas by quantity-----
select top 5 pizza_name, sum (quantity) as total_pizza_sold
from pizza_sales
group by pizza_name
order by total_pizza_sold desc
-----bottom 5 pizzas by quantity-----
select top 5 pizza_name, sum (quantity) as total_pizza_sold
from pizza_sales 
group by pizza_name
order by total_pizza_sold
------top 5 pizzas by total orders-------
select top 5 pizza_name, count (distinct order_id) as total_orders
from pizza_sales 
group by pizza_name
order by total_orders desc
-----borrom 5 pizzas by total orders-----
select top 5 pizza_name , count (distinct order_id) as total_orders
from pizza_sales 
group by pizza_name
order by total_orders asc

-----note----
if you want to apply the pizza_category or pizza_size filters
to the above queries you can use where clause. follow some of below 
examples 

select top 5 pizza_name, count (distinct order_id) as total_orders
from pizza_sales 
where pizza_category='classic'
group by pizza_name
order by total_orders asc