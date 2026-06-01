with monthly_orders as (

    select * from {{ ref('int_monthly_orders') }}

),

final as (

    select
        order_month,
        customer_state,
        primary_payment_type,
        total_orders,
        unique_customers,
        coalesce(total_revenue, 0)  as total_revenue,
        avg_order_value,
        avg_delivery_days,
        orders_on_time,
        orders_late,

        -- revenue growth month over month
        total_revenue - lag(total_revenue) over (
            partition by customer_state
            order by order_month
        )                                       as revenue_growth,

        -- month over month growth rate
        round(
            (total_revenue - lag(total_revenue) over (
                partition by customer_state
                order by order_month
            )) / nullif(lag(total_revenue) over (
                partition by customer_state
                order by order_month
            ), 0) * 100
        , 2)                                    as revenue_growth_pct

    from monthly_orders

)

select * from final