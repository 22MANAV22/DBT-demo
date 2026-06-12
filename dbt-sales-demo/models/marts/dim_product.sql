```sql
-- models/marts/dim_product.sql
with products as (
    select * from {{ ref('stg_products') }}
),

order_details as (
    select * from {{ ref('int_order_details') }}
),

product_sales as (
    select
        product_id,
        count(distinct order_id) as times_ordered,
        sum(quantity)            as total_units_sold,
        sum(line_revenue)        as total_product_revenue
    from order_details
    group by product_id
),

final as (
    select
        p.product_id,
        p.product_name,
        p.category,
        p.unit_price,
        coalesce(ps.times_ordered, 0)         as times_ordered,
        coalesce(ps.total_units_sold, 0)      as total_units_sold,
        coalesce(ps.total_product_revenue, 0) as total_product_revenue
    from products p
    left join product_sales ps on p.product_id = ps.product_id
)

select * from final
```
