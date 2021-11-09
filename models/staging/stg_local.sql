with
    addressinfo as (
        select
            addressid
            , addressline1
            , addressline2
            , city 
            , stateprovinceid
            , postalcode
            , spatiallocation
        from {{  source('adventureworks', 'person_address')  }} 
    )
    , territory as (
        select
            territoryid
            , name
            , countryregioncode
            , group
        from {{  source('adventureworks', 'sales_salesterritory')  }}
        )
    , stateprovince as (
        select
            stateprovinceid
            , stateprovincecode
            , countryregioncode
            , isonlystateprovinceflag
            , name
            , territoryid
        from {{  source('adventureworks', 'person_stateprovince')  }}
    )
  

select * 
from addressinfo

select *
from territory

select *
from stateprovince