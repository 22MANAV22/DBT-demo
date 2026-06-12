```sql
-- models/marts/dim_customer.sql
with customers as (
    select * from {{ ref('stg_customers') }}
),

customer_sales as (
    select * from {{ ref('int_customer_sales') }}
),

final as (
    select
        c.customer_id,
        c.customer_name,
        c.email,
        c.city,
        -- Sales metrics (null-safe for customers with no orders)
        coalesce(cs.total_orders, 0)             as total_orders,
        coalesce(cs.total_items_purchased, 0)    as total_items_purchased,
        coalesce(cs.total_revenue, 0)            as total_revenue,
        cs.first_order_date,
        cs.last_order_date,
        cs.customer_lifetime_days,
        -- Customer segment based on revenue
        case
            when coalesce(cs.total_revenue, 0) >= 500  then 'VIP'
            when coalesce(cs.total_revenue, 0) >= 200  then 'Regular'
            when coalesce(cs.total_revenue, 0) > 0     then 'Occasional'
            else 'Prospect'
        end as customer_segment
    from customers c
    left join customer_sales cs on c.customer_id = cs.customer_id
)

select * from final
```