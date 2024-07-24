-- models/staging/stg_careplans.sql
with source as (
  select * from {{ source('dbt_BigQuery_Ravi', 'careplans') }}
)
select
  id as careplan_id,
  start,
  stop,
  patient,
  encounter,
  code,
  description,
  reasoncode,
  reasondescription
from source
