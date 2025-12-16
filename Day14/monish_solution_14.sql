create table spending 
(
user_id int,
spend_date date,
platform varchar(10),
amount int
);

insert into spending values(1,'2019-07-01','mobile',100),(1,'2019-07-01','desktop',100),(2,'2019-07-01','mobile',100)
,(2,'2019-07-02','mobile',100),(3,'2019-07-01','desktop',100),(3,'2019-07-02','desktop',100);

select * from spending


with cte1 as (
select 
spend_date,
user_id,
max(platform) as platform,
sum(amount) as amount
from spending
group by user_id, spend_date having count(distinct platform)=1
union all
select 
spend_date,
user_id,
'both' as platform,
sum(amount) as amount
from spending
group by user_id, spend_date having count(distinct platform)=2
union all
select  
distinct spend_date,
NULL AS user_id,
'both' as platform,
0 as amount
from spending
) select 
spend_date,
platform,
sum(amount) as total_amount,
count(distinct user_id) total_users
from cte1
group by spend_date,
platform
order by spend_date, platform desc



---------------------------- DIFFRENCE BETWEEN DELETE AND TRUNCATE------------------------------
--truncate reset index,  INT IDENTITY(1,1) PRIMARY KEY,
--delete not 

CREATE TABLE monish (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(200)
);

insert into monish values('kanan')
insert into monish values('ajay')
insert into monish values('nijam')

select * from monish

truncate table monish

delete from monish

insert into monish values('raj')
insert into monish values('kumar')
insert into monish values('salman')


