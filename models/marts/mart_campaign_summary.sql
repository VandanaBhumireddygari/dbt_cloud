{{ config(materialized='table') }}

SELECT
    platform,
    channel,
    campaign_name,
    MIN(date)                      AS first_date,
    MAX(date)                      AS last_date,
    SUM(impressions)               AS impressions,
    SUM(clicks)                    AS clicks,
    SUM(cost)                      AS cost,
    SUM(orders)                    AS orders,
    SUM(revenue)                   AS revenue,
    CASE WHEN SUM(clicks) = 0 THEN 0
         ELSE SUM(orders) * 1.0 / SUM(clicks)
    END                             AS conv_rate,
    CASE WHEN SUM(cost) = 0 THEN 0
         ELSE SUM(revenue) / SUM(cost)
    END                             AS roas
FROM {{ ref('mart_channel_daily_metrics') }}
GROUP BY 1,2,3
