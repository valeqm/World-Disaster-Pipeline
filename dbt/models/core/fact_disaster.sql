{{
    config(
        materialized='table'
    )
}}

WITH stg_disaster AS (
    SELECT * FROM {{ ref('stg_disaster') }}
)

SELECT
SELECT
    id_disaster,
    total_deaths,
    no_injured,
    no_affected,
    no_homeless,
    total_affected,
    total_damage_usd,
    insured_damage_usd,
    reconstruction_costs_usd,
    aid_contribution_usd,

    -- Disaster severity 
    CASE  
        WHEN total_deaths IS NULL AND total_affected IS NULL  
        THEN 'Unknown'  
        WHEN total_deaths > 1000 OR total_affected > 100000  
        THEN 'High'  
        WHEN total_deaths > 100 OR total_affected > 10000  
        THEN 'Medium'  
        ELSE 'Low'  
    END AS disaster_severity,

    -- % of insured damage relative to total damage  
    CASE 
        WHEN total_damage_usd IS NULL OR total_damage_usd = 0 
        THEN NULL
        ELSE (insured_damage_usd / total_damage_usd) * 100
    END AS insured_damage_percentage,

    -- % of reconstruction covered by financial aid  
    CASE 
        WHEN reconstruction_costs_usd IS NULL OR reconstruction_costs_usd = 0 
        THEN NULL
        ELSE (aid_contribution_usd / reconstruction_costs_usd) * 100
    END AS aid_contribution_percentage,

    -- Mortality ratio: number of deaths per 1,000 affected people  
    CASE 
        WHEN total_affected IS NULL OR total_affected = 0 
        THEN NULL
        ELSE (total_deaths / total_affected) * 1000
    END AS mortality_ratio

    -- Estimated inflation percentage for total damage  
    CASE  
        WHEN total_damage_usd IS NULL OR total_damage_usd = 0 OR total_damage_adjusted_usd IS NULL  
        THEN NULL  
        ELSE ((total_damage_adjusted_usd / total_damage_usd) - 1) * 100  
    END AS total_damage_inflation_percentage,

    -- Estimated inflation percentage for insured damage  
    CASE  
        WHEN insured_damage_usd IS NULL OR insured_damage_usd = 0 OR insured_damage_adjusted_usd IS NULL  
        THEN NULL  
        ELSE ((insured_damage_adjusted_usd / insured_damage_usd) - 1) * 100  
    END AS insured_damage_inflation_percentage,

    -- Estimated inflation percentage for reconstruction costs  
    CASE  
        WHEN reconstruction_costs_usd IS NULL OR reconstruction_costs_usd = 0 OR reconstruction_costs_adjusted_usd IS NULL  
        THEN NULL  
        ELSE ((reconstruction_costs_adjusted_usd / reconstruction_costs_usd) - 1) * 100  
    END AS reconstruction_costs_inflation_percentage,


FROM stg_disaster;
