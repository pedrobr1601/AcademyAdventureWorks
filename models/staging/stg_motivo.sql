with
    source_data as (
        select
            salesreasonid
            , name	
            , reasontype
         from {{  source('adventureworks', 'sales_salesreason')  }}
    )
    , reasonheader as (
        select
          salesorderid
          , salesreasonid  
        from {{  source('adventureworks', 'sales_salesorderheadersalesreason')  }}
    )

    select * 
    from source_data

    select *
    from reasonheader 