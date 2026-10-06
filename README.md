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
