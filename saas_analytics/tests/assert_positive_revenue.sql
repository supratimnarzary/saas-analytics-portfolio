-- This test fails if any order has a negative payment amount
-- Zero values are allowed as they represent valid voucher orders
select
    order_id,
    total_payment_amount
from {{ ref('fact_orders') }}
where total_payment_amount < 0