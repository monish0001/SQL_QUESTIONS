create table UserActivity
(
username      varchar(20) ,
activity      varchar(20),
startDate     Date   ,
endDate      Date
);

insert into UserActivity values 
('Alice','Travel','2020-02-12','2020-02-20')
,('Alice','Dancing','2020-02-21','2020-02-23')
,('Alice','Travel','2020-02-24','2020-02-28')
,('Bob','Travel','2020-02-11','2020-02-18');

select * from UserActivity

-- --Get the Second Most Recent Activity, if there is only one activity then retunr that one


with cte as (
select username,
count(activity) as total_activities
from UserActivity
group by username
), cte1 as (
select 
a1.*,
a2.total_activities
from UserActivity as a1
inner join cte as a2
on a1.username=a2.username
), cte2 as (
select
*,
row_number() over(partition by username order by startDate) as rnk
from cte1
)
select * from cte2 where rnk=2
union all
select * from cte2 where rnk=1 and username not in (select username from cte2 where rnk=2)

