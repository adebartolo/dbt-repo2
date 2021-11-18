{% snapshot mock_orders %}

{% set new_schema = target.schema + '_snapshot' %}

{{
    config(
      target_database='cis4400-hw3-fundamentals',
      target_schema=new_schema,
      unique_key='order_id',

      strategy='timestamp',
      updated_at='updated_at',
    )
}}

select * from cis4400-hw3-fundamentals.{{target.schema}}.mock_orders

{% endsnapshot %}


