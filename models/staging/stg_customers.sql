with
    source_data as (
        select
            country
            , city
            , fax
            , postal_code
            , address
            , region
            , customer_id
            , contact_name
            , phone
            , company_name
            , contact_title
        from {{  source('erpnorthwind', 'public_customers')  }} 
)

select * 
from source_data