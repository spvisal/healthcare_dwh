with patients_visits_base as(
    select * from {{ source('raw', 'patients_visits') }}
)
select
        patient_id,
        patient_name,
        visit_id,
        cast(visit_date as date) as visit_date,
        diagnosis_code,
        diagnosis_desc,
        drug,
        dose,
        provider_notes,
        provider_name
from
    patients_visits_base