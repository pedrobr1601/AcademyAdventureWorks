with
    reasonheader as (
        select
          salesorderid
          , salesreasonid  
        from {{  source('adventureworks', 'sales_salesorderheadersalesreason')  }}
    )

select *
from reasonheader
