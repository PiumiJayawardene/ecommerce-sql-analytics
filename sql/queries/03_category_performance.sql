-- Query 2: Product category revenue and average review score
-- Joins: Orders + OrderItems + Products + Reviews
-- Skills: 4-table JOIN, aggregation, HAVING clause

USE OlistEcommerceDB;
GO

SELECT
    p.product_category_name AS Category,
    COUNT(DISTINCT oi.order_id) AS Total_Orders,
    COUNT(oi.order_item_id) AS Items_Sold,
    ROUND(SUM(oi.price), 2) AS Total_Revenue,
    ROUND(AVG(oi.price), 2) AS Avg_Item_Price,
    ROUND(AVG(CAST(r.review_score AS FLOAT)), 2) AS Avg_Review_Score
FROM order_items oi
INNER JOIN products p
    ON oi.product_id = p.product_id
INNER JOIN orders o
    ON oi.order_id = o.order_id
LEFT JOIN reviews r
    ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
    AND p.product_category_name IS NOT NULL
GROUP BY p.product_category_name
HAVING COUNT(DISTINCT oi.order_id) > 100
ORDER BY Total_Revenue DESC;