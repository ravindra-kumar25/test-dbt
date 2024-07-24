-- models/core/enhanced_patient_summary.sql

with patient_summary as (
  select * from {{ ref('patient_clinical_summary') }}
)

select
  ps.patient_id,
  ps.first_name,
  ps.last_name,
  ps.birthdate,
  ps.gender,
  ps.encounter_description,
  ps.medication_description,
  ps.immunization_description,
  ps.condition_description,
  ps.careplan_description,
  ps.allergy_description,
  -- Additional transformations/aggregations
  count(distinct ps.encounter_description) as total_encounters,
  count(distinct ps.medication_description) as total_medications,
  count(distinct ps.immunization_description) as total_immunizations,
  count(distinct ps.condition_description) as total_conditions,
  count(distinct ps.careplan_description) as total_careplans,
  count(distinct ps.allergy_description) as total_allergies
from patient_summary ps
group by
  ps.patient_id,
  ps.first_name,
  ps.last_name,
  ps.birthdate,
  ps.gender,
  ps.encounter_description,
  ps.medication_description,
  ps.immunization_description,
  ps.condition_description,
  ps.careplan_description,
  ps.allergy_description
