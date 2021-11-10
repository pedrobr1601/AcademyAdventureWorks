with
    source_data as (
        select
            salesreasonid
            , salesreason.name as reason	
            , reasontype
         from {{  source('adventureworks', 'sales_salesreason')  }} as salesreason
    )
    , reasonheader as (
        select
          salesorderid
          , salesreasonid  
        from {{  source('adventureworks', 'sales_salesorderheadersalesreason')  }}
    )
    , final as (
        select
            reasonheader.salesorderid
            , reasonheader.salesreasonid 
            , source_data.reason
            , source_data.reasontype
        from reasonheader
        left join source_data on reasonheader.salesreasonid = source_data.salesreasonid
    )

    select *
    from final
  