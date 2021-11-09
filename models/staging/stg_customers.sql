with
    customer as (
        select
            customerid
            , personid
            , storeid
            , territoryid
        from {{  source('adventureworks', 'sales_customer')  }} 
    )
    , person as (
        select
            businessentityid
            , persontype
            , title
            , firstname
            , middlename
            , lastname
            , suffix
            , additionalcontactinfo
            , demographics
        from {{  source('adventureworks', 'person_person')  }}
        )
  

select * 
from customer

select *
from person