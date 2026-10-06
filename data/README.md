# Data

The raw data files are not included in this repository. Please download them from the original source.

## Source
- **Dataset:** Brazilian E-Commerce Public Dataset by Olist
- **Where to get it:** [Link to Kaggle]([https://www.kaggle.com/](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce))
- **What it contains:** about 100,000 orders placed at a Brazilian online marketplace between 2016 and 2018, with customer, product, payment, delivery and review information. The data is anonymised.
- **Licence:** see the licence on the Kaggle page before reusing or redistributing the data.

## Files used in this project
| File | Table name in my database | What it holds |
|---|---|---|
| `olist_orders_dataset.csv` | `orders` | One row per order, with status and key timestamps |
| `olist_customers_dataset.csv` | `customers` | Customer IDs and location |
| `olist_order_items_dataset.csv` | `order_items` | Products in each order, with price and freight |
| `olist_order_payments_dataset.csv` | `payments` | Payment type and value |
| `olist_order_reviews_dataset.csv` | `reviews` | Review scores and comments |
| `olist_products_dataset.csv` | `products` | Product details |
| `olist_sellers_dataset.csv` | `sellers` | Seller location |
| `olist_geolocation_dataset.csv` | `geolocation` | Zip code coordinates |
| `product_category_name_translation.csv` | `category_translation` | Category names in English |
