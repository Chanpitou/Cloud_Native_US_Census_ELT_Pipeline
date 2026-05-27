with 

source as (

    select * from {{ source('raw_source', 'raw_census') }}

),

renamed as (

    select
        county_name,
        total_population,
        median_income,
        bachelors_degree,
        below_poverty,
        median_home_value,
        median_rent,
        high_school_grad,
        state_code,
        county_code,
        loaded_at

    from source

)

select * from renamed