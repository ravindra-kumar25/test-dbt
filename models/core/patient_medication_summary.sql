-- models/core/patient_medication_summary.sql

with medications as (
  select
    patient,
    description as medication_description,
    count(*) as medication_count,
    sum(base_cost) as total_medication_cost
  from {{ ref('stg_medications') }}
  group by patient, description
)

select
  m.patient,
  p.first_name,
  p.last_name,
  m.medication_description,
  m.medication_count,
  m.total_medication_cost
from medications m
join {{ ref('stg_patients') }} p on m.patient = p.patient_id
