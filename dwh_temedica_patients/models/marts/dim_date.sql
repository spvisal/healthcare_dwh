WITH date_spine AS (

    {{ dbt_utils.date_spine(
        start_date="CAST('2000-01-01' AS DATE)",
        end_date="CAST('2050-12-31' AS DATE)",
        datepart="day"
    ) }}

),

dim_date AS (
    SELECT
        cast(date_day as date) AS date_day,
        EXTRACT(YEAR FROM date_day) AS year,
        EXTRACT(QUARTER FROM date_day) AS quarter,
        EXTRACT(MONTH FROM date_day) AS month,
        EXTRACT(DAY FROM date_day) AS day,
        EXTRACT(DOW FROM date_day) AS day_of_week, -- 0 = Sunday
        TO_CHAR(date_day, 'Day') AS day_name,
        TO_CHAR(date_day, 'Month') AS month_name,
        CASE
            WHEN EXTRACT(DOW FROM date_day) IN (0, 6) THEN TRUE
            ELSE FALSE
        END AS is_weekend
    FROM date_spine
)

SELECT * FROM dim_date
