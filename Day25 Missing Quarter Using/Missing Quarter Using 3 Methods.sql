CREATE TABLE STORES (
Store varchar(10),
Quarter varchar(10),
Amount int);

INSERT INTO STORES (Store, Quarter, Amount)
VALUES ('S1', 'Q1', 200),
('S1', 'Q2', 300),
('S1', 'Q4', 400),
('S2', 'Q1', 500),
('S2', 'Q3', 600),
('S2', 'Q4', 700),
('S3', 'Q1', 800),
('S3', 'Q2', 750),
('S3', 'Q3', 900);



select * from STORES;

with cte1 as (
select
store,
10-sum(cast(SUBSTRING(Quarter,2,1) as INT)) as Quarter_No
from STORES
group by store
)
select
store,
'Q'+ cast(Quarter_No as varchar) as Quarter_No
from cte1


-- Sol 2

with cte1 as (
select 
distinct
s1.store,
s2.Quarter

from STORES as s1, STORES as s2

) select 

c1.*
--,s.*

from cte1 as c1
left join  STORES as s
on c1.store=s.store and c1.quarter=s.quarter

where s.quarter is null