with source_data as(
    select * from {{ source('raw_supply_chain', 'raw_supply_orders') }}
),
renamed as(
    select 
    cast(PO_ID as string) as po_id,
    trim(Supplier) as supplier,
    trim(Item_Category) as item_category,
    cast(Order_Date as date) as order_date,
    cast(Delivery_Date as date) as delivery_date,
    trim(Order_Status) as order_status,
    cast(Quantity as int64) as quantity,
    cast(Unit_Price as float64) as unit_price,
    cast(Negotiated_Price as float64) as negotiated_price,
    cast(Defective_Units as int64) as defective_units,
    cast(Compliance as boolean) as compliance
    from source_data
)

select * from renamed