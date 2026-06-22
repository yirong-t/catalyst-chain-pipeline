{% macro calculate_percentage_leak(actual_value, baseline_value) %}

round(
    safe_divide(
        ({{actual_value}} - {{baseline_value}}),
        {{baseline_value}}
    ) * 100,
    2
)

{% endmacro %}