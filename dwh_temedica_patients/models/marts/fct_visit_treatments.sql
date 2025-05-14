with visit_treatments as (
    select
        *
    from {{ ref('stg_patients_visits') }}
)
select
    {{ dbt_utils.surrogate_key(['p.patient_sk','d.diagnosis_sk','t.treatments_sk','dd.date_day']) }} as fact_id,
    p.patient_sk,
    d.diagnosis_sk,
    t.treatments_sk,
    dd.date_day as visit_date_sk,
    vt.visit_id,
    vt.provider_notes,
    vt.provider_name

from visit_treatments as vt
left join {{ ref('dim_patients') }} as p
    on vt.patient_id = p.patient_id

left join {{ ref('dim_diagnoses') }} as d
    on vt.diagnosis_code = d.diagnosis_code

left join {{ ref('dim_treatments') }} as t
    on vt.drug=t.drug and vt.dose=t.dose

left join {{ ref('dim_date') }} as dd
    on vt.visit_date = dd.date_day