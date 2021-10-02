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
    orders.order_id
    from {{ref('stg_orders')}} orders
    left
)