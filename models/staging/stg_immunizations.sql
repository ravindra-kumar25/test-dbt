-- models/staging/stg_immunizations.sql
with source as (
  select * from {{ source('dbt_BigQuery_Ravi', 'immunizations') }}
)
select
  date,
  patient,
  encounter,
  code,
  description,
  base_cost
from source
