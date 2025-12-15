

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
