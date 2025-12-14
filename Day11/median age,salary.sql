create  table emp(
emp_id int,
emp_name varchar(20),
department_id int,
salary int,
manager_id int,
emp_age int)

insert into emp
values
(1, 'Ankit', 100,10000, 4, 39),
(2, 'Mohit', 100, 15000, 5, 48),
(3, 'Vikas', 100, 10000,4,37),
(4, 'Rohit', 100, 5000, 2, 16),
(5, 'Mudit', 200, 12000, 6,55),
(6, 'Agam', 200, 12000,2, 14),
(7, 'Sanjay', 200, 9000, 2,13),
(8, 'Ashish', 200,5000,2,12),
(9, 'Mukesh',300,6000,6,51),
(10, 'Rakesh',300,7000,6,50);

select * from emp



select 
department_id,
avg(emp_age) as  avg_age
from (select 
	department_id,
	emp_age,
	row_number() over(partition by department_id order by emp_age ASC) as rn_asc,
	row_number() over(partition by department_id order by emp_age DESC) as rn_dsc
	from emp
) t
where abs(rn_asc-rn_dsc)<=1
group by department_id



------------------------------------------------------
WITH cte1 AS (
  SELECT 
    department_id,
    salary,
    ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary) AS rn,
    COUNT(*) OVER (PARTITION BY department_id) AS count_in_dept
  FROM emp
)
SELECT 
department_id,
avg(salary) as median_salary from cte1
where rn in ((count_in_dept+1)/2,(count_in_dept+2)/2)
group by department_id

select * from emp







