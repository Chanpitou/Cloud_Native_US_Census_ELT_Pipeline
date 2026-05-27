with cleaned_data as (
    select 
        *,
        year(loaded_at) as date_key
    from {{ ref('int_cleaned_census') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['state_code', 'county_code', 'date_key']) }} as fact_key,
    
    -- Foreign Keys to join back to dimension tables
    {{ dbt_utils.generate_surrogate_key(['state_code', 'county_code']) }} as location_key,
    date_key,
    
    total_population,
    median_income as median_household_income,
    median_home_value,
    median_rent as median_gross_rent,
    
    -- Calculated Economic & Social Metrics
    case 
        when total_population > 0 then round((bachelors_degree / total_population) * 100, 2)
        else 0 
    end as bachelors_degree_rate,
    
    case 
        when total_population > 0 then round((below_poverty / total_population) * 100, 2)
        else 0 
    end as poverty_rate,
    
    case 
        when total_population > 0 then round((high_school_grad / total_population) * 100, 2)
        else 0 
    end as high_school_grad_rate

from cleaned_data