```markdown
# dbt Sales Analytics Demo

End-to-end dbt project built on Snowflake Transformations.

## Stack
- **Warehouse:** Snowflake
- **Transformation:** dbt (via Snowflake Transformations)
- **Source Control:** GitHub

## Data Model
- **Staging:** stg_customers, stg_orders, stg_products, stg_order_items
- **Intermediate:** int_order_details, int_customer_sales
- **Marts:** dim_customer, dim_product, fact_sales

## Run Commands
```
dbt run                          # Run all models
dbt run --select staging         # Run only staging layer
dbt run --select marts           # Run only mart layer
dbt test                         # Run all tests
dbt docs generate && dbt docs serve   # View lineage
```
```