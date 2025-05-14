
select *
from {{ ref('fct_visit_treatments') }}
where visit_date_sk is null
   or visit_date_sk < '2000-01-01'
   or visit_date_sk > CURRENT_DATE
