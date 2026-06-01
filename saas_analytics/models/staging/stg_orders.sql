with source as (

    select * from {{ source('raw', 'OLIST_ORDERS_DATASET') }}

),

renamed as (

    select
        -- ids
        order_id,
        customer_id,

        -- order status
        lower(order_status) as order_status,

        -- timestamps
        cast(order_purchase_timestamp as timestamp) as ordered_at,
        cast(order_approved_at as timestamp) as approved_at,
        cast(order_delivered_carrier_date as timestamp) as shipped_at,
        cast(order_delivered_customer_date as timestamp) as delivered_at,
        cast(order_estimated_delivery_date as timestamp) as estimated_delivery_at

    from source

)

select * from renamed