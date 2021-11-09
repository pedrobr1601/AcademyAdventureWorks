{{ config(materialized='table') }}

with
    staging as (
        select *
        from {{  ref('stg_cards')}}
    )
    , transformed as (
        select
        row_number() over (order by creditcardid) as shipper_sk --surrogate key auto incremental
            , creditcardid
            , cardtype
            , cardnumber
            , expmonth
            , expyear
        from staging
    )

    select * 
    from transformed