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

## Findings
[**Data checks (01_checks)**](sql/01_checks.sql)  
The dataset has 99.441 orders placed between 2016-09-04 and
2018-10-17.  
97% of orders were delivered, so the analysis focuses on
delivered orders.  

[**Data checks (02_delivery_vs_reviews)**](sql/02_delivery_vs_reviews.sql)  
Out of the 96.470 actually delivered orders, there are a total of 99.224 reviews.  
From the 547 orders with multiple reviews, we will only use the latest review.  
There's 88.163 orders that were delivered on time, these get an average review score of 4.29 (9.2%)  
There's 7.661 orders that were delivered late, these get an average review score of only 2.57 (54.1%). This is considerably lower.
