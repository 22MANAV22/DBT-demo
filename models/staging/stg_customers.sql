
with source as (
    select * from {{ source('raw', 'customers') }}
),

renamed as (
    select
        customer_id,
        customer_name,
        lower(email)   as email,          -- normalize to lowercase
        initcap(city)  as city,           -- normalize capitalization
        current_timestamp() as _loaded_at -- audit column
    from source
)

select * from renamed
