with patients as (
    select
        distinct
        patient_id,
        patient_name
    from
        {{ ref ('stg_patients_visits') }}
)

select
    {{ dbt_utils.surrogate_key(['patient_id']) }} as patient_sk,
    patient_id,
    patient_name
from
    patients
where
    patient_id is not null or patient_id != ''