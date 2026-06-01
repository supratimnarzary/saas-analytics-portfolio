with orders as (

    select * from {{ ref('int_orders_enriched') }}

),

final as (

    select
        date_trunc('month', ordered_at)         as order_month,
        customer_state,
        primary_payment_type,
        count(distinct order_id)                as total_orders,
        count(distinct customer_unique_id)      as unique_customers,
        sum(total_payment_amount)               as total_revenue,
        avg(total_payment_amount)               as avg_order_value,
        avg(days_to_deliver)                    as avg_delivery_days,
        sum(case when delivered_on_time 
            then 1 else 0 end)                  as orders_on_time,
        count(distinct order_id) - 
        sum(case when delivered_on_time 
            then 1 else 0 end)                  as orders_late

    from orders
    where order_status = 'delivered'
    group by 1, 2, 3

)

select * from final