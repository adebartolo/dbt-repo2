{% set order_statuses = ["completed", "placed", "shipped", "returned", "return_pending"] %}
with orders as (
    
    select
        id as order_id,
        user_id as customer_id,
        order_date,
        status as order_status

   -- from `dbt-tutorial`.jaffle_shop.orders
    from {{ source('jaffle_shop', 'orders') }}
),
payments as (

    select
        id as payment_id,
        orderid as order_id,
        paymentmethod as payment_method,
        status as completion_status,

        -- amount is stored in cents, convert it to dollars
        amount / 100 as amount,
        created as created_at

    -- from `dbt-tutorial`.stripe.payment 
    from {{ source('stripe', 'payment') }}
),
all_transactions as (
    select * from
    payments
    join orders using(order_id)
),
final as (
   select
       {% for order_status in order_statuses -%}

       sum(case when order_status = '{{ order_status }}' then amount else 0 end)
       as {{ order_status }}_amount

       {%- if not loop.last -%}
         ,
       {% endif -%}

       {%- endfor %}
   from all_transactions
)
select * from final




