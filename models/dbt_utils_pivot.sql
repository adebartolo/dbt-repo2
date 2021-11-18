{{ config (
    materialized="table"

)}}

select
{{ dbt_utils.star(from=ref('stg_payment'), except=["payment_method", "status"]) }}
from {{ ref('stg_payment') }}
where status = 'success'

