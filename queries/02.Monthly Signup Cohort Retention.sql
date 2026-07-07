### Q2 — Monthly Signup Cohort Retention
###“For each month’s new signups, how many came back in months 1, 2, 3?”
### Owner: Deepa Hegde / Last updated: 2026-06-23
### Sanity check: cohort_size for any month equals count(distinct customer_id) from ecom.customers where date_trunc('month', created_at) = cohort_month. All retention rates in [0, 1].

with cohort_month as (
select customer_id
,  date_trunc('month', created_at) as cohort_month
from ecom.customers
)

, retained_month as (
select customer_id
, date_trunc('month', created_at) as ordered_month
from ecom.orders
where lower(status) != 'cancelled'
)

, cohort_activity as (
select 
  cm.customer_id
, cm.cohort_month
, rm.ordered_month
, date_part('month', age(rm.ordered_month, cm.cohort_month)) as month_number
from cohort_month cm
left join retained_month rm on cm.customer_id=rm.customer_id and
                               rm.ordered_month >= cm.cohort_month
)

select
  cohort_month
, count(distinct customer_id) as cohort_size
, count(distinct case when month_number =1 then customer_id end) as m1_retained
, count(distinct case when month_number =2 then customer_id end) as m2_retained
, count(distinct case when month_number =3 then customer_id end) as m3_retained
, case 
  when cohort_month <= date_trunc('month', current_date)- interval '1 month'
  then count(distinct case when month_number =1 then customer_id end) * 1.0
  /count(distinct customer_id)
  else null end as m1_retention_rate
, case 
  when cohort_month <= date_trunc('month', current_date)- interval '2 month'
  then count(distinct case when month_number =2 then customer_id end) * 1.0
  /count(distinct customer_id)
  else null end as m2_retention_rate
, case
  when cohort_month <= date_trunc('month', current_date)- interval '3 month'
  then count(distinct case when month_number =3 then customer_id end) * 1.0
  /count(distinct customer_id)
  else null end as m3_retention_rate
from cohort_activity
group by cohort_month
order by cohort_month;
