{{ config(materialized='table') }}

SELECT
    session_id,
    user_id,
    session_start_ts,
    session_date,
    LOWER(utm_source)   AS utm_source,
    LOWER(utm_medium)   AS utm_medium,
    utm_campaign
FROM {{ ref('stg_sessions') }}
