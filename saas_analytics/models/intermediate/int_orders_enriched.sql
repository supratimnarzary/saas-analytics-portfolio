with orders as (

    select * from {{ ref('stg_orders') }}

),

customers as (

    select * from {{ ref('stg_customers') }}

),

payments as (

    select
        order_id,
        sum(payment_amount)             as total_payment_amount,
        count(*)                        as payment_installments_count,
        max(payment_type)               as primary_payment_type

    from {{ ref('stg_order_payments') }}
    where payment_amount > 0   
    group by order_id

),

final as (

    select
        o.order_id,
        o.customer_id,
        o.order_status,
        o.ordered_at,
        o.approved_at,
        o.shipped_at,
        o.delivered_at,
        o.estimated_delivery_at,
        c.customer_unique_id,
        c.customer_city,
        c.customer_state,
        p.total_payment_amount,
        p.payment_installments_count,
        p.primary_payment_type,

        -- derived fields
        datediff('day', o.ordered_at, o.delivered_at)           as days_to_deliver,
        datediff('day', o.ordered_at, o.estimated_delivery_at)  as estimated_delivery_days,
        case
            when o.delivered_at <= o.estimated_delivery_at then true
            else false
        end  as delivered_on_time

    from orders o
    left join customers c on o.customer_id = c.customer_id
    left join payments p  on o.order_id = p.order_id

)

select * from final