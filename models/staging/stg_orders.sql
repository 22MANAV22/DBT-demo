```sql
-- models/staging/stg_orders.sql
with source as (
    select * from {{ source('raw', 'orders') }}
),

renamed as (
    select
        order_id,
        customer_id,
        order_date::date                   as order_date,
        year(order_date)                   as order_year,
        month(order_date)                  as order_month,
        to_char(order_date, 'YYYY-MM')     as order_year_month,
        current_timestamp()                as _loaded_at
    from source
)

select * from renamed
```