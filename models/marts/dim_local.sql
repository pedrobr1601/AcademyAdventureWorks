{{ config(materialized='table') }}

with
    staging as (
        select *
        from {{  ref('stg_local')}}
    )
    , transformed as (
        select
            row_number() over (order by addressid) as address_sk --surrogate key auto incremental
            , country_name
            , countryregioncode
            , grupo
            , territoryid
            , stateprovincecode
            , state_name
            , addressid
            , addressline1
            , addressline2
            , city
            , postalcode
            , spatiallocation
        from staging
    )

    select * 
    from transformed