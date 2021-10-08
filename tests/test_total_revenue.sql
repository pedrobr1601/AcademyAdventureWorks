with
    sum_quantity as (
        SELECT
            sum(quantity) as cnt
        FROM {{ ref ('fact_orders') }}
        where order_date
        between '1998-03-01' and '1998-03-31'
    )

select * from sum_quantity where cnt != 4065