select * from employee order by salary DESC
-- USING MAX
-- second highest salary
SELECT MAX(salary) 
FROM employee
WHERE salary < (SELECT MAX(salary) FROM employee)
-- third highest salary
SELECT MAX(salary) 
FROM employee
WHERE salary <
(SELECT MAX(salary) 
FROM employee
WHERE salary < (SELECT MAX(salary) FROM employee))
-- fourth highest salary

(SELECT MAX(salary) 
FROM employee
WHERE salary <
(SELECT MAX(salary) 
FROM employee
WHERE salary < (SELECT MAX(salary) FROM employee)))





-- LIMIT AND OFFSET
select distinct salary from employee
order by salary desc
offset (N-1 th highest salary) row
fetch next (how many row  you want to select) row only

-- second highest salary
select distinct salary from employee
order by salary desc
offset  2 row
fetch next 1 row only

-- third highest salary
select distinct salary from employee
order by salary desc
offset 2 row
fetch next 1 row only

-- fourth highest salary
select distinct salary from employee
order by salary
offset 3 row
fetch next 1 row only


--USING Correlated Subqueries
-- Nth highest salary
SELECT Salary
FROM Employee e1
WHERE N-1 = (
    SELECT COUNT(DISTINCT e2.Salary)
    FROM Employee e2
    WHERE e2.Salary > e1.Salary
);


-- second highest salary
SELECT Salary
FROM Employee e1
WHERE 1 = (
    SELECT COUNT(DISTINCT e2.Salary)
    FROM Employee e2
    WHERE e2.Salary > e1.Salary
)
-- third highest salary

select distinct salary from employee as e1
where 2=(select count(distinct salary) from employee as e2 where e2.salary>e1.salary)

-- fourth highest salary
select distinct salary from employee as e1
where 3=(select count(distinct salary) from employee as e2 where e2.salary>e1.salary)


-- USING DENSE_RANK
-- Nth highest salary
SELECT Salary
FROM (
    SELECT Salary,
           DENSE_RANK() OVER (ORDER BY Salary DESC) AS rnk
    FROM Employee
) t
WHERE rnk = N;
-- second highest salary
select salary
from
(
select salary,
DENSE_RANK() OVER(order by salary DESC) as drn
from employee
) t
where drn=2
--third highest salary
select salary
from
(
select salary,
DENSE_RANK() OVER(order by salary DESC) as drn
from employee
) t
where drn=3
--fourth highest salary
select salary
from
(
select salary,
DENSE_RANK() OVER(order by salary DESC) as drn
from employee
) t
where drn=4


-- SQL FUNCTION
--CREATE FUNCTION dbo.FunctionName (@param type)
--RETURNS type
--AS
--BEGIN
--    RETURN (scalar expression)
--END

--DROP FUNCTION IF EXISTS dbo.getNthHighestSalary;

CREATE FUNCTION dbo.getNthHighestSalary (@N INT)
RETURNS INT
AS
BEGIN
    RETURN (
        SELECT MAX(Salary)
        FROM (
            SELECT Salary,
                   DENSE_RANK() OVER (ORDER BY Salary DESC) AS drn
            FROM Employee
        ) t
        WHERE drn = @N
    );
END;

-- second highest salary
SELECT dbo.getNthHighestSalary(2) AS SecondHighestSalary
--third highest salary
SELECT dbo.getNthHighestSalary(3) AS SecondHighestSalary
--fourth highest salary
SELECT dbo.getNthHighestSalary(4) AS SecondHighestSalary




