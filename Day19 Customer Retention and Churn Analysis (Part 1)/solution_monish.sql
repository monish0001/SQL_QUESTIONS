create table transactions(
order_id int,
cust_id int,
order_date date,
amount int
);
select * from transactions;
insert into transactions values 
(1,1,'2020-01-15',150)
,(2,1,'2020-02-10',150)
,(3,2,'2020-01-16',150)
,(4,2,'2020-02-25',150)
,(5,3,'2020-01-10',150)
,(6,3,'2020-02-20',150)
,(7,4,'2020-01-20',150)
,(8,5,'2020-02-20',150)
;



SELECT 
    MONTH(this_month.order_date) AS month_date,
    COUNT(DISTINCT last_month.cust_id) AS repeat_customers
FROM transactions AS this_month
left JOIN transactions AS last_month
    ON this_month.cust_id = last_month.cust_id 
    AND DATEDIFF(MONTH, last_month.order_date, this_month.order_date) = 1
GROUP BY MONTH(this_month.order_date)
