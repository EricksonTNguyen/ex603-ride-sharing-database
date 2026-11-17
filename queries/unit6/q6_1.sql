-- 6.1.1 Compare each event to its producer's average and determine any unusual event for its own producer. Create a Window function version and group by version
-- Requirement: SELECT, AVG, OVER, PARTITION BY, ORDER BY, GROUP BY

-- Window Function Version
SELECT
    trip_id,
    driver_id,
    fare_amount,
    AVG(fare_amount) OVER (
        PARTITION BY driver_id
    ) AS producer_avg_fare
FROM trips
ORDER BY driver_id, trip_id;

-- Results
-- trip_id | driver_id | fare_amount | producer_avg_fare
-- 1	1	19.74	16.0263636363636364
-- 2	1	7.40	16.0263636363636364
-- 3	1	22.43	16.0263636363636364
-- 4	1	0.00	16.0263636363636364
-- 5	1	7.07	16.0263636363636364
-- 6	1	21.89	16.0263636363636364
-- 7	1	26.17	16.0263636363636364
-- 8	1	0.00	16.0263636363636364
-- 9	1	20.06	16.0263636363636364
-- 10	1	29.07	16.0263636363636364
--  200 Rows

-- GROUP BY Version
SELECT
    driver_id,
    AVG(fare_amount) AS producer_avg_fare
FROM trips
GROUP BY driver_id
ORDER BY driver_id;

-- Results
-- driver_id | producer_avg_fare
-- 1	16.0263636363636364
-- 2	17.0218750000000000
-- 3	13.3569230769230769
-- 4	19.4866666666666667
-- 5	23.0572222222222222
-- 6	17.8371428571428571
-- 7	18.3300000000000000
-- 8	22.6280000000000000
-- 9	14.1714285714285714
-- 10	20.9668421052631579
-- 11	11.9412500000000000
-- 12	18.2711764705882353
-- 13	19.8581818181818182

-- Difference Analysis:
-- The Window Function returns 200 rows while the GROUP BY version returns 13 rows. The GROUP BY returns only one row per driver. Due to this, it loses the individual trip
-- records and their individual fares. The Window Function keeps those details and makes it possible to compare each trip against its driver's average.



-- 6.1.2 Rank the producer in three ways in one query showing the categories all in one table.
-- Requirement: SELECT, WITH, LEFT JOIN, GROUP BY, ROW_NUMBER(), OVER, ORDER BY, RANK(), DENSE_RANK()

WITH producer_events AS (
    SELECT
        d.driver_id,
        d.driver_name,
        COUNT(t.trip_id) AS total_events
    FROM drivers AS d
    LEFT JOIN trips AS t
        ON d.driver_id = t.driver_id
    GROUP BY d.driver_id, d.driver_name
)
SELECT
    driver_id,
    driver_name,
    total_events,

    ROW_NUMBER() OVER (
        ORDER BY total_events DESC, driver_id
    ) AS row_number_rank,

    RANK() OVER (
        ORDER BY total_events DESC
    ) AS rank_position,

    DENSE_RANK() OVER (
        ORDER BY total_events DESC
    ) AS dense_rank_position

FROM producer_events
ORDER BY total_events DESC, driver_id;

-- Results
-- driver_id | driver_name | total_events | row_number_rank | rank_position | dense_rank_position
-- 6	"Driver_06"	21	1	1	1
-- 8	"Driver_08"	20	2	2	2
-- 10	"Driver_10"	19	3	3	3
-- 5	"Driver_05"	18	4	4	4
-- 7	"Driver_07"	18	5	4	4
-- 12	"Driver_12"	17	6	6	5
-- 2	"Driver_02"	16	7	7	6
-- 11	"Driver_11"	16	8	7	6
-- 9	"Driver_09"	14	9	9	7
-- 3	"Driver_03"	13	10	10	8
-- 1	"Driver_01"	11	11	11	9
-- 13	"Driver_13"	11	12	11	9
-- 4	"Driver_04"	6	13	13	10
-- 14	"Driver_14"	0	14	14	11
-- 15	"Driver_15"	0	15	14	11


-- 6.1.3 Sort producers into four bands. Split the producers into four groups by number of events
-- Requirement: SELECT, WITH, LEFT JOIN, GROUP BY, NTILE(), OVER, ORDER BY

WITH producer_events AS (
    SELECT
        d.driver_id,
        d.driver_name,
        COUNT(t.trip_id) AS total_events
    FROM drivers AS d
    LEFT JOIN trips AS t
        ON d.driver_id = t.driver_id
    GROUP BY d.driver_id, d.driver_name
)
SELECT
    driver_id,
    driver_name,
    total_events,
    NTILE(4) OVER (
        ORDER BY total_events DESC, driver_id
    ) AS producer_band
FROM producer_events
ORDER BY producer_band, total_events DESC, driver_id;

-- Results
-- driver_id | driver_name | total_events | producer_band
-- 6	"Driver_06"	21	1
-- 8	"Driver_08"	20	1
-- 10	"Driver_10"	19	1
-- 5	"Driver_05"	18	1
-- 7	"Driver_07"	18	2
-- 12	"Driver_12"	17	2
-- 2	"Driver_02"	16	2
-- 11	"Driver_11"	16	2
-- 9	"Driver_09"	14	3
-- 3	"Driver_03"	13	3
-- 1	"Driver_01"	11	3
-- 13	"Driver_13"	11	3
-- 4	"Driver_04"	6	4
-- 14	"Driver_14"	0	4
-- 15	"Driver_15"	0	4