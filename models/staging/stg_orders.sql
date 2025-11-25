{{ config(materialized='view') }}

SELECT
    order_id,
    user_id,
    TO_TIMESTAMP_NTZ(order_ts) AS order_ts,
    DATE(TO_TIMESTAMP_NTZ(order_ts)) AS order_date,
    session_id,
    revenue
FROM {{ source('raw', 'ORDERS') }}
