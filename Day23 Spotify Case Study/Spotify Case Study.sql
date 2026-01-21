CREATE table activity
(
user_id varchar(20),
event_name varchar(20),
event_date date,
country varchar(20)
);
delete from activity;
insert into activity values (1,'app-installed','2022-01-01','India')
,(1,'app-purchase','2022-01-02','India')
,(2,'app-installed','2022-01-01','USA')
,(3,'app-installed','2022-01-01','USA')
,(3,'app-purchase','2022-01-03','USA')
,(4,'app-installed','2022-01-03','India')
,(4,'app-purchase','2022-01-03','India')
,(5,'app-installed','2022-01-03','SL')
,(5,'app-purchase','2022-01-03','SL')
,(6,'app-installed','2022-01-04','Pakistan')
,(6,'app-purchase','2022-01-04','Pakistan');

select * from activity order by event_date 

-- the activity table shows the app-installed and app purchase acrivities for spotify app alng with country details

/*Question 1: find total active users each day
event_date
total_active_users
2022-01-01 3
2022-01-02 1
2022-01-03
3
2022-01-04 1
*/

select 
event_date,
count(distinct user_id) as active_user
from activity
group by event_date

/*Question 2: find total active users each week
week_number total_active_users
1
3
2
5
*/

select
datepart(week,event_date) as week,
count(distinct user_id) as active_user
from activity
group by datepart(week,event_date) 

/*
Question 3: date wise total number of users who made the purchare same day they installed the app
event_date no_of_users_same_day_purchase
2022-01-01			0
2022-01-02			0
2022-01-03			2
2022-01-04			1
*/
select * from  activity
select * from  activity

select 
a1.event_date,
count(distinct a1.user_id) no_of_users_same_day_purchase
from activity as a1
inner join activity as a2
on a1.user_id=a2.user_id
and a1.event_date=a2.event_date
and ((a1.event_name='app-installed' and a2.event_name='app-purchase') or (a2.event_name='app-installed' and a1.event_name='app-purchase'))
group by a1.event_date

---------------------------------------------------------------------------------------------

with cte as (
select user_id,event_date,
case
	when count(distinct event_name)=2 then user_id 
	else null
end as users
from activity
group by user_id,event_date
)
select event_date,
count(distinct users) as no_of_users_same_day_purchase
 from cte
group by event_date


/*
Question 4: percentage of paid users in India, USA and any other country should be tagged as others
country percentage_users
India		40
USA			20
others		40
*/
select * from  activity

select 
'India' as country,
1.0*count(*)/(select count(*) from activity where event_name='app-purchase')*100 as percentage_users
from activity
where country='India' and event_name='app-purchase'
union all
select 
'USA' as country,
1.0*count(*)/(select count(*) from activity where event_name='app-purchase')*100 as percentage_users
from activity
where country='USA' and event_name='app-purchase'
union all
select 
'others' as country,
1.0*count(*)/(select count(*) from activity where  event_name='app-purchase')*100 as percentage_users
from activity
where country  not in ('India','USA') and event_name='app-purchase'

/*

Question 5: Among all the users who installed the app on a given day, how many did in app purchared on the very next day--day wise result
event_date cnt_users
2022-01-01	 0
2022-01-02	 1
2022-01-03	 0
2022-01-04	 0

*/

select * from activity


with cte as (
select
e1.user_id,
e1.event_date as appinstalled,
e2.event_date as apppurchase,
datediff(day,e1.event_date,e2.event_date) as day_diff
from activity as e1
inner join activity as e2
on  e1.user_id=e2.user_id and e1.event_name='app-installed' and e2.event_name='app-purchase'
)

select 
appinstalled,
sum(
case
	when day_diff =1 then 1	else 0
end) as cnt_users
from cte
group by appinstalled


