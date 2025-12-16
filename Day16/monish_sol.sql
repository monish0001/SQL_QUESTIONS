create table users
(
user_id integer,
name varchar(20),
join_date date
)
insert into users
values (1, 'Jon', CAST('2-14-20' AS date)), 
(2, 'Jane', CAST('2-14-20' AS date)), 
(3, 'Jill', CAST('2-15-20' AS date)), 
(4, 'Josh', CAST('2-15-20' AS date)), 
(5, 'Jean', CAST('2-16-20' AS date)), 
(6, 'Justin', CAST('2-17-20' AS date)),
(7, 'Jeremy', CAST('2-18-20' AS date));

create table events
(
user_id integer,
type varchar(10),
access_date date
);

insert into events values
(1, 'Pay', CAST('3-1-20' AS date)), 
(2, 'Music', CAST('3-2-20' AS date)), 
(2, 'P', CAST('3-12-20' AS date)),
(3, 'Music', CAST('3-15-20' AS date)), 
(4, 'Music', CAST('3-15-20' AS date)), 
(1, 'P', CAST('3-16-20' AS date)), 
(3, 'P', CAST('3-22-20' AS date));


select * from users
select * from events


/*Prime subscription rate by product action
Given the following two tables, return the fraction of users, rounded to two decimal places, who accessed Amzon music and upgraded to prime 
mebership within the first 30 days of signing up.*/

WITH cte1 AS (
    SELECT 
        u.user_id,
        e.type,
        DATEDIFF(day, u.join_date, e.access_date) AS day_diff
    FROM users u
    JOIN events e
        ON u.user_id = e.user_id
    WHERE DATEDIFF(day, u.join_date, e.access_date) < 30
      AND e.type IN ('Music', 'P')
)
SELECT
    COUNT(DISTINCT user_id) AS total_users,
    COUNT(DISTINCT CASE WHEN type = 'P' THEN user_id END) AS p_users,
    100.0 * 
    COUNT(DISTINCT CASE WHEN type = 'P' THEN user_id END)
    / COUNT(DISTINCT user_id) AS percentage
FROM cte1;


