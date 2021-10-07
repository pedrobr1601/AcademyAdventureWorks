{{ config(materialized='table') }}

with
    customers as (
        select
        customer_sk
        , customer_id
        from {{ref('dim_customers')}}
    )
, orders_with_sk as (
    select
    public_orders.order_id
    , customers.customer_id
    , public_orders.order_date
    , public_orders.ship_region
    , public_orders.shipped_date
    , public_orders.ship_country
    , public_orders.ship_address
    , public_orders.ship_postal_code
    , public_orders.ship_city as cidade
    , public_orders.ship_name
    , public_orders.freight
    , public_orders.required_date
    
    from {{ref('stg_orders')}} public_orders
    left join customers customers on public_orders.customer_id = customers.customer_id
)
select *
from orders_with_sk