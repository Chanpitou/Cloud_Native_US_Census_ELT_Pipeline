with staging as (
    select distinct
        state_code,
        county_code,
        county_name,
        state_name
    from {{ ref('int_cleaned_census') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['state_code', 'county_code']) }} as location_key,
    state_code,
    county_code,
    county_name,
    state_name,
    (state_code || county_code) as geo_id
from staging