```sql
-- models/staging/stg_products.sql
with source as (
    select * from {{ source('raw', 'products') }}
),

renamed as (
    select
        product_id,
        product_name,
        initcap(category) as category,
        price::float      as unit_price,   -- explicit cast for arithmetic clarity
        current_timestamp() as _loaded_at
    from source
)

select * from renamed
```