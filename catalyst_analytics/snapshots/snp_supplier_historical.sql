{% snapshot snp_supplier_historical %}

{{
    config(
        target_database='catalyst-chain-project',
        target_schema='dbt_analytics',

        strategy='check',
        unique_key='supplier',
        check_cols=['dependency_score', 'relationship_type']
    )
}}

select * from  {{ ref('dim_supplier_tickers') }}

{% endsnapshot %}