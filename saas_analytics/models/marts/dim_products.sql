with products as (

    select * from {{ ref('stg_products') }}

),

order_items as (

    select
        product_id,
        count(distinct order_id)                as times_ordered,
        sum(item_price)                         as total_revenue,
        avg(item_price)                         as avg_selling_price,
        avg(freight_price)                      as avg_freight_price

    from {{ ref('int_order_items_enriched') }}
    group by product_id

),

final as (

    select
        p.product_id,
        p.product_category,
        p.weight_grams,
        p.length_cm,
        p.height_cm,
        p.width_cm,
        coalesce(oi.times_ordered, 0)           as times_ordered,
        coalesce(oi.total_revenue, 0)           as total_revenue,
        coalesce(oi.avg_selling_price, 0)       as avg_selling_price,
        coalesce(oi.avg_freight_price, 0)       as avg_freight_price

    from products p
    left join order_items oi on p.product_id = oi.product_id

)

select * from final