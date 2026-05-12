-- Query 1: Monthly order volume and revenue trend

USE OlistEcommerceDB;
GO

SELECT
    YEAR(o.order_purchase_timestamp) AS Order_Year,
    MONTH(o.order_purchase_timestamp) AS Order_Month,
    FORMAT(o.order_purchase_timestamp, 'yyyy-MM') AS Year_Month,
    COUNT(DISTINCT o.order_id) AS Total_Orders,
    COUNT(DISTINCT o.customer_id) AS Unique_Customers,
    ROUND(SUM(p.payment_value), 2) AS Total_Revenue,
    ROUND(AVG(p.payment_value), 2) AS Avg_Order_Value
FROM orders o
INNER JOIN payments p
    ON o.order_id = p.order_id
WHERE o.order_status NOT IN ('cancelled', 'unavailable')
GROUP BY
    YEAR(o.order_purchase_timestamp),
    MONTH(o.order_purchase_timestamp),
    FORMAT(o.order_purchase_timestamp, 'yyyy-MM')
ORDER BY Order_Year, Order_Month;