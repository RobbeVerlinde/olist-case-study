-- Data checks: row count, date range, order status
Select count(*) from olist_orders_dataset ood ;

Select min(order_purchase_timestamp), max(order_purchase_timestamp) from olist_orders_dataset ood;

select ood.order_status , count(*) as orders
from olist_orders_dataset ood 
group by order_status
order by orders desc;
