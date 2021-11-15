select
    order_id
from {{ ref('stg_payments') }}
where order_id = 0
group by 1