with payments as (
select * from {{ ref('stg_payment') }}
),

aggregated_success as (
select
sum(amount) as total_revenue_success
from payments
where status = 'success'
),

aggregated_fail as (
select
sum(amount) as total_revenue_fail
from payments
where status = 'fail'
)

select total_revenue_success, total_revenue_fail
from aggregated_success, aggregated_fail

