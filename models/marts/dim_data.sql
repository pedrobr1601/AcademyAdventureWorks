{{ config(materialized='table') }}

with
    staging as (
        select *
        from {{  ref('stg_data')}}
    )
    , transformed as (
        select
            row_number() over (order by salesorderid) as data_sk --surrogate key auto incremental
            , salesorderid
            , orderdate
            , duedate
            , shipdate
        from staging
    )

    select * 
    from transformed