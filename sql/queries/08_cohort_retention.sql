-- Query 7: 90-day cohort retention analysis
-- Skills: CTEs, DATEDIFF, customer retention logic

USE OlistEcommerceDB;
GO

WITH CustomerFirstOrder AS (
    SELECT
        c.customer_unique_id,
        MIN(o.order_purchase_timestamp) AS First_Order_Date,
        FORMAT(MIN(o.order_purchase_timestamp), 'yyyy-MM') AS Cohort_Month
    FROM customers c
    INNER JOIN orders o
        ON c.customer_id = o.customer_id
    WHERE o.order_status NOT IN ('cancelled','unavailable')
    GROUP BY c.customer_unique_id
),

CustomerOrders AS (
    SELECT
        c.customer_unique_id,
        cfo.Cohort_Month,
        FORMAT(o.order_purchase_timestamp, 'yyyy-MM') AS Order_Month,
        DATEDIFF(month, cfo.First_Order_Date, o.order_purchase_timestamp) AS Months_Since_First
    FROM customers c
    INNER JOIN orders o
        ON c.customer_id = o.customer_id
    INNER JOIN CustomerFirstOrder cfo
        ON c.customer_unique_id = cfo.customer_unique_id
    WHERE o.order_status NOT IN ('cancelled','unavailable')
),

CohortSize AS (
    SELECT
        Cohort_Month,
        COUNT(DISTINCT customer_unique_id) AS Cohort_Customers
    FROM CustomerFirstOrder
    GROUP BY Cohort_Month
)

SELECT
    co.Cohort_Month,
    cs.Cohort_Customers,
    co.Months_Since_First,
    COUNT(DISTINCT co.customer_unique_id) AS Retained_Customers,
    ROUND(
        100.0 * COUNT(DISTINCT co.customer_unique_id) / cs.Cohort_Customers,
        1
    ) AS Retention_Rate_Pct
FROM CustomerOrders co
INNER JOIN CohortSize cs
    ON co.Cohort_Month = cs.Cohort_Month
WHERE co.Months_Since_First BETWEEN 0 AND 6
GROUP BY
    co.Cohort_Month,
    cs.Cohort_Customers,
    co.Months_Since_First
ORDER BY
    co.Cohort_Month,
    co.Months_Since_First;