{{ config(materialized='table') }}

with
    staging as (
        select *
        from {{  ref('stg_reason')}}
    )
    select * 
    from staging