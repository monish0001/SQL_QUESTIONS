CREATE Table department (
   DEPT_NAME Varchar(20),
   MANAGER_NAME Varchar(255) );

   CREATE Table employee_5 (
   EMP_ID int,
   EMP_NAME Varchar(20),
   DEPT_NAME Varchar(255) );

INSERT INTO department (DEPT_NAME, MANAGER_NAME) 
VALUES ('IT', 'ROHAN'),  
    ('SALES', 'RAHUL'),  
    ('HR', 'TANMAY'),  
    ('FINANCE', 'ASHISH'),  
    ('MARKETING', 'SAMAY');

INSERT INTO employee_5 (EMP_ID, EMP_NAME, DEPT_NAME) 
VALUES  
    (1, 'SUMIT', 'HR'),  
    (2, 'JOEL', 'IT'),  
    (3, 'BISWA', 'MARKETING'),  
    (4, 'VAIBHAV', 'IT'),  
    (5, 'SAGAR', 'SALES');


    select * from employee_5
    select * from department
-- SQL server does not support natural join
SELECT *
FROM employee_5
NATURAL JOIN department

| Feature                 | Natural Join                                                            | Inner Join                                                        |
| ----------------------- | ----------------------------------------------------------------------- | ----------------------------------------------------------------- |
| Join Condition          | Automatically matches columns with the same name and data type          | Requires explicit join condition using the `ON` clause            |
| Common Columns          | Includes only one copy of each common column                            | Includes both copies, which can lead to duplicate column names    |
| Syntax Simplicity       | Shorter and simpler (no need to write the join condition)               | More flexible but requires the join condition to be defined       |
| Control Over Join Logic | Less control (relies on column names being the same)                    | Full control over how tables are joined                           |
| Use Case                | Useful when tables share common column names and a quick join is needed | Used when joining on specific columns or when column names differ |

