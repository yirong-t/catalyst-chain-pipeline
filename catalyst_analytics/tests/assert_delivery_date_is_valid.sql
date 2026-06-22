-- This test queries for corrupted rows where the delivery happened BEFORE the ordering.
-- A successful dbt test run must return ZERO rows.

select
    po_id,
    order_date,
    delivery_date
from {{ ref('stg_supply_orders') }}
where delivery_date < order_date
  and delivery_date is not null 