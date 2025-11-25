{{ config(materialized='table') }}

SELECT
    order_id,
    user_id,
    order_ts,
    order_date,
    session_id,
    revenue
FROM {{ ref('stg_orders') }}
