{{ config(materialized='table') }}

with
    staging as (
        select *
        from {{  ref('stg_bridge_reason_order')}}
    )
    select * 
    from staging