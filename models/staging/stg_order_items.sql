```sql
-- models/staging/stg_order_items.sql
-- Note: we join to stg_products here just to pull unit_price for the revenue calc.
-- The canonical join happens in int_order_details.
with source as (
    select * from {{ source('raw', 'order_items') }}
)

select
    order_item_id,
    order_id,
    product_id,
    quantity,
    current_timestamp() as _loaded_at
from source
```