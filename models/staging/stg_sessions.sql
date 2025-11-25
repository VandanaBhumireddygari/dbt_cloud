{{ config(materialized='view') }}

SELECT
    session_id,
    user_id,
    TO_TIMESTAMP_NTZ(session_start_ts) AS session_start_ts,
    DATE(TO_TIMESTAMP_NTZ(session_start_ts)) AS session_date,
    utm_source,

    utm_medium,
    utm_campaign
FROM {{ source('raw', 'SESSIONS') }}
