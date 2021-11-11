with
    sum_quantity as (
        SELECT
            sum(orderqty) as cnt
        FROM {{ ref ('fact_orders') }}
        where salesorderid
        between 50000 and 60000
    )

select * from sum_quantity where cnt != 106460