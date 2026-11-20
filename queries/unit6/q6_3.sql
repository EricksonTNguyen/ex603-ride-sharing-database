-- 6.3.a Write a query that returns the top three events by metric for each producer
-- Requirement: SELECT, WITH, RANK(), PARTITION BY, ORDER BY, FIRST_VALUE()

WITH ranked_trips AS (
    SELECT
        trip_id,
        driver_id,
        requested_at,
        fare_amount,

        RANK() OVER (
            PARTITION BY driver_id
            ORDER BY fare_amount DESC
        ) AS fare_rank,

        FIRST_VALUE(fare_amount) OVER (
            PARTITION BY driver_id
            ORDER BY fare_amount DESC, trip_id
        ) AS highest_fare

    FROM trips
)
SELECT
    trip_id,
    driver_id,
    requested_at,
    fare_amount,
    fare_rank,
    highest_fare
FROM ranked_trips
WHERE fare_rank <= 3
ORDER BY driver_id, fare_rank, trip_id;

-- To handle ties, I used RANK() so that trips with the same fare receive the same rank. If multiple trips tie for third place, all of them are included.

-- Results
-- trip_id | driver_id | requested_at | fare_amount | fare_rank | highest_fare
-- 10	1	"2023-06-22 22:30:00"	29.07	1	29.07
-- 7	1	"2023-02-23 10:07:00"	26.17	2	29.07
-- 11	1	"2023-11-14 09:05:00"	22.46	3	29.07
-- 18	2	"2023-05-04 14:33:00"	47.81	1	47.81
-- 17	2	"2023-08-11 08:48:00"	29.42	2	47.81
-- 24	2	"2023-07-03 05:00:00"	28.94	3	47.81
-- 36	3	"2023-07-21 14:43:00"	38.09	1	38.09
-- 38	3	"2023-05-04 14:17:00"	26.53	2	38.09
-- 34	3	"2023-05-12 17:06:00"	21.60	3	38.09
-- 43	4	"2023-10-15 19:01:00"	70.86	1	70.86
-- 41	4	"2023-11-13 00:48:00"	22.77	2	70.86
-- 42	4	"2023-08-17 02:06:00"	14.34	3	70.86
-- 60	5	"2023-12-20 19:28:00"	48.41	1	48.41
-- 47	5	"2023-09-13 04:15:00"	43.72	2	48.41
-- 54	5	"2023-10-11 06:21:00"	37.59	3	48.41
-- 78	6	"2023-10-26 23:02:00"	50.25	1	50.25
-- 67	6	"2023-09-19 07:49:00"	42.02	2	50.25
-- 68	6	"2023-09-12 18:32:00"	33.48	3	50.25
-- 94	7	"2023-09-23 03:58:00"	40.48	1	40.48
-- 100	7	"2023-09-16 10:22:00"	40.39	2	40.48
-- 95	7	"2023-12-23 21:37:00"	34.32	3	40.48
-- 104	8	"2023-04-14 23:09:00"	59.14	1	59.14
-- 116	8	"2023-02-23 15:15:00"	48.16	2	59.14
-- 105	8	"2023-02-27 17:37:00"	40.16	3	59.14
-- 126	9	"2023-12-17 20:03:00"	34.34	1	34.34
-- 135	9	"2023-05-05 21:45:00"	28.18	2	34.34
-- 137	9	"2023-01-05 14:18:00"	25.89	3	34.34
-- 154	10	"2023-01-23 22:51:00"	35.21	1	35.21
-- 148	10	"2023-02-03 07:01:00"	34.54	2	35.21
-- 151	10	"2023-02-02 00:59:00"	34.41	3	35.21
-- 164	11	"2023-02-09 14:56:00"	34.79	1	34.79
-- 172	11	"2023-02-24 22:40:00"	22.35	2	34.79
-- 166	11	"2023-10-17 23:57:00"	21.23	3	34.79
-- 184	12	"2023-09-13 04:49:00"	37.84	1	37.84
-- 183	12	"2023-01-10 21:57:00"	31.82	2	37.84
-- 185	12	"2023-02-16 21:47:00"	30.64	3	37.84
-- 200	13	"2023-09-04 19:15:00"	48.80	1	48.80
-- 190	13	"2023-01-08 02:11:00"	47.02	2	48.80
-- 199	13	"2023-06-23 04:32:00"	28.70	3	48.80

-- 6.3.b Write a query that analyzes whether the platform is getting better or worse each month.
-- Requirement: SELECT, WITH, GROUP BY, GENERATE_SERIES(), COALESCE, LEFT JOIN, LAG(), ROUND, CASE(), ORDER BY

WITH monthly_totals AS (
    SELECT
        DATE_TRUNC('month', requested_at)::date AS month,
        SUM(fare_amount) AS monthly_fare,
        COUNT(*) AS event_count
    FROM trips
    GROUP BY DATE_TRUNC('month', requested_at)
),
month_series AS (
    SELECT
        GENERATE_SERIES(
            (SELECT MIN(month) FROM monthly_totals),
            (SELECT MAX(month) FROM monthly_totals),
            INTERVAL '1 month'
        )::date AS month
),
complete_months AS (
    SELECT
        ms.month,
        COALESCE(mt.monthly_fare, 0) AS monthly_fare,
        COALESCE(mt.event_count, 0) AS event_count
    FROM month_series ms
    LEFT JOIN monthly_totals mt
        ON ms.month = mt.month
),
monthly_comparison AS (
    SELECT
        month,
        monthly_fare,
        event_count,

        LAG(monthly_fare) OVER (
            ORDER BY month
        ) AS previous_month_fare,

        LAG(event_count) OVER (
            ORDER BY month
        ) AS previous_month_events

    FROM complete_months
)
SELECT
    month,
    monthly_fare,
    event_count,
    previous_month_fare,

    ROUND(
        (
            (monthly_fare - previous_month_fare)
            / NULLIF(previous_month_fare, 0)
        ) * 100,
        2
    ) AS percent_change,

    CASE
        WHEN event_count = 0 THEN 'Missing month'
        ELSE 'Data available'
    END AS month_status

FROM monthly_comparison
ORDER BY month;

-- Results
-- month | monthly_fare | event_count | previous_month_fare | percent_change | month_status
-- "2023-01-01"	320.36	21	null    null	"Data available"
-- "2023-02-01"	453.44	21	320.36	41.54	"Data available"
-- "2023-03-01"	135.98	11	453.44	-70.01	"Data available"
-- "2023-04-01"	259.75	11	135.98	91.02	"Data available"
-- "2023-05-01"	308.09	17	259.75	18.61	"Data available"
-- "2023-06-01"	289.15	20	308.09	-6.15	"Data available"
-- "2023-07-01"	301.86	17	289.15	4.40	"Data available"
-- "2023-08-01"	293.62	18	301.86	-2.73	"Data available"
-- "2023-09-01"	408.63	16	293.62	39.17	"Data available"
-- "2023-10-01"	370.65	18	408.63	-9.29	"Data available"
-- "2023-11-01"	215.42	14	370.65	-41.88	"Data available"
-- "2023-12-01"	271.24	16	215.42	25.91	"Data available"