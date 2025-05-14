-- Query to fetch all patients prescribed Metformin in Q2 2023.
SELECT
	dp.patient_name,
	fct.visit_date_sk as visited_on,
	dt.drug as prescribed_medication,
	dt.dose as prescribed_dose
FROM
	public.fct_visit_treatments as fct
LEFT JOIN public.dim_patients AS dp ON fct.patient_sk = dp.patient_sk
LEFT JOIN public.dim_date AS dd ON fct.visit_date_sk=dd.date_day
LEFT JOIN public.dim_treatments as dt ON fct.treatments_sk=dt.treatments_sk
WHERE
	drug = 'Metformin'
AND dd.quarter = 2
AND dd.year = 2023

--- Query to calculate total number of visits per diagnoses
SELECT
	dd.diagnosis_code,
	dd.diagnosis_desc,
	COUNT(DISTINCT vt.visit_id) AS total_visits
FROM
	public.fct_visit_treatments AS vt
JOIN public.dim_diagnoses AS dd ON vt.diagnosis_sk=dd.diagnosis_sk
GROUP BY
	dd.diagnosis_code,
	dd.diagnosis_desc
ORDER BY
	total_visits
	
-- Query to find total number of visits per month for last 6 month
SELECT
	dd.year AS visit_year,
	dd.month AS visit_month,
	COUNT(DISTINCT visit_id) AS total_visits
FROM
	public.fct_visit_treatments AS vt
JOIN public.dim_date AS dd ON vt.visit_date_sk=dd.date_day
WHERE
	vt.visit_date_sk BETWEEN '2023-01-01' AND '2023-06-30'
GROUP BY
	dd.year,
	dd.month
ORDER BY
	total_visits
