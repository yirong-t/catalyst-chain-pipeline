with source_data as(
    select *  from {{ source('raw_supply_chain', 'raw_stock_prices') }}
),

renamed as(
    select
    cast(date as date) as trading_date,
    upper(ticker) as ticker,
    cast(open as float64) as open_price,
    cast(high as float64) as high_price,
    cast(low as float64) as low_price,
    cast(close as float64) as close_price,  
    cast(adj_close as float64) as adj_close_price,
    cast(volume as int) as trading_volume
    from source_data
)

select * from renamed