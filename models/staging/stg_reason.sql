with
    source_data as (
        select
            salesreasonid
            , salesreason.name as reason	
            , reasontype
         from {{  source('adventureworks', 'sales_salesreason')  }} as salesreason
    )
    select *
    from source_data