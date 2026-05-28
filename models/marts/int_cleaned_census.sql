with raw_census as(
    select * from {{ ref('stg_raw_census') }}
),

cleaned_census as(
    select 
        trim(split_part(county_name, ',', 1)) AS county_name,
        trim(split_part(county_name, ',', 2)) AS state_name,
        case when total_population < 0 then null else total_population end as total_population,
        case when median_income < 0 then null else median_income end as median_income,
        case when bachelors_degree < 0 then null else bachelors_degree end as bachelors_degree,
        case when below_poverty < 0 then null else below_poverty end as below_poverty,
        case when median_home_value < 0 then null else median_home_value end as median_home_value,
        case when median_rent < 0 then null else median_rent end as median_rent,
        case when high_school_grad < 0 then null else high_school_grad end as high_school_grad,
        state_code,
        county_code,
        loaded_at
    from raw_census
)

select 
    *
from cleaned_census