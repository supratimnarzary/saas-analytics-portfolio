-- This test fails if delivered_at is before ordered_at
select
    order_id,
    ordered_at,
    delivered_at
from {{ ref('fact_orders') }}
where delivered_at < ordered_at
and delivered_at is not null