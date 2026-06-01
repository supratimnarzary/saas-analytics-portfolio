with customers as (

    select * from {{ ref('stg_customers') }}

),

orders as (

    select
        customer_id,
        min(ordered_at)                         as first_order_at,
        max(ordered_at)                         as most_recent_order_at,
        count(distinct order_id)                as total_orders,
        sum(total_payment_amount)               as lifetime_value,
        avg(total_payment_amount)               as avg_order_value

    from {{ ref('int_orders_enriched') }}
    where order_status = 'delivered'
    group by customer_id

),

final as (

    select
        c.customer_id,
        c.customer_unique_id,
        c.customer_city,
        c.customer_state,
        c.zip_code,
        o.first_order_at,
        o.most_recent_order_at,
        o.total_orders,
        o.lifetime_value,
        o.avg_order_value,

        -- customer segmentation
        case
            when o.total_orders >= 5  then 'vip'
            when o.total_orders >= 2  then 'repeat'
            when o.total_orders = 1   then 'one_time'
            else 'no_orders'
        end                                     as customer_segment,

        -- days since last order
        datediff('day', o.most_recent_order_at, current_timestamp) as days_since_last_order

    from customers c
    left join orders o on c.customer_id = o.customer_id

)

select * from final