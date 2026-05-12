-- Stored Procedure: usp_GetStateReport
-- Purpose: Returns full sales summary for any given state
-- Usage: EXEC usp_GetStateReport @StateCode = 'SP'

USE OlistEcommerceDB;
GO

CREATE OR ALTER PROCEDURE usp_GetStateReport
    @StateCode NVARCHAR(2)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        @StateCode                         AS State,
        COUNT(DISTINCT order_id)           AS Total_Orders,
        COUNT(DISTINCT customer_unique_id) AS Unique_Customers,
        ROUND(SUM(Order_Revenue),2)        AS Total_Revenue,
        ROUND(AVG(Order_Revenue),2)        AS Avg_Order_Value,
        ROUND(AVG(CAST(Review_Score
            AS FLOAT)),2)                  AS Avg_Review_Score,
        ROUND(AVG(CAST(Delivery_Days
            AS FLOAT)),1)                  AS Avg_Delivery_Days,
        SUM(CASE WHEN Delivery_Status='Late'
            THEN 1 ELSE 0 END)             AS Late_Deliveries
    FROM dbo.vw_OrderSummary
    WHERE customer_state = @StateCode
        AND order_status = 'delivered';
END;
GO

-- Test it:
EXEC usp_GetStateReport @StateCode = 'SP';
EXEC usp_GetStateReport @StateCode = 'RJ';