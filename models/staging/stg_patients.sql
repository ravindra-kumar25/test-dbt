-- models/staging/stg_patients.sql
with source as (
  select * from {{ source('dbt_BigQuery_Ravi', 'patients') }}
)
select
  id as patient_id,
  birthdate,
  deathdate,
  ssn,
  drivers,
  passport,
  prefix,
  first as first_name,
  last as last_name,
  suffix,
  maiden,
  marital,
  race,
  ethnicity,
  gender,
  birthplace,
  address,
  city,
  state,
  county,
  zip,
  lat,
  lon,
  healthcare_expenses,
  healthcare_coverage
from source

