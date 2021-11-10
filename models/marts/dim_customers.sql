{{ config(materialized='table') }}

with
    staging as (
        select *
        from {{  ref('stg_customers')}}
    )
    , transformed as (
        select
        row_number() over (order by customerid) as customer_sk --surrogate key auto incremental
        , customerid
        , storeid
        , territoryid
        , persontype
        , title
        , firstname
        , middlename
        , lastname
        , suffix
        , additionalcontactinfo
        , demographics
        from staging
    )

    select * 
    from transformed