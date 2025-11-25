{{ config(materialized='view') }}

SELECT
    date,
    campaign_id,
    campaign_name,
    channel,
    impressions,
    clicks,
    cost,
    'meta' AS platform
FROM {{ source('raw', 'META_ADS') }}
