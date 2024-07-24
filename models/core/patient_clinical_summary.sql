-- models/core/patient_clinical_summary.sql

with patients as (
  select * from {{ ref('stg_patients') }}
),
medications as (
  select * from {{ ref('stg_medications') }}
),
immunizations as (
  select * from {{ ref('stg_immunizations') }}
),
encounters as (
  select * from {{ ref('stg_encounters') }}
),
conditions as (
  select * from {{ ref('stg_conditions') }}
),
careplans as (
  select * from {{ ref('stg_careplans') }}
),
allergies as (
  select * from {{ ref('stg_allergies') }}
)

select
  p.patient_id,
  p.first_name,
  p.last_name,
  p.birthdate,
  p.gender,
  e.description as encounter_description,
  m.description as medication_description,
  i.description as immunization_description,
  c.description as condition_description,
  cp.description as careplan_description,
  a.description as allergy_description
from patients p
left join encounters e on p.patient_id = e.patient
left join medications m on p.patient_id = m.patient
left join immunizations i on p.patient_id = i.patient
left join conditions c on p.patient_id = c.patient
left join careplans cp on p.patient_id = cp.patient
left join allergies a on p.patient_id = a.patient
