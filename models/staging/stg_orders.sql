with 
    source_data as (
        select
            salesorderid
            , revisionnumber
            , onlineorderflag
            , purchaseordernumber
            , accountnumber
            , orders.status as sales_status
            , customerid
            , salespersonid
            , territoryid
            , billtoaddressid
            , shiptoaddressid
            , shipmethodid
            , creditcardid
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