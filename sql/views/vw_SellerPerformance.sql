USE OlistEcommerceDB;
GO

CREATE OR ALTER VIEW vw_SellerPerformance AS

SELECT
    s.seller_id,
    s.seller_city,
    s.seller_state,

    COUNT(DISTINCT oi.order_id) AS Total_Orders,
    COUNT(oi.order_item_id) AS Items_Sold,

    ROUND(SUM(oi.price),2) AS Total_Revenue,
    ROUND(AVG(oi.price),2) AS Avg_Item_Price,

    ROUND(AVG(CAST(r.review_score AS FLOAT)),2) AS Avg_Review_Score,

    ROUND(AVG(DATEDIFF(day,
        o.order_purchase_timestamp,
        o.order_delivered_customer_date
    )),1) AS Avg_Delivery_Days

FROM sellers s
INNER JOIN order_items oi
    ON s.seller_id = oi.seller_id
INNER JOIN orders o
    ON oi.order_id = o.order_id
LEFT JOIN reviews r
    ON o.order_id = r.order_id

WHERE o.order_status = 'delivered'
    AND o.order_delivered_customer_date IS NOT NULL

GROUP BY
    s.seller_id,
    s.seller_city,
    s.seller_state;
GO