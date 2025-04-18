{{
    config(
        materialized='table'
    )
}}

WITH dim_disaster AS (
    SELECT * FROM {{ ref('dim_disaster') }}
),
fact_disaster AS (
    SELECT * FROM {{ ref('fact_disaster') }}
)

SELECT 
    d.id_disaster,
    d.* EXCEPT(id_disaster),
    f.* EXCEPT(id_disaster)
FROM dim_disaster d
LEFT JOIN fact_disaster f
ON d.id_disaster = f.id_disaster

