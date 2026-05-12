-- Query 6: Order status funnel analysis
-- Shows how many orders progress through each stage
-- Skills: CASE WHEN, percentage calculations, funnel logic

USE OlistEcommerceDB;
GO

WITH FunnelCounts AS (
    SELECT
        COUNT(*) AS Total_Orders,
        SUM(CASE WHEN order_status IN
            ('approved','processing','shipped','delivered','invoiced')
            THEN 1 ELSE 0 END) AS Approved,
        SUM(CASE WHEN order_status IN
            ('processing','shipped','delivered','invoiced')
            THEN 1 ELSE 0 END) AS Processing,
        SUM(CASE WHEN order_status IN
            ('shipped','delivered')
            THEN 1 ELSE 0 END) AS Shipped,
        SUM(CASE WHEN order_status = 'delivered'
            THEN 1 ELSE 0 END) AS Delivered,
        SUM(CASE WHEN order_status = 'cancelled'
            THEN 1 ELSE 0 END) AS Cancelled
    FROM orders
)
SELECT
    '1. Created' AS Stage,
    Total_Orders AS Orders,
    100.0 AS Pct_Of_Total
FROM FunnelCounts

UNION ALL

SELECT
    '2. Approved',
    Approved,
    ROUND(100.0 * Approved / Total_Orders, 1)
FROM FunnelCounts

UNION ALL

SELECT
    '3. Processing',
    Processing,
    ROUND(100.0 * Processing / Total_Orders, 1)
FROM FunnelCounts

UNION ALL

SELECT
    '4. Shipped',
    Shipped,
    ROUND(100.0 * Shipped / Total_Orders, 1)
FROM FunnelCounts

UNION ALL

SELECT
    '5. Delivered',
    Delivered,
    ROUND(100.0 * Delivered / Total_Orders, 1)
FROM FunnelCounts

UNION ALL

SELECT
    '6. Cancelled',
    Cancelled,
    ROUND(100.0 * Cancelled / Total_Orders, 1)
FROM FunnelCounts;