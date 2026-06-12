```sql
-- models/intermediate/int_order_details.sql
with orders as (
    select * from {{ ref('stg_orders') }}
),

order_items as (
    select * from {{ ref('stg_order_items') }}
),

products as (
    select * from {{ ref('stg_products') }}
),

joined as (
    select
        oi.order_item_id,
        o.order_id,
        o.customer_id,
        o.order_date,
        o.order_year,
        o.order_month,
        o.order_year_month,
        p.product_id,
        p.product_name,
        p.category,
        p.unit_price,
        oi.quantity,
        (oi.quantity * p.unit_price) as line_revenue
    from order_items oi
    inner join orders  o on oi.order_id   = o.order_id
    inner join products p on oi.product_id = p.product_id
)

select * from joined
```
