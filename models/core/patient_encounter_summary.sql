-- models/core/patient_encounter_summary.sql

with encounters as (
  select
    patient,
    count(*) as encounter_count,
    sum(base_encounter_cost) as total_encounter_cost,
    sum(total_claim_cost) as total_claim_cost
  from {{ ref('stg_encounters') }}
  group by patient
)

select
  e.patient,
  p.first_name,
  p.last_name,
  e.encounter_count,
  e.total_encounter_cost,
  e.total_claim_cost
from encounters e
join {{ ref('stg_patients') }} p on e.patient = p.patient_id
