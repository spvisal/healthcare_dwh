with diagnosis as (
    select
        distinct
        diagnosis_code,
        diagnosis_desc
    from
        {{ ref ('stg_patients_visits') }}
)

select
    {{ dbt_utils.surrogate_key(['diagnosis_code']) }} as diagnosis_sk,
    diagnosis_code,
    diagnosis_desc
from
    diagnosis
where
    diagnosis_code is not null or diagnosis_code != ''
and diagnosis_desc is not null or diagnosis_desc != ''