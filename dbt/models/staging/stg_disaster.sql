{{
    config(
        materialized='view'
    )
}}

with disaster_data as 
(
SELECT *
FROM {{ source('staging', 'partitioned_cluster_disaster_data') }}
)
SELECT 
    id_disaster,
    Disaster_Group AS disaster_group,
    Disaster_Subgroup AS disaster_subgroup,
    Disaster_Type AS disaster_type,
    Disaster_Subtype AS disaster_subtype,
    COALESCE(Event_Name, 'No Event Name') AS event_name,
    ISO AS iso_code,
    Country AS country,
    Región AS region,
    COALESCE(Location, 'Location Not Specified') AS location,
    
    -- Date Info
    Start_Year AS start_year,
    COALESCE(Start_Month, 'Month Not Specified') AS start_month,
    COALESCE(Start_Day, 'Day Not Specified') AS start_day,
    COALESCE(End_Year, 'Year Not Specified') AS end_year,
    COALESCE(End_Month, 'Month Not Specified') AS end_month,
    COALESCE(End_Day, 'Day Not Specified') AS end_day,
    
    -- Affected Info
    CAST(NULLIF(Total_Deaths, '') AS INT) AS total_deaths,
    CAST(NULLIF(No__Injured, '') AS INT) AS no_injured,
    CAST(NULLIF(No__Affected, '') AS INT) AS no_affected,
    CAST(NULLIF(No__Homeless, '') AS INT) AS no_homeless,
    CAST(NULLIF(Total_Affected, '') AS INT) AS total_affected,

    -- Financial Values Info
    ROUND(CAST(NULLIF(total_damage_usd, '') AS NUMERIC), 2) AS total_damage_usd,
    ROUND(CAST(NULLIF(total_damage_adjusted_usd, '') AS NUMERIC), 2) AS total_damage_adjusted_usd,
    ROUND(CAST(NULLIF(insured_damage_usd, '') AS NUMERIC), 2) AS insured_damage_usd,
    ROUND(CAST(NULLIF(insured_damage_adjusted_usd, '') AS NUMERIC), 2) AS insured_damage_adjusted_usd,
    ROUND(CAST(NULLIF(reconstruction_costs_usd, '') AS NUMERIC), 2) AS reconstruction_costs_usd,
    ROUND(CAST(NULLIF(reconstruction_costs_adjusted_usd, '') AS NUMERIC), 2) AS reconstruction_costs_adjusted_usd,
    ROUND(CAST(NULLIF(aid_contribution_usd, '') AS NUMERIC), 2) AS aid_contribution_usd,

    -- Magnitude Info
    ROUND(CAST(NULLIF(Magnitude, '') AS NUMERIC), 2) AS magnitude,
    Magnitude_Scale AS magnitude_scale


FROM disaster_data



