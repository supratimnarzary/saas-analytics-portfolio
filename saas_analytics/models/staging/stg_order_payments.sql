with source as (

    select * from {{ source('raw', 'OLIST_ORDER_PAYMENTS_DATASET') }}

),

renamed as (

    select
        order_id,
        payment_sequential,
        lower(payment_type) as payment_type,
        payment_installments,
        payment_value as payment_amount

    from source

)

select * from renamed