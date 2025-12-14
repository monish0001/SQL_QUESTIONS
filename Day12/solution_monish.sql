create table players
(player_id int,
group_id int)

insert into players values (15,1);
insert into players values (25,1);
insert into players values (30,1);
insert into players values (45,1);
insert into players values (10,2);
insert into players values (35,2);
insert into players values (50,2);
insert into players values (20,3);
insert into players values (40,3);

create table matches
(
match_id int,
first_player int,
second_player int,
first_score int,
second_score int)

insert into matches values (1,15,45,3,0);
insert into matches values (2,30,25,1,2);
insert into matches values (3,30,15,2,0);
insert into matches values (4,40,20,5,2);
insert into matches values (5,35,50,1,1);


select * from matches
select * from players


with cte1 as (
select 
group_id,
player_id,
sum(first_score) as score
from matches as m
inner join players as p1 on p1.player_id=m.first_player
group by group_id,
player_id
),cte2 as(
select 
group_id,
player_id,
sum(second_score) as score
from matches as m
inner join players as p2 on p2.player_id=m.second_player
group by group_id,
player_id
), cte3 as (
select* from cte1
union all 
select* from cte2
)
, cte4 as (
select 
group_id,
player_id,
sum(score) as score
from cte3
group by group_id,
player_id
), cte5 as (
select 
group_id,
player_id,
score,
row_number() over(partition by group_id order by score DESC,player_id) as rn
from cte4
)
select 
group_id,
player_id,
score
from cte5
where rn =1