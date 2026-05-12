-- Query 4: Seller performance with ranking
-- Skills: CTEs, window functions (RANK)

USE OlistEcommerceDB;
GO

WITH SellerMetrics AS (
    SELECT
        s.seller_id,
        s.seller_city,
        s.seller_state,
        COUNT(DISTINCT oi.order_id) AS Total_Orders,
        COUNT(oi.order_item_id) AS Items_Sold,
        ROUND(SUM(oi.price), 2) AS Total_Revenue,
        ROUND(AVG(oi.price), 2) AS Avg_Item_Price,
        ROUND(AVG(CAST(r.review_score AS FLOAT)), 2) AS Avg_Review_Score
    FROM sellers s
    INNER JOIN order_items oi
        ON s.seller_id = oi.seller_id
    INNER JOIN orders o
        ON oi.order_id = o.order_id
    LEFT JOIN reviews r
        ON o.order_id = r.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY s.seller_id, s.seller_city, s.seller_state
)
SELECT
    seller_id,
    seller_city,
    seller_state,
    Total_Orders,
    Total_Revenue,
    Avg_Review_Score,
    RANK() OVER (ORDER BY Total_Revenue DESC) AS Revenue_Rank,
    RANK() OVER (ORDER BY Total_Orders DESC) AS Volume_Rank,
    RANK() OVER (ORDER BY Avg_Review_Score DESC) AS Quality_Rank
FROM SellerMetrics
WHERE Total_Orders >= 10
ORDER BY Revenue_Rank;