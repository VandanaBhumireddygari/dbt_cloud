{% snapshot campaign_snapshots %}

{{
    config(
        target_schema='snapshots',
        unique_key='campaign_id',
        strategy='timestamp',
        updated_at='DATE'
    )
}}

SELECT
    campaign_id,
    campaign_name,
    channel,
    platform,
    cost,
    impressions,
    clicks,
    date
FROM {{ ref('ads_unified') }}

{% endsnapshot %}
