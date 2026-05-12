-- Query 5: Customer retention (repeat purchase rate)
-- Skills: CTEs, subqueries, conditional aggregation
-- Note: Use customer_unique_id, not customer_id

USE OlistEcommerceDB;
GO

WITH CustomerOrderCounts AS (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS Total_Orders,
        MIN(o.order_purchase_timestamp) AS First_Order_Date,
        MAX(o.order_purchase_timestamp) AS Last_Order_Date,
        ROUND(SUM(p.payment_value), 2) AS Total_Spend
    FROM customers c
    INNER JOIN orders o
        ON c.customer_id = o.customer_id
    INNER JOIN payments p
        ON o.order_id = p.order_id
    WHERE o.order_status NOT IN ('cancelled','unavailable')
    GROUP BY c.customer_unique_id
)
SELECT
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Total_Orders = 1 THEN 1 ELSE 0 END) AS One_Time_Buyers,
    SUM(CASE WHEN Total_Orders >= 2 THEN 1 ELSE 0 END) AS Repeat_Buyers,
    ROUND(100.0 * SUM(CASE WHEN Total_Orders >= 2 THEN 1 ELSE 0 END) / COUNT(*), 2) AS Repeat_Purchase_Rate_Pct,
    ROUND(AVG(Total_Spend), 2) AS Avg_Customer_Spend,
    ROUND(AVG(CASE WHEN Total_Orders >= 2 THEN Total_Spend END), 2) AS Avg_Repeat_Buyer_Spend
FROM CustomerOrderCounts;