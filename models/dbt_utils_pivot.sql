{{ config (
    materialized="table"

)}}

select
  status,
  {{ dbt_utils.pivot(
      'payment_method',
      dbt_utils.get_column_values(ref('stg_payment'), 'payment_method')
  ) }}
from {{ ref('stg_payment') }}
group by status