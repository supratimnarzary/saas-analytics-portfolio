with orders as (

    select * from {{ ref('int_orders_enriched') }}

),

order_items as (

    select
        order_id,
        count(distinct order_item_id)           as total_items,
        sum(item_price)                         as total_items_price,
        sum(freight_price)                      as total_freight_price,
        sum(total_item_amount)                  as total_order_amount,
        count(distinct product_category)        as distinct_categories

    from {{ ref('int_order_items_enriched') }}
    group by order_id

),

final as (

    select
        o.order_id,
        o.customer_id,
        o.customer_unique_id,
        o.customer_state,
        o.order_status,
        o.ordered_at,
        o.approved_at,
        o.shipped_at,
        o.delivered_at,
        o.estimated_delivery_at,
        coalesce(o.total_payment_amount, 0)     as total_payment_amount,
        o.primary_payment_type,
        o.days_to_deliver,
        o.delivered_on_time,
        i.total_items,
        i.total_items_price,
        i.total_freight_price,
        i.distinct_categories

    from orders o
    left join order_items i on o.order_id = i.order_id

)

select * from final