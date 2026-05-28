with ingestion_year_cte as (
    select distinct
        year(loaded_at) as ingestion_year
    from {{ ref('int_cleaned_census') }}
)

select
    ingestion_year as date_key,
    'ACS 5-Year' as census_release_cycle,
    ((ingestion_year - 6)|| ' - ' || (ingestion_year - 2)) as census_period_label
from ingestion_year_cte