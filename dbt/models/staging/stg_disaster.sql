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
    Region AS region,
    COALESCE(Location, 'Location Not Specified') AS location,
    
    -- Date Info
    Start_Year AS start_year,
    Start_Month AS start_month,
    Start_Day AS start_day,
    End_Year AS end_year,
    End_Month AS end_month,
    End_Day AS end_day,

    -- Affected Info
    CAST(Total_Deaths AS INT) AS total_deaths,
    CAST(No__Injured AS INT) AS no_injured,
    CAST(No__Affected AS INT) AS no_affected,
    CAST(No__Homeless AS INT) AS no_homeless,
    CAST(Total_Affected AS INT) AS total_affected,

    -- Financial Values Info
    ROUND(CAST(total_damage_usd AS NUMERIC), 2) AS total_damage_usd,
    ROUND(CAST(total_damage_adjusted_usd AS NUMERIC), 2) AS total_damage_adjusted_usd,
    ROUND(CAST(insured_damage_usd AS NUMERIC), 2) AS insured_damage_usd,
    ROUND(CAST(insured_damage_adjusted_usd AS NUMERIC), 2) AS insured_damage_adjusted_usd,
    ROUND(CAST(reconstruction_costs_usd AS NUMERIC), 2) AS reconstruction_costs_usd,
    ROUND(CAST(reconstruction_costs_adjusted_usd AS NUMERIC), 2) AS reconstruction_costs_adjusted_usd,
    ROUND(CAST(aid_contribution_usd AS NUMERIC), 2) AS aid_contribution_usd,

    -- Magnitude Info
    ROUND(CAST(Magnitude AS NUMERIC), 2) AS no_magnitude,
    Magnitude_Scale AS magnitude_scale


FROM disaster_data



