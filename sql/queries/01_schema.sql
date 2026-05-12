-- Olist E-Commerce Database Schema Documentation
-- Database: ecommerce_analytics
-- Analyst: P.N. Jayawardene

-- TABLE RELATIONSHIPS:
-- orders.order_id        → order_items.order_id     (1 to many)
-- orders.customer_id     → customers.customer_id     (many to 1)
-- order_items.product_id → products.product_id       (many to 1)
-- order_items.seller_id  → sellers.seller_id         (many to 1)
-- orders.order_id        → reviews.order_id          (1 to 1)
-- orders.order_id        → payments.order_id         (1 to many)
-- products.product_category_name → category_translation.product_category_name (many to 1)

-- KEY COLUMN REFERENCE:
-- orders: order_id, customer_id, order_status, order_purchase_timestamp,
--         order_approved_at, order_delivered_carrier_date,
--         order_delivered_customer_date, order_estimated_delivery_date

-- order_items: order_id, order_item_id, product_id, seller_id,
--              shipping_limit_date, price, freight_value

-- customers: customer_id, customer_unique_id, customer_zip_code_prefix,
--            customer_city, customer_state

-- products: product_id, product_category_name, product_name_lenght,
--           product_description_lenght, product_photos_qty,
--           product_weight_g, product_length_cm, product_height_cm,
--           product_width_cm

-- sellers: seller_id, seller_zip_code_prefix, seller_city, seller_state

-- reviews: review_id, order_id, review_score, review_comment_title,
--          review_comment_message, review_creation_date,
--          review_answer_timestamp

-- payments: order_id, payment_sequential, payment_type,
--           payment_installments, payment_value

-- geolocation: geolocation_zip_code_prefix, geolocation_lat,
--              geolocation_lng, geolocation_city, geolocation_state

-- category_translation: product_category_name,
--                       product_category_name_english