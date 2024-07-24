-- models/staging/stg_conditions.sql
with source as (
  select * from {{ source('dbt_BigQuery_Ravi', 'conditions') }}
)
select
  start,
  stop,
  patient,
  encounter,
  code,
  description
from source
