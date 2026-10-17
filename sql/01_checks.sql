-- 01_checks.sql
-- Purpose: basic checks on the orders table
-- Findings:
--   99,441 orders, placed between 2016-09-04 and 2018-10-17
--   97% delivered, 0.6% canceled, 0.6% unavailable

-- 1. Total number of orders
SELECT COUNT(*) AS total_orders
FROM orders;

-- 2. Date range of purchases
SELECT MIN(order_purchase_timestamp) AS first_order,
       MAX(order_purchase_timestamp) AS last_order
FROM orders;

-- 3. Orders per status
SELECT order_status,
       COUNT(*) AS orders
FROM orders 
GROUP BY order_status
ORDER BY orders DESC;
