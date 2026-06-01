with source as (

    select * from {{ source('raw', 'OLIST_SELLERS_DATASET') }}

),

renamed as (

    select
        seller_id,
        lower(seller_city) as seller_city,
        lower(seller_state) as seller_state,
        seller_zip_code_prefix as zip_code

    from source

)

select * from renamed