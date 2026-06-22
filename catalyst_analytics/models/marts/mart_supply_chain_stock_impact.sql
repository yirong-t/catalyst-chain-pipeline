with orders as(
    select * from {{ ref('stg_supply_orders') }}
),

stock as(
    select * from {{ ref('stg_stock_prices') }}
),

supplier_mapping as (

    select * from {{ ref('dim_supplier_tickers') }}
),

enriched_orders as (
    select
        to_hex(md5(concat(coalesce(o.po_id, ''), '_', coalesce(m.impact_ticker, '')))) as correlation_surrogate_key,
        o.po_id,
        o.supplier,
        m.impact_ticker,
        m.relationship_type,
        m.dependency_score,
        o.item_category,
        o.order_status,
        o.order_date,
        o.delivery_date,
        
        -- Business Metric 1: Calculate lead time duration in days
        date_diff(o.delivery_date, o.order_date, day ) as actual_lead_time_days

        -- Business Metric 2: Financial leakage (how much over negotiated price did we pay)
        ,(o.unit_price - o.negotiated_price) * o.quantity as procurement_cost_leakage

        -- custom macro for procurement inflation rate
        , {{ calculate_percentage_leak('o.unit_price', 'o.negotiated_price') }} as price_inflation_rate
        -- Business Metric 3: Defect rate to capture supplier quality shocks
        ,safe_divide(o.defective_units, o.quantity) as defect_rate

    from orders o
    left join supplier_mapping m on o.supplier = m.supplier
),
 -- Merge enriched supply chain shocks with downstream stock market performance
 final_mart as (

    select 
        eo.*,
        s.open_price,
        s.high_price,
        s.low_price,
        s.close_price,
        s.trading_volume

    from enriched_orders eo
    left join stock s on eo.impact_ticker = s.ticker
    and eo.delivery_date = s.trading_date

 )

 select * from final_mart