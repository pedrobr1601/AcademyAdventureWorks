with 
    source_data as (
        select
            salesorderid
            , orderstatus.status as sales_status
        from {{  source('adventureworks', 'sales_salesorderheader')  }} as orderstatus
    )

    select * 
    from source_data