{{ config(materialized='table') }}

with
    staging as (
        select *
        from {{  ref('stg_customers')}}
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
    , transformed as (
        select
        row_number() over (order by customer_id) as customer_sk --surrogate key auto incremental
        , customer_id
        , country
        , city
        , fax
        , postal_code
        , address
        , region
        , contact_name
        , phone
        , company_name
        , contact_title
        from staging
    )

    select * 
    from transformed