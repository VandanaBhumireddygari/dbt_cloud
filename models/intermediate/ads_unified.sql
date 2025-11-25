{{ config(materialized='table') }}

WITH base AS (
    SELECT * FROM {{ ref('stg_google_ads') }}
    UNION ALL
    SELECT * FROM {{ ref('stg_meta_ads') }}
)

SELECT
    date,
    platform,
    channel,
    campaign_id,
    campaign_name,
    SUM(impressions) AS impressions,
    SUM(clicks)      AS clicks,
    SUM(cost)        AS cost
FROM base
GROUP BY 1,2,3,4,5
