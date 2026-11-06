-- 5.1.1 Create a query that joins 3 tabls to display the actors, producers, and event's occurence in one table
-- Requirement: SELECT, JOIN, ORDER BY

SELECT
    t.trip_id AS event_id,
    r.rider_name AS actor,
    d.driver_name AS producer,
    t.requested_at AS event_date_time
FROM trips AS t
JOIN riders AS r
    ON t.rider_id = r.rider_id
JOIN drivers AS d
    ON t.driver_id = d.driver_id
ORDER BY t.requested_at;

-- RESULT:
-- event_id | actor | producer | event_date_time
-- 4	"Rider_01"	"Driver_01"	"2023-01-01 15:48:00"
-- 137	"Rider_20"	"Driver_09"	"2023-01-05 14:18:00"
-- 188	"Rider_23"	"Driver_12"	"2023-01-07 08:04:00"
-- 190	"Rider_02"	"Driver_13"	"2023-01-08 02:11:00"
-- 56	"Rider_23"	"Driver_05"	"2023-01-08 08:12:00"
-- 169	"Rider_24"	"Driver_11"	"2023-01-08 14:28:00"
-- 192	"Rider_12"	"Driver_13"	"2023-01-10 10:35:00"
-- 183	"Rider_14"	"Driver_12"	"2023-01-10 21:57:00"
-- 82	"Rider_23"	"Driver_06"	"2023-01-13 17:20:00"
-- 144	"Rider_01"	"Driver_10"	"2023-01-14 10:57:00"
-- 8	"Rider_04"	"Driver_01"	"2023-01-16 21:46:00"
-- 12	"Rider_19"	"Driver_02"	"2023-01-20 08:07:00"
-- 19	"Rider_30"	"Driver_02"	"2023-01-20 11:49:00"
-- 145	"Rider_02"	"Driver_10"	"2023-01-23 11:44:00"
-- 154	"Rider_01"	"Driver_10"	"2023-01-23 22:51:00"
-- . . . 200 Entries

-- 5.1.2 Write a query that connects the producer table to the catalog table through the junction table. Return the producers associated with your theme's catalog tag.
-- Requirement: SELECT, JOIN, ORDER BY

SELECT
    d.driver_id AS driver_id,
    d.driver_name AS driver,
    b.badge_name AS badge
FROM drivers AS d
JOIN driver_badge_awards AS a
    ON d.driver_id = a.driver_id
JOIN driver_badges AS b
    ON a.badge_id = b.badge_id
ORDER BY b.badge_name, d.driver_id;

-- RESULT:
-- driver_id | driver | badge
-- 2	"Driver_02"	"Airport Pro"
-- 6	"Driver_06"	"Airport Pro"
-- 8	"Driver_08"	"Airport Pro"
-- 10	"Driver_10"	"Airport Pro"
-- 3	"Driver_03"	"Clean Car"
-- 4	"Driver_04"	"Clean Car"
-- 10	"Driver_10"	"Clean Car"
-- 1	"Driver_01"	"Five Star"
-- 4	"Driver_04"	"Five Star"
-- 11	"Driver_11"	"Five Star"
-- 12	"Driver_12"	"Five Star"
-- 2	"Driver_02"	"Night Owl"
-- 3	"Driver_03"	"Night Owl"
-- 5	"Driver_05"	"Night Owl"
-- 10	"Driver_10"	"Night Owl"
-- 11	"Driver_11"	"Night Owl"
-- 1	"Driver_01"	"Safe Driving"
-- 2	"Driver_02"	"Safe Driving"
-- 4	"Driver_04"	"Safe Driving"
-- 5	"Driver_05"	"Safe Driving"
-- 7	"Driver_07"	"Safe Driving"
-- 8	"Driver_08"	"Safe Driving"
-- 9	"Driver_09"	"Safe Driving"
-- 10	"Driver_10"	"Safe Driving"
-- 12	"Driver_12"	"Safe Driving"

-- 5.1.3 Write a self join to compare records within the producer table.
-- Requirement: SELECT, JOIN, ORDER BY, WITH, GROUP BY, LEFT JOIN, COALESCE

WITH driver_activity AS (
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
    d1.driver_name AS investigated_driver,
    d2.driver_name AS comparison_driver,

    d1.home_city AS investigated_city,
    d2.home_city AS comparison_city,

    d1.avg_rating AS investigated_rating,
    d2.avg_rating AS comparison_rating,

    COALESCE(a1.total_trips, 0) AS investigated_total_trips,
    COALESCE(a2.total_trips, 0) AS comparison_total_trips,

    COALESCE(a1.failed_trips, 0) AS investigated_failed_trips,
    COALESCE(a2.failed_trips, 0) AS comparison_failed_trips

FROM drivers AS d1
JOIN drivers AS d2
    ON d1.driver_id <> d2.driver_id
LEFT JOIN driver_activity AS a1
    ON d1.driver_id = a1.driver_id
LEFT JOIN driver_activity AS a2
    ON d2.driver_id = a2.driver_id
WHERE d1.driver_id IN (1, 3, 9)
ORDER BY d1.driver_id, d2.driver_id;

-- RESULT:
-- investigated_driver | comparison_driver | investigated_city | comparison_city | investigated_rating | comparison_rating | investigated_total_trips | comparison_total_trips | investigated_failed_trips | comparison_failed_trips
-- "Driver_01"	"Driver_02"	"Hue"	"Danang"	4.97	4.94	11	16	4	4
-- "Driver_01"	"Driver_03"	"Hue"	"Haiphong"	4.97	4.91	11	13	4	5
-- "Driver_01"	"Driver_04"	"Hue"	"Saigon"	4.97	4.88	11	6	4	2
-- "Driver_01"	"Driver_05"	"Hue"	"Saigon"	4.97	4.85	11	18	4	5
-- "Driver_01"	"Driver_06"	"Hue"	"Haiphong"	4.97	3.65	11	21	4	4
-- "Driver_01"	"Driver_07"	"Hue"	"Saigon"	4.97	3.65	11	18	4	4
-- "Driver_01"	"Driver_08"	"Hue"	"Saigon"	4.97	4.33	11	20	4	1
-- "Driver_01"	"Driver_09"	"Hue"	"Hue"	4.97	4.52	11	14	4	5
-- "Driver_01"	"Driver_10"	"Hue"	"Hanoi"	4.97	4.00	11	19	4	0
-- "Driver_01"	"Driver_11"	"Hue"	"Haiphong"	4.97	4.30	11	16	4	5
-- "Driver_01"	"Driver_12"	"Hue"	"Hanoi"	4.97	4.38	11	17	4	3
-- "Driver_01"	"Driver_13"	"Hue"	"Hue"	4.97	4.94	11	11	4	2
-- "Driver_01"	"Driver_14"	"Hue"	"Saigon"	4.97	3.63	11	0	4	0
-- "Driver_01"	"Driver_15"	"Hue"	"Hue"	4.97	4.00	11	0	4	0
-- "Driver_03"	"Driver_01"	"Haiphong"	"Hue"	4.91	4.97	13	11	5	4
-- "Driver_03"	"Driver_02"	"Haiphong"	"Danang"	4.91	4.94	13	16	5	4
-- "Driver_03"	"Driver_04"	"Haiphong"	"Saigon"	4.91	4.88	13	6	5	2
-- "Driver_03"	"Driver_05"	"Haiphong"	"Saigon"	4.91	4.85	13	18	5	5
-- "Driver_03"	"Driver_06"	"Haiphong"	"Haiphong"	4.91	3.65	13	21	5	4
-- "Driver_03"	"Driver_07"	"Haiphong"	"Saigon"	4.91	3.65	13	18	5	4
-- "Driver_03"	"Driver_08"	"Haiphong"	"Saigon"	4.91	4.33	13	20	5	1
-- "Driver_03"	"Driver_09"	"Haiphong"	"Hue"	4.91	4.52	13	14	5	5
-- "Driver_03"	"Driver_10"	"Haiphong"	"Hanoi"	4.91	4.00	13	19	5	0
-- "Driver_03"	"Driver_11"	"Haiphong"	"Haiphong"	4.91	4.30	13	16	5	5
-- "Driver_03"	"Driver_12"	"Haiphong"	"Hanoi"	4.91	4.38	13	17	5	3
-- "Driver_03"	"Driver_13"	"Haiphong"	"Hue"	4.91	4.94	13	11	5	2
-- "Driver_03"	"Driver_14"	"Haiphong"	"Saigon"	4.91	3.63	13	0	5	0
-- "Driver_03"	"Driver_15"	"Haiphong"	"Hue"	4.91	4.00	13	0	5	0
-- "Driver_09"	"Driver_01"	"Hue"	"Hue"	4.52	4.97	14	11	5	4
-- "Driver_09"	"Driver_02"	"Hue"	"Danang"	4.52	4.94	14	16	5	4
-- "Driver_09"	"Driver_03"	"Hue"	"Haiphong"	4.52	4.91	14	13	5	5
-- "Driver_09"	"Driver_04"	"Hue"	"Saigon"	4.52	4.88	14	6	5	2
-- "Driver_09"	"Driver_05"	"Hue"	"Saigon"	4.52	4.85	14	18	5	5
-- "Driver_09"	"Driver_06"	"Hue"	"Haiphong"	4.52	3.65	14	21	5	4
-- "Driver_09"	"Driver_07"	"Hue"	"Saigon"	4.52	3.65	14	18	5	4
-- "Driver_09"	"Driver_08"	"Hue"	"Saigon"	4.52	4.33	14	20	5	1
-- "Driver_09"	"Driver_10"	"Hue"	"Hanoi"	4.52	4.00	14	19	5	0
-- "Driver_09"	"Driver_11"	"Hue"	"Haiphong"	4.52	4.30	14	16	5	5
-- "Driver_09"	"Driver_12"	"Hue"	"Hanoi"	4.52	4.38	14	17	5	3
-- "Driver_09"	"Driver_13"	"Hue"	"Hue"	4.52	4.94	14	11	5	2
-- "Driver_09"	"Driver_14"	"Hue"	"Saigon"	4.52	3.63	14	0	5	0
-- "Driver_09"	"Driver_15"	"Hue"	"Hue"	4.52	4.00	14	0	5	0