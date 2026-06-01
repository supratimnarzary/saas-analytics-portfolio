with source as (

    select * from {{ source('raw', 'OLIST_PRODUCTS_DATASET') }}

),

renamed as (

    select
        product_id,
        lower(product_category_name) as product_category,
        product_weight_g as weight_grams,
        product_length_cm as length_cm,
        product_height_cm as height_cm,
        product_width_cm as width_cm

    from source

)

select * from renamed