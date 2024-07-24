-- models/staging/stg_medications.sql
with source as (
  select * from {{ source('dbt_BigQuery_Ravi', 'medications') }}
)
select
  start,
  stop,
  patient,
  payer,
  encounter,
  code,
  description,
  base_cost,
  payer_coverage,
  dispenses,
  totalcost,
  reasoncode
from source


