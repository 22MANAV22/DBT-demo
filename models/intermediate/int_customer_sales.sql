
with order_details as (
    select * from {{ ref('int_order_details') }}
),

customer_aggregates as (
    select
        customer_id,
        count(distinct order_id)       as total_orders,
        sum(quantity)                  as total_items_purchased,
        sum(line_revenue)              as total_revenue,
        avg(line_revenue)              as avg_line_revenue,
        min(order_date)                as first_order_date,
        max(order_date)                as last_order_date,
        datediff(
            'day',
            min(order_date),
            max(order_date)
        )                              as customer_lifetime_days
    from order_details
    group by customer_id
)

select * from customer_aggregates



