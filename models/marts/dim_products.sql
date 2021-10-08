{{ config(materialized='table') }}

with
    staging as (
        select *
        from {{  ref('stg_products')}}
    )
    , transformed as (
        select
        row_number() over (order by product_id) as product_sk --surrogate key auto incremental
            , product_id		
            , supplier_id
            , category_id
            , product_name
            , quantity_per_unit
            , unit_price
            , units_in_stock	
            , units_on_order	
            , reorder_level	
            , is_discontinued
        from staging
    )

    select * 
    from transformed