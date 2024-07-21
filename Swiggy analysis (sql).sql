use etl5;
select*from `swiggy joint dataset`;
alter table `swiggy joint dataset` rename column `customer_name`to `customer_order`;

-- Total Number of Ordrs
select count(*)as  Total_Orders
 from `swiggy joint dataset`;

-- Q2 Average Order Total
select avg(order_total)as Average_Total_Order
 from `swiggy joint dataset`;
 
 -- Q3 Top 5 most expendsive Orders
 select order_id,order_total,restaurant_name,customer_order
 from `swiggy joint dataset`
 order by order_total desc limit 5;
 
 -- Q4 Order Grouped by Restotunt Name (Total and average Order value)
 select restaurant_name,count(*) as Total_order,
 round(avg(order_total))as avg_total_value
 from `swiggy joint dataset`
 group by restaurant_name
 order by total_order desc ;
 
-- Q5 Order palced in Rainy Days
select*from `swiggy joint dataset`
where rain_mode ='yes';

-- Q6 Percentage of Ontime vs Late orders
with order_status as (
select on_time,
      count(*)as order_count
from `swiggy joint dataset`
group by on_time
)
select 
os.on_time,
round(os.order_count / (select sum(order_count) 
from order_status)* 100)as perecntage
from order_status os;

-- Q7 Most Popular Restaurant On Rain days
select restaurant_name,count(*)as Total_Order
from `swiggy joint dataset`
where rain_mode='Yes'
group by restaurant_name
order by Total_Order desc;

-- Q8 Average Order Time by Restaurant 
select restaurant_name,
      avg(extract(hour from order_time))as avg_order_hour
from `swiggy joint dataset`
group by restaurant_name ;

-- Q9 order with Missing Values 
select*from`swiggy joint dataset`
where order_total is null
or restaurant_name is null
or rain_mode is null
or order_time is null 
or order_id is null;

-- Q10 Daily Orders (Count and Total Valus)
select date(order_time) as order_date,
       count(*) as Total_order,
       sum(order_total)as total_order_value
from `swiggy joint dataset`
group by date(order_time)
order by order_date;

-- Q11 Busy Days (Top 5 Days with most orders)
select date(order_time) as order_date,
        count(*) as total_order
from `swiggy joint dataset`
group by date(order_time)
order by total_order desc limit 5;

-- Q12 Orders Grouped by rain mode and on_time delivery
select rain_mode,on_time ,count(*)as order_total
from `swiggy joint dataset`
group by rain_mode,on_time
order by rain_mode,on_time;

