```sql
-- models/marts/fact_sales.sql
with order_details as (
    select * from {{ ref('int_order_details') }}
),

customers as (
    select
        customer_id,
        customer_name,
        city,
        customer_segment
    from {{ ref('dim_customer') }}
),

products as (
    select
        product_id,
        product_name,
        category
    from {{ ref('dim_product') }}
),

final as (
    select
        -- Keys
        od.order_item_id,
        od.order_id,
        od.customer_id,
        od.product_id,

        -- Date dimensions
        od.order_date,
        od.order_year,
        od.order_month,
        od.order_year_month,

        -- Customer attributes
        c.customer_name,
        c.city           as customer_city,
        c.customer_segment,

        -- Product attributes
        p.product_name,
        p.category       as product_category,

        -- Measures
        od.unit_price,
        od.quantity,
        od.line_revenue

    from order_details od
    left join customers c on od.customer_id = c.customer_id
    left join products  p on od.product_id  = p.product_id
)

select * from final
```