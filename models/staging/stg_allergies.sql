-- models/staging/stg_allergies.sql
with source as (
  select * from {{ source('dbt_BigQuery_Ravi', 'allergies') }}
)
select
  start,
  stop,
  patient,
  encounter,
  code,
  description
from source
