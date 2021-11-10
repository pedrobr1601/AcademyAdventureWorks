with
    source_data as (
        select
            productid	
            , products.name as product_name
            , productnumber
        from {{  source('adventureworks', 'production_product')  }} as products
    )

    select * 
    from source_data