with 
    source_data as (
        select
            , orderdate
            , duedate
            , shipdate

        from {{  source('adventureworks', 'sales_salesorderheader')  }}
    )

    select * 
    from source_data