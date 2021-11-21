select order_id
from {{ ref('stg_payment') }}
where not order_id > 0
group by 1