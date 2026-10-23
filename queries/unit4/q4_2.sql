-- 4.2.a Compute the total number of events and the total number of events classified as failures.
-- Requirement: SELECT, COUNT, SUM, CASE, WHEN, THEN, GROUP BY, ORDER BY

SELECT
    driver_id,
    COUNT(*) AS total_trips,
    SUM(
        CASE
            WHEN trip_status IN ('cancelled', 'disputed') THEN 1
            ELSE 0
        END
    ) AS failed_trips
FROM trips
GROUP BY driver_id
ORDER BY failed_trips DESC;

-- RESULT:
-- driver_id | total_trips | failed_trips
-- 9	        14	        5
-- 5	        18	        5
-- 3	        13	        5
-- 11	        16	        5
-- 6	        21	        4
-- 7	        18	        4
-- 1	        11	        4
-- 2	        16	        4
-- 12	        17	        3
-- 4	        6	        2
-- 13	        11	        2
-- 8	        20	        1
-- 10	        19	        0

-- 4.2.b Compute regional sub totals and a platform wide grand total.
-- Requirement: SELECT, COUNT, SUM, CASE, WHEN, THEN, GROUP BY ROLLUP, ORDER BY, GROUPING

SELECT
    CASE
        WHEN GROUPING(pickup_city) = 1 THEN 'All Regions'
        ELSE pickup_city
    END AS region,
    COUNT(*) AS total_trips,
    SUM(
        CASE
            WHEN trip_status IN ('cancelled', 'disputed') THEN 1
            ELSE 0
        END
    ) AS failed_trips
FROM trips
GROUP BY ROLLUP (pickup_city)
ORDER BY
    GROUPING(pickup_city),
    pickup_city;

-- RESULT:
-- region | total_trips | failed_trips
-- "Danang"	    43	        8
-- "Haiphong"	39	        9
-- "Hanoi"	    38	        10
-- "Hue"	    40	        11
-- "Saigon" 	40	        6
-- "All Regions"200	        44

-- 4.2.c Create a query that computes a baseline for evaluating high-volume producers. Needs to use a WITH lause and a second aggregation or filter to calculate a baseline
-- Requirement: WITH, SELECT, COUNT, SUM, CASE, WHEN, THEN, GROUP BY, ORDER BY, NUMERIC

WITH driver_performance AS (
    SELECT
        driver_id,
        COUNT(*) AS total_trips,
        SUM(
            CASE
                WHEN trip_status IN ('cancelled', 'disputed') THEN 1
                ELSE 0
            END
        ) AS failed_trips
    FROM trips
    GROUP BY driver_id
)
SELECT
    COUNT(*) AS high_volume_producers,
    AVG(failed_trips::NUMERIC / total_trips) AS baseline_failure_rate
FROM driver_performance
WHERE total_trips >= 10;

-- RESULT:
-- high_volume_producers | baseline_failure_rate
-- 12	                    0.23055496382702265055