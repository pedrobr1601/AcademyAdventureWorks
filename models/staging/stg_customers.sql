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
  
    , final as (
        select 
        customer.customerid
        , customer.storeid
        , customer.territoryid
        , person.persontype
        , person.title
        , person.firstname
        , person.middlename
        , person.lastname
        , person.suffix
        , person.additionalcontactinfo
        , person.demographics
        from customer
        left join person on customer.personid = person.businessentityid
    )
select * 
from final
