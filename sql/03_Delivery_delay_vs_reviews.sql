-- 03_delay_groups.sql
-- Purpose: check how the review score changes with the number of days late
-- Method:
--   same orders and latest review per order as in 02_delivery_vs_reviews (95,824 orders)
--   days late = delivered date - estimated date, grouped into 6 groups
-- Findings:
--   on time/early   88,163 orders  avg 4.29  9.2% low
--   1-3 days late    2,636 orders  avg 3.77  19.1% low
--   4-7 days late    1,773 orders  avg 2.32  61.3% low
--   8-14 days late   1,748 orders  avg 1.74  78.1% low
--   15-30 days late  1,161 orders  avg 1.61  81.8% low
--   30+ days late      343 orders  avg 2.03  68.5% low (small group)
--   Scores drop sharply after more than 3 days late

-- days late per order
SELECT o.order_id, 
	ROUND(JULIANDAY(o.order_delivered_customer_date)-JULIANDAY(o.order_estimated_delivery_date)) AS dayslate
FROM orders o
WHERE o.order_status = 'delivered'
	AND NULLIF(o.order_delivered_customer_date , "")IS NOT NULL
	AND JULIANDAY(o.order_delivered_customer_date)-JULIANDAY(o.order_estimated_delivery_date) <= 30
ORDER BY dayslate DESC;

-- seperate orders into groups by amount of days late
WITH days AS (
	SELECT o.order_id,
	JULIANDAY(o.order_delivered_customer_date)
	- JULIANDAY(o.order_estimated_delivery_date) AS days_late
	FROM orders o
	WHERE o.order_status = 'delivered'
		AND NULLIF(o.order_delivered_customer_date, '') IS NOT NULL
),
latest_review AS (
	SELECT r.order_id, r.review_score,
		ROW_NUMBER() OVER (PARTITION BY r.order_id 
							ORDER BY r.review_answer_timestamp  DESC) AS rn
	FROM order_reviews r
),
grouped AS (
	SELECT d.order_id, r.review_score,
		CASE
			WHEN d.days_late <= 0 THEN '1. on time/early'
			WHEN d.days_late <= 3 THEN '2. 1-3 days late'
			WHEN d.days_late <= 7 THEN '3. 4-7 days late'
			WHEN d.days_late <= 14 THEN '4. 8-14 days late'
			WHEN d.days_late <= 30 THEN '5. 15-30 days late'
			ELSE						'6. 30+ days late'
		END AS lategroup
	FROM days d
  	JOIN latest_review r ON r.order_id = d.order_id AND r.rn = 1
)
SELECT lategroup,
       COUNT(*)                                   AS orders,
       ROUND(AVG(review_score), 2)                AS avg_score,
       ROUND(100.0 * SUM(review_score <= 2) / COUNT(*), 1) AS pct_low_score
FROM grouped
GROUP BY lategroup
ORDER BY lategroup ASC ;	
		
	
	


	

