{{ config(materialized='table') }}

with
    staging as (
        select *
        from {{  ref('stg_status')}}
    )
    , transformed as (
        select
            row_number() over (order by salesorderid) as status_sk --surrogate key auto incremental
            , salesorderid
            , sales_status
        from staging
    )

    select * 
    from transformed