# Olist case study: late delivery and review scores

**Status:** in progress | **Tools:** SQL (SQLite, DBeaver), Power BI (planned) 

## Main question
How much does late delivery hurt review scores, and does it vary by state or product category?

## Sub-questions
- Does the effect differ by state or region?
- Does it differ by product category?
- Do late orders also cost Olist repeat customers?

## Data
Case study with Brazilian E-Commerce Public Dataset by Olist [README with more info](data/README.md)

## Findings using SQL in DBeaver
[**Data checks (01_checks)**](sql/01_checks.sql)  
The dataset has 99.441 orders placed between 2016-09-04 and
2018-10-17.  
97% of orders were delivered, so the analysis focuses on
delivered orders.  

[**Data checks (02_delivery_vs_reviews)**](sql/02_delivery_vs_reviews.sql)  
The review table has 99,224 reviews. 547 orders have more than one review, so only the latest review per order is used.  
Of 95,824 delivered orders with a review:  
  
88,163 arrived on time and have an average score of 4.29. 9.2% gave a low score (1–2 stars).  
7,661 arrived late (8.0%) and have an average score of only 2.57. 54.1% gave a low score.  
  
Late deliveries score 1.72 points lower and are about 6× more likely to get a low review.

[**Delivery delay vs. reviews (03_delay_groups)**]
Orders were grouped by how many days late they arrived, using the latest review per order (95,824 orders with 1 review).

On time or early: 88,163 orders, avg score 4.29, 9.2% low scores.
1–3 days late: 2,636 orders, avg 3.77, 19.1% low.
4–7 days late: 1,773 orders, avg 2.32, 61.3% low.
8–14 days late: 1,748 orders, avg 1.74, 78.1% low.
15–30 days late: 1,161 orders, avg 1.61, 81.8% low.
30+ days late: 343 orders, avg 2.03, 68.5% low (small group).

Reviews drop sharply once a delivery is more than 3 days late. Beyond a week, about 4 in 5 customers leave a low score.
