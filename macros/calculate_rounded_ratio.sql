{% macro calculate_rounded_ratio(metric, population) %}
    ( ROUND(({{ metric }} / {{ population }}) * 100, 2) )
{% endmacro %}