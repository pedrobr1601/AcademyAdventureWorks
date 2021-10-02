with
    staging as (
        select *
        from {{  ref('stg_customers')}}
    )
    , transformed as (
        select

        row_number() over (order by customer_id) as customer_sk --surrogate key auto incremental
        , customer_id
        , country
        , city
        , fax
        , postal_code
    )