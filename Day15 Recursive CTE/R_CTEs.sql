

WITH cte AS (
    -- Anchor member
    SELECT 1 AS num

    UNION ALL

    -- Recursive member
    SELECT num + 1
    FROM cte
    WHERE num < 10
)
SELECT * FROM cte

OPTION (MAXRECURSION 100);
-----------------------------------------------------------------------------------------------------------------
create table sales ( product_id int, period_start date, period_end date, average_daily_sales int ); 
insert into sales values(1,'2019-01-25','2019-02-28',100),(2,'2018-12-01','2020-01-01',10),(3,'2019-12-01','2020-01-31',1);

select * from sales

WITH r_cte AS (
    -- Anchor member
    SELECT
        product_id,
        period_start AS report_year,
        period_end,
        average_daily_sales
    FROM Sales

    UNION ALL

    -- Recursive member
    SELECT
        product_id,
        DATEADD(day, 1, report_year) AS report_year,
        period_end,
        average_daily_sales
    FROM r_cte
    WHERE report_year < period_end
)
SELECT
    product_id,
    year(report_year) as report_year,
    sum(average_daily_sales)
FROM r_cte
group by  product_id,
    year(report_year)
order by   product_id,
    year(report_year)
OPTION (MAXRECURSION 1000);