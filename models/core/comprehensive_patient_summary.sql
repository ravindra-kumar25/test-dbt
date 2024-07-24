-- models/core/comprehensive_patient_summary.sql

with medication_summary as (
  select
    patient,
    sum(medication_count) as total_medication_count,
    sum(total_medication_cost) as total_medication_cost
  from {{ ref('patient_medication_summary') }}
  group by patient
),
encounter_summary as (
  select
    patient,
    encounter_count,
    total_encounter_cost,
    total_claim_cost
  from {{ ref('patient_encounter_summary') }}
),
condition_summary as (
  select
    patient,
    condition_count
  from {{ ref('patient_condition_summary') }}
),
careplan_summary as (
  select
    patient,
    careplan_count
  from {{ ref('patient_careplan_summary') }}
)

select
  p.patient_id,
  p.first_name,
  p.last_name,
  p.birthdate,
  p.gender,
  coalesce(ms.total_medication_count, 0) as total_medication_count,
  coalesce(ms.total_medication_cost, 0) as total_medication_cost,
  coalesce(es.encounter_count, 0) as encounter_count,
  coalesce(es.total_encounter_cost, 0) as total_encounter_cost,
  coalesce(es.total_claim_cost, 0) as total_claim_cost,
  coalesce(cs.condition_count, 0) as condition_count,
  coalesce(cps.careplan_count, 0) as careplan_count
from {{ ref('stg_patients') }} p
left join medication_summary ms on p.patient_id = ms.patient
left join encounter_summary es on p.patient_id = es.patient
left join condition_summary cs on p.patient_id = cs.patient
left join careplan_summary cps on p.patient_id = cps.patient
