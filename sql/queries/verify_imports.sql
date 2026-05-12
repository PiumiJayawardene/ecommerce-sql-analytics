USE OlistEcommerceDB;
SELECT 'orders' AS TableName, COUNT(*) AS [RowCount]
FROM orders

UNION ALL

SELECT 'order_items', COUNT(*)
FROM order_items

UNION ALL

SELECT 'products', COUNT(*)
FROM products

UNION ALL

SELECT 'customers', COUNT(*)
FROM customers

UNION ALL

SELECT 'sellers', COUNT(*)
FROM sellers

UNION ALL

SELECT 'reviews', COUNT(*)
FROM reviews

UNION ALL

SELECT 'payments', COUNT(*)
FROM payments

UNION ALL

SELECT 'geolocation', COUNT(*)
FROM geolocation

UNION ALL

SELECT 'category_translation', COUNT(*)
FROM category_translation;