with 
    source_data as (
        select
            salesorderid
            , revisionnumber
            , onlineorderflag
            , purchaseordernumber
            , accountnumber
            , customerid
            , salespersonid
            , territoryid
            , billtoaddressid
            , shiptoaddressid
            , shipmethodid
            , creditcardid
            , orders.status as sales_status
            , creditcardapprovalcode
            , currencyrateid
            , subtotal
            , taxamt
            , freight
            , totaldue
        from {{  source('adventureworks', 'sales_salesorderheader')  }} as orders
    )

    select * 
    from source_data