with treatments as (
    select
        distinct
        drug,
        dose
    from
        {{ ref ('stg_patients_visits') }}
)

select
    {{ dbt_utils.surrogate_key(['drug','dose']) }} as treatments_sk,
    drug,
    dose
from
    treatments