-- models/core/patient_condition_summary.sql

with conditions as (
  select
    patient,
    count(*) as condition_count
  from {{ ref('stg_conditions') }}
  group by patient
)

select
  c.patient,
  p.first_name,
  p.last_name,
  c.condition_count
from conditions c
join {{ ref('stg_patients') }} p on c.patient = p.patient_id
