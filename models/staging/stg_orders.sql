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
            , creditcardapprovalcode
            , currencyrateid
            , subtotal
            , taxamt
            , freight
            , totaldue
        from {{  source('adventureworks', 'sales_salesorderheader')  }}
    )

    select * 
    from source_data