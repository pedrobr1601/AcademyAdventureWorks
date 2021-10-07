{{ config(materialized='table') }}

with
    staging as (
        select *
        from {{  ref('stg_suppliers')}}
    )
    , transformed as (
        select
        row_number() over (order by supplier_id) as supplier_sk --surrogate key auto incremental
            , supplier_id
            , company_name	
            , contact_name
            , contact_title	
            , address
            , city	
            , region
            , postal_code		
            , country		
            , phone	
            , fax	
            , homepage	
        from staging
    )

    select * 
    from transformed