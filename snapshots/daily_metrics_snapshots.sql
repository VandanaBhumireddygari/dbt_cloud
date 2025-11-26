{% snapshot daily_metrics_snapshots %}

{{
    config(
        target_schema='snapshots',
        unique_key="campaign_name || '-' || date",
        strategy='timestamp',
        updated_at='DATE'
    )
}}

SELECT *
FROM {{ ref('mart_channel_daily_metrics') }}

{% endsnapshot %}
