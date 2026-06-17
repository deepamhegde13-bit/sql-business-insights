### Q1 — Daily Business Summary with DoD and Same-Weekday WoW
###“How are we doing today vs yesterday, and vs the same day last week?”
### Owner: Deepa Hegde / Last updated: 2026-06-17
### Sanity check: paid_order_rate between 0 and 1 on every row; sum(orders) across all days equals count(*) of ecom.orders for the same window.

with order_data as (
select
  cast(created_at as date) as order_date
, sum(total) as revenue
, count(*) as orders
, (sum(total)*1.0/nullif(count(*), 0)) as aov
, count(*) filter (where payment_status ='paid') as paid_order
, count(*) filter (where status ='cancelled') as cancelled_order
from ecom.orders
where created_at >= (select max(created_at) from ecom.orders) - interval '60 days'
group by 1
)

, refund_data as (
select 
  cast(created_at as date) as order_date
, sum(amount) as refund_amount
from ecom.refunds
where created_at >= (select max(created_at) from ecom.refunds) - interval '60 days'
group by 1
)

select 
  od.order_date
, od.revenue
, od.orders
, od.aov
, (od.paid_order*1.0/od.orders) as paid_order_rate
, (od.cancelled_order*1.0/od.orders) as cancelled_order_rate
, coalesce(rd.refund_amount, 0) as refunds_amount
, (od.revenue - lag(od.revenue, 1) over(order by od.order_date))
   / nullif(lag(od.revenue, 1) over(order by od.order_date), 0) as revenue_vs_yesterday_pct
, (od.revenue - lag(od.revenue, 7) over(order by od.order_date))
   / nullif(lag(od.revenue, 7) over(order by od.order_date), 0) as revenue_vs_last_weekday_pct
from order_data od
left join refund_data rd on od.order_date=rd.order_date
order by od.order_date desc;