with source as (

    select * from {{ source('raw', 'OLIST_CUSTOMERS_DATASET') }}

),

renamed as (

    select
        customer_id,
        customer_unique_id,
        lower(customer_city)            as customer_city,
        lower(customer_state)           as customer_state,
        customer_zip_code_prefix        as zip_code

    from source

)

select * from renamed