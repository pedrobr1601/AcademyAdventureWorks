with
    source_data as (
        select
            productid	
            , name
            , productnumber
        from {{  source('adventureworks', 'production_product')  }}
    )

    select * 
    from source_data