{{ config(materialized='table') }}

with
    staging as (
        select *
        from {{  ref('stg_reason')}}
    )
    , transformed as (
        select
            row_number() over (order by salesorderid) as reason_sk --surrogate key auto incremental
            , salesorderid
            , salesreasonid 
            , reason
            , reasontype
        from staging
    )

    select * 
    from transformed