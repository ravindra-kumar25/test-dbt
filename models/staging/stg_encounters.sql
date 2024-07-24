-- models/staging/stg_encounters.sql
with source as (
  select * from {{ source('dbt_BigQuery_Ravi', 'encounters') }}
)
select
  id as encounter_id,
  start,
  stop,
  patient,
  organization,
  provider,
  payer,
  encounterclass,
  code,
  description,
  base_encounter_cost,
  total_claim_cost,
  payer_coverage,
  reasoncode,
  reasondescription
from source
