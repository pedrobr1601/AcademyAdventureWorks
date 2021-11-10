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
            , sales_salesterritory.name as country_name  
            , countryregioncode
            , sales_salesterritory.group as grupo 
        from {{  source('adventureworks', 'sales_salesterritory')  }} as sales_salesterritory
        )
    , stateprovince as (
        select
            stateprovinceid
            , stateprovincecode
            , countryregioncode
            , isonlystateprovinceflag
            , personstateprovince.name as state_name
            , territoryid
        from {{  source('adventureworks', 'person_stateprovince')  }} as personstateprovince
    )
    , addressWS as (
        select
            stateprovince.territoryid
            , stateprovince.stateprovinceid
            , stateprovince.state_name
            , stateprovince.stateprovincecode
            , addressinfo.addressid
            , addressinfo.addressline1
            , addressinfo.addressline2
            , addressinfo.city
            , addressinfo.postalcode
            , addressinfo.spatiallocation
        from addressinfo
       left join stateprovince on addressinfo.stateprovinceid = stateprovince.stateprovinceid
    )
    , final as (
        select
            territory.country_name
            , territory.countryregioncode
            , territory.grupo
            , addressWS.territoryid
            , addressWS.stateprovincecode
            , addressWS.state_name
            , addressWS.addressid
            , addressWS.addressline1
            , addressWS.addressline2
            , addressWS.city
            , addressWS.postalcode
            , addressWS.spatiallocation
        from addressWS
        left join territory on addressWS.territoryid = territory.territoryid
    )

    select *
    from final 