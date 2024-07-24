-- models/core/patient_careplan_summary.sql

with careplans as (
  select
    patient,
    count(*) as careplan_count
  from {{ ref('stg_careplans') }}
  group by patient
)

select
  cp.patient,
  p.first_name,
  p.last_name,
  cp.careplan_count
from careplans cp
join {{ ref('stg_patients') }} p on cp.patient = p.patient_id
