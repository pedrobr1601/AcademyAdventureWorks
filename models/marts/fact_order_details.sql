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
    , card as (
        select *
        from {{ref('dim_card')}}
    )
    , locali as (
        select *
        from {{ref('dim_local')}}
    )
    , datas as (
        select *
        from {{ref('dim_data')}}
    )
    , reason as (
        select *
        from {{ref('dim_reason')}}
    )
    , orders_with_sk as (
    select
    orders.salesorderid
    , customers.customer_sk as customer_fk
    , datas.data_sk as data_fk
    , locali.address_sk as local_fk
    , card.creditcard_sk as card_fk
    , orders.sales_status
    , orders.purchaseordernumber
    , orders.accountnumber
    , orders.salespersonid
    , orders.shipmethodid
    , orders.creditcardapprovalcode
    , orders.currencyrateid
    , orders.subtotal
    , orders.taxamt
    , orders.freight
    , orders.totaldue
    
    from {{ref('stg_orders')}} as orders
    left join customers on orders.customerid = customers.customerid
    left join datas on orders.salesorderid = datas.salesorderid
    left join locali on orders.billtoaddressid = locali.addressid
    left join card on orders.creditcardid = card.creditcardid
)
, order_detail_with_sk as (
    select
     order_detail.salesorderid
     , products.product_sk as product_fk
     , order_detail.unitprice
     , order_detail.orderqty
     , order_detail.unitpricediscount
     , order_detail.salesorderdetailid
    from {{ref('stg_order_detail')}} as order_detail
    left join products on order_detail.productid = products.productid
)
, final as (
    select
    order_detail_with_sk.salesorderid
    , orders_with_sk.customer_fk
    , orders_with_sk.data_fk
    , orders_with_sk.local_fk
    , orders_with_sk.card_fk     
    , orders_with_sk.sales_status
    , orders_with_sk.purchaseordernumber
    , orders_with_sk.accountnumber
    , orders_with_sk.salespersonid
    , orders_with_sk.shipmethodid
    , orders_with_sk.creditcardapprovalcode
    , orders_with_sk.currencyrateid
    , orders_with_sk.subtotal
    , orders_with_sk.taxamt
    , orders_with_sk.freight
    , orders_with_sk.totaldue
    , order_detail_with_sk.product_fk   
    , order_detail_with_sk.unitprice
    , order_detail_with_sk.orderqty
    , order_detail_with_sk.unitpricediscount
    , order_detail_with_sk.salesorderdetailid
    from orders_with_sk
    left join order_detail_with_sk on orders_with_sk.salesorderid = order_detail_with_sk.salesorderid
)
select *
from final