USE OlistEcommerceDB;
GO

CREATE OR ALTER VIEW dbo.vw_OrderSummary AS
SELECT
    o.order_id,
    o.customer_id,
    c.customer_unique_id,
    c.customer_city,
    c.customer_state,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
    FORMAT(o.order_purchase_timestamp,'yyyy-MM') AS Order_YearMonth,
    DATEDIFF(day, o.order_purchase_timestamp, o.order_delivered_customer_date) AS Delivery_Days,
    CASE
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 'Late'
        WHEN o.order_delivered_customer_date IS NULL THEN 'Pending'
        ELSE 'On Time'
    END AS Delivery_Status,
    p.payment_value AS Order_Revenue,
    p.payment_type,
    ISNULL(r.review_score, 0) AS Review_Score
FROM dbo.orders o
INNER JOIN dbo.customers c ON o.customer_id = c.customer_id
INNER JOIN dbo.payments p ON o.order_id = p.order_id
LEFT JOIN dbo.reviews r ON o.order_id = r.order_id;
GO

SELECT TOP 10 *
FROM dbo.vw_OrderSummary;