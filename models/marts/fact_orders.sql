{{ config(materialized='table') }}

with
    customers as (
        select *
        from {{ref('dim_customers')}}
    )

    , products as (
        select *
        from {{ref('dim_products')}}
    )
     , shippers as (
        select *
        from {{ref('dim_shippers')}}
    )
     , suppliers as (
        select *
        from {{ref('dim_suppliers')}}
    )
    , orders_with_sk as (
    select
    orders.order_id
    , customers.customer_id as customer_fk
    , shippers.shipper_sk as shipper_fk
    , orders.order_date
    , orders.ship_region
    , orders.shipped_date
    , orders.ship_country
    , orders.ship_address
    , orders.ship_postal_code
    , orders.ship_city
    , orders.ship_name
    , orders.freight
    , orders.required_date
    
    from {{ref('stg_orders')}} as orders
    left join customers on orders.customer_id = customers.customer_id
    left join shippers on orders.shipper_id = shippers.shipper_id
)
, order_detail_with_sk as (
    select
     order_id
     , products.product_sk as product_fk
     , order_detail.unit_price
     , order_detail.quantity
     , order_detail.discount
    from {{ref('stg_order_detail')}} as order_detail
    left join products on order_detail.product_id = products.product_id
)
, final as (
    select
    order_detail_with_sk.order_id
    , orders_with_sk.customer_fk
    , orders_with_sk.shipper_fk     
    , orders_with_sk.order_date
    , orders_with_sk.ship_region
    , orders_with_sk.shipped_date
    , orders_with_sk.ship_country
    , orders_with_sk.ship_address
    , orders_with_sk.ship_postal_code
    , orders_with_sk.ship_city
    , orders_with_sk.ship_name
    , orders_with_sk.freight
    , orders_with_sk.required_date
    , order_detail_with_sk.product_fk   
    , order_detail_with_sk.unit_price
    , order_detail_with_sk.quantity
    , order_detail_with_sk.discount
    from orders_with_sk
    left join order_detail_with_sk on orders_with_sk.order_id = order_detail_with_sk.order_id
)
select *
from final