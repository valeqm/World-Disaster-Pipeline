{{
    config(
        materialized='table'
    )
}}

WITH stg_disaster AS (
    SELECT * FROM {{ ref('stg_disaster') }}
)

SELECT
    id_disaster,
    disaster_group,
    disaster_subgroup,
    disaster_type,
    disaster_subtype,
    event_name,
    iso_code,
    country,
    region AS continent,
    location,
    start_year,
    start_month,
    start_day,
    end_year,
    end_month,
    end_day,
    CASE 
        WHEN magnitude IS NOT NULL AND magnitude_scale IS NOT NULL THEN CONCAT(CAST(magnitude AS STRING), ' ', 
            CASE magnitude_scale 
                WHEN 'Kph' THEN 'Wind speed (Kph)'
                WHEN 'Moment Magnitude' THEN 'Moment Magnitude Scale'
                WHEN 'Km2' THEN 'Affected area (Km²)'
                WHEN '°C' THEN 'Temperature (°C)'
                WHEN 'Vaccinated' THEN 'Vaccinated people'
                WHEN 'm3' THEN 'Affected volume (m³)'
                ELSE magnitude_scale 
            END
        )
        ELSE NULL 
    END AS magnituted,
    CASE 
        WHEN magnitude_scale = 'Moment Magnitude' AND magnitude >= 8 THEN 'Extreme'
        WHEN magnitude_scale = 'Moment Magnitude' AND magnitude BETWEEN 6 AND 7.9 THEN 'Severe'
        WHEN magnitude_scale = 'Moment Magnitude' AND magnitude BETWEEN 4 AND 5.9 THEN 'Moderate'
        WHEN magnitude_scale = 'Kph' AND magnitude >= 250 THEN 'Category 5'
        WHEN magnitude_scale = 'Kph' AND magnitude BETWEEN 200 AND 249 THEN 'Category 4'
        WHEN magnitude_scale = 'Kph' AND magnitude BETWEEN 150 AND 199 THEN 'Category 3'
        WHEN magnitude_scale = 'Kph' AND magnitude BETWEEN 100 AND 149 THEN 'Category 2'
        WHEN magnitude_scale = 'Kph' AND magnitude < 100 THEN 'Category 1'
        ELSE 'Uncategorized'
    END AS magnitude_category

FROM stg_disaster;
