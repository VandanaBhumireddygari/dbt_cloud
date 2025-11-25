{{ config(materialized='view') }}

SELECT
    date,
    campaign_id,
    campaign_name,
    channel,
    impressions,
    clicks,
    cost,
    'google' AS platform
FROM {{ source('raw', 'GOOGLE_ADS') }}
