with source as (

    select * from {{ source('raw', 'OLIST_ORDER_ITEMS_DATASET') }}

),

renamed as (

    select
        order_id,
        order_item_id,
        product_id,
        seller_id,
        cast(shipping_limit_date as timestamp) as shipping_limit_at,
        price as item_price,
        freight_value as freight_price

    from source

)

select * from renamed