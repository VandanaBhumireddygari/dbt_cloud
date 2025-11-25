{{ config(materialized="table") }}

with
    session_orders as (
        select
            s.session_id,
            s.session_date,
            s.utm_source,
            s.utm_medium,
            s.utm_campaign,
            count(distinct o.order_id) as orders,
            sum(o.revenue) as revenue
        from {{ ref("sessions_clean") }} s
        left join {{ ref("orders_clean") }} o on s.session_id = o.session_id
        group by 1, 2, 3, 4, 5
    ),

    ads as (
        select
            date as ad_date, platform, channel, campaign_name, impressions, clicks, cost
        from {{ ref("ads_unified") }}
    )

select
    a.ad_date as date,
    a.platform,
    a.channel,
    a.campaign_name,
    sum(a.impressions) as impressions,
    sum(a.clicks) as clicks,
    sum(a.cost) as cost,
    coalesce(sum(so.orders), 0) as orders,
    coalesce(sum(so.revenue), 0) as revenue,
    case
        when sum(a.clicks) = 0 then 0 else sum(so.orders) * 1.0 / sum(a.clicks)
    end as conversion_rate,
    case when sum(a.cost) = 0 then 0 else sum(so.revenue) / sum(a.cost) end as roas
from ads a
left join
    session_orders so
    on so.session_date = a.ad_date
    and so.utm_campaign = a.campaign_name
group by 1, 2, 3, 4
