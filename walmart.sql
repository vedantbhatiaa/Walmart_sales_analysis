select * from walmart_db;

select count(*) from walmart_db;

select distinct payment_method from walmart_db;

#different payment method and their count
select 
	payment_method, 
    count(*) as count
from walmart_db
group by payment_method;

#number of branch
select 
	count(distinct branch)
from walmart_db;

#max quantity 
select  MAX(quantity) from walmart_db;
select min(quantity) from walmart_db;


#--Business Problems--
-- 1.Find different payment method and number of transactions, number of qty sold
select 
	payment_method, 
    count(*) as no_payments,
    sum(quantity) as qty_sold
from walmart_db
group by payment_method
order by no_payments desc;


-- 2. Identitfy the highest rated category in each branch, displaying the branch, category and avg_rating 
select 
	branch,
	category, 
	round(avg(rating)) as avg_rating ,
	RANK() over(partition by branch order by avg(rating) desc) as ranking 
from walmart_db
group by 1, 2 ;


-- 3. Identify the busiest day for each branch based on the number of transactions 

#mm-dd-yy

select 
	date,
    dayname(date) as day_of_week,
    count(*) as no_of_transaction

from walmart_db
group by 1,2
order by 1,3 desc;



-- 4. Calculate total summary of items sold per payment method 


select 
	payment_method, 
    count(*) as count
from walmart_db
group by payment_method
order by count desc;

-- 5. determine avg minimum and max rating of each city
select 
	city,
    category,
    min(rating) as min_rating,
    max(rating) as max_rating,
    avg(rating) as avg_rating
from walmart_db
group by 1,2 ;


-- 6. calculate total profits for each category by considering total_profit 
-- as (unit_price * profit_margin) list category and total_profit, ordered from the highest
-- to lowest profit

select
	category,
    round(sum(total)) as total_revenue,
    round(sum(total * profit_margin)) as profit
from walmart_db
group by 1
order by 1 desc ;

-- 7. determine the most common payment method and display branch and their payment method
with cte 
as
(select 
	branch,
    payment_method,
    count(*) as total_trans,
    rank() over(partition by branch order by count(*) desc) as ranking
from walmart_db
group by 1,2
)
select *
from cte
where ranking=1;
    


    