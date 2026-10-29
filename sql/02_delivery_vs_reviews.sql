-- 02_delivery_vs_reviews.sql
-- Purpose: compare review scores of late vs. on-time delivered orders
-- Method:
--   only delivered orders with a delivery date
--   late = delivered after the estimated delivery date
--   547 orders have multiple reviews, so only the latest review per order is used
-- Findings:
--   99,224 reviews in total, 96,470 orders delivered
--   95,824 delivered orders with 1 review were analysed
--   88,163 on time: avg score 4.29, 9.2% low scores (1-2 stars)
--   7,661 late:     avg score 2.57, 54.1% low scores
--   Late orders score 1.72 points lower

-- Actually delivered orders
SELECT COUNT(*) as delivered_orders,
       COUNT(NULLIF(order_delivered_customer_date,'')) AS with_delivery_date
FROM orders
WHERE order_status = 'delivered';

-- Total reviews in order_reviews.
SELECT COUNT(*) order_reviews FROM order_reviews;

-- Do any orders have more than one review?
SELECT COUNT(*) AS orders_with_multiple_reviews
FROM (SELECT order_id
      FROM order_reviews
      GROUP BY order_id
      HAVING COUNT(*)>1);

-- Review scores for late vs. on-time deliveries
SELECT CASE WHEN julianday(order_delivered_customer_date) >
                 julianday(order_estimated_delivery_date)
                 THEN 'late' ELSE 'on time' END AS delivery,
       COUNT(*) AS reviews,
       ROUND(AVG(review_score), 2) AS avg_score,
       ROUND(100.0 * SUM(CASE WHEN review_score <=2 THEN 1 ELSE 0 END) / COUNT(*), 1) AS pct_low_scores
       FROM orders
       JOIN order_reviews ON order_reviews.order_id = orders.order_id
       WHERE order_status = 'delivered'
         AND NULLIF(order_delivered_customer_date, '') IS NOT NULL 
       GROUP BY delivery;

-- Review scores for late vs. on-time deliveries, where only the last review is kept, max 1 review per order.
WITH one_review AS(
	SELECT order_id , review_score 
	FROM (SELECT order_id, review_score,
				ROW_NUMBER() OVER (PARTITION BY t.order_id 
								   ORDER BY t.review_answer_timestamp  DESC) AS rn
	      FROM order_reviews t)
    WHERE rn=1)
SELECT CASE WHEN julianday(o.order_delivered_customer_date ) > julianday(o.order_estimated_delivery_date )
 			 THEN 'late' ELSE 'on time' END AS delivery,
 	    COUNT(*) AS orders,
 	    ROUND(AVG(r.review_score ), 2) AS avg_score,
 	    ROUND(100.0 * SUM(CASE WHEN r.review_score <=2 THEN 1 ELSE 0 END) / COUNT(*), 1) AS pct_low_scores
FROM orders o 
JOIN one_review r  ON r.order_id = o.order_id
WHERE o.order_status = 'delivered'
  AND NULLIF(o.order_delivered_customer_date, '') IS NOT NULL 
GROUP BY delivery;
