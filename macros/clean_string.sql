{% macro clean_string(col) -%}
    LOWER(TRIM({{ col }}))
{%- endmacro %}
