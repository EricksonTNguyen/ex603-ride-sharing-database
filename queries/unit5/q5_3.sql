-- 5.3.A Write a CROSS JOIN between two small tables.
-- Requirement: SELECT, COUNT, CROSS JOIN, ORDER BY

-- 1.
SELECT COUNT(*) AS total_drivers
FROM drivers;

-- RESULTS:
-- total_drivers
-- 15

SELECT COUNT(*) AS total_badges
FROM driver_badges;

-- RESULTS:
-- total_badges
-- 5

-- 2.
SELECT
    d.driver_name,
    b.badge_name
FROM drivers AS d
CROSS JOIN driver_badges AS b
ORDER BY d.driver_id, b.badge_id;

-- RESULTS:
-- driver_name | badge_name
-- "Driver_01"	"Safe Driving"
-- "Driver_01"	"Clean Car"
-- "Driver_01"	"Night Owl"
-- "Driver_01"	"Airport Pro"
-- "Driver_01"	"Five Star"
-- "Driver_02"	"Safe Driving"
-- "Driver_02"	"Clean Car"
-- "Driver_02"	"Night Owl"
-- "Driver_02"	"Airport Pro"
-- "Driver_02"	"Five Star"
-- "Driver_03"	"Safe Driving"
-- "Driver_03"	"Clean Car"
-- "Driver_03"	"Night Owl"
-- "Driver_03"	"Airport Pro"
-- "Driver_03"	"Five Star"
-- "Driver_04"	"Safe Driving"
-- "Driver_04"	"Clean Car"
-- "Driver_04"	"Night Owl"
-- "Driver_04"	"Airport Pro"
-- "Driver_04"	"Five Star"
-- "Driver_05"	"Safe Driving"
-- "Driver_05"	"Clean Car"
-- "Driver_05"	"Night Owl"
-- "Driver_05"	"Airport Pro"
-- "Driver_05"	"Five Star"
-- "Driver_06"	"Safe Driving"
-- "Driver_06"	"Clean Car"
-- "Driver_06"	"Night Owl"
-- "Driver_06"	"Airport Pro"
-- "Driver_06"	"Five Star"
-- "Driver_07"	"Safe Driving"
-- "Driver_07"	"Clean Car"
-- "Driver_07"	"Night Owl"
-- "Driver_07"	"Airport Pro"
-- "Driver_07"	"Five Star"
-- "Driver_08"	"Safe Driving"
-- "Driver_08"	"Clean Car"
-- "Driver_08"	"Night Owl"
-- "Driver_08"	"Airport Pro"
-- "Driver_08"	"Five Star"
-- "Driver_09"	"Safe Driving"
-- "Driver_09"	"Clean Car"
-- "Driver_09"	"Night Owl"
-- "Driver_09"	"Airport Pro"
-- "Driver_09"	"Five Star"
-- "Driver_10"	"Safe Driving"
-- "Driver_10"	"Clean Car"
-- "Driver_10"	"Night Owl"
-- "Driver_10"	"Airport Pro"
-- "Driver_10"	"Five Star"
-- "Driver_11"	"Safe Driving"
-- "Driver_11"	"Clean Car"
-- "Driver_11"	"Night Owl"
-- "Driver_11"	"Airport Pro"
-- "Driver_11"	"Five Star"
-- "Driver_12"	"Safe Driving"
-- "Driver_12"	"Clean Car"
-- "Driver_12"	"Night Owl"
-- "Driver_12"	"Airport Pro"
-- "Driver_12"	"Five Star"
-- "Driver_13"	"Safe Driving"
-- "Driver_13"	"Clean Car"
-- "Driver_13"	"Night Owl"
-- "Driver_13"	"Airport Pro"
-- "Driver_13"	"Five Star"
-- "Driver_14"	"Safe Driving"
-- "Driver_14"	"Clean Car"
-- "Driver_14"	"Night Owl"
-- "Driver_14"	"Airport Pro"
-- "Driver_14"	"Five Star"
-- "Driver_15"	"Safe Driving"
-- "Driver_15"	"Clean Car"
-- "Driver_15"	"Night Owl"
-- "Driver_15"	"Airport Pro"
-- "Driver_15"	"Five Star"

-- 3.
SELECT COUNT(*) AS cross_join_rows
FROM drivers AS d
CROSS JOIN driver_badges AS b;

-- RESULTS:
-- cross_join_rows
-- 75

-- The total amount of rows of the driver table is 15. The total amount of rows in the badge table is 5. 15 * 5 = 75

-- QUESTION 4: A Cartesian product can be useful when you want to generate every possible combination of two sets of data. For example, it could help create a report showing every driver and every available badge to evaluate potential badge assignments.
-- However, a CROSS JOIN can indicate a query error if the intent was to retrieve only actual driver-to-badge relationships. It does not check whether a driver earned a badge, so it can produce many unnecessary combinations that don't pertain to actual assignment.

-- 5.3.B Three-Table Join Query Analysis
-- Requirement: EXPLAIN, ANALYZE, SELECT, JOIN, ORDER BY

EXPLAIN ANALYZE
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


-- QUESTION 1: 
-- "Sort  (cost=35.98..36.48 rows=200 width=532) (actual time=0.151..0.155 rows=200 loops=1)"
-- "  Sort Key: t.requested_at"
-- "  Sort Method: quicksort  Memory: 40kB"
-- "  ->  Nested Loop  (cost=12.40..28.34 rows=200 width=532) (actual time=0.051..0.121 rows=200 loops=1)"
-- "        ->  Hash Join  (cost=12.25..17.80 rows=200 width=278) (actual time=0.037..0.070 rows=200 loops=1)"
-- "              Hash Cond: (t.rider_id = r.rider_id)"
-- "              ->  Seq Scan on trips t  (cost=0.00..5.00 rows=200 width=24) (actual time=0.013..0.026 rows=200 loops=1)"
-- "              ->  Hash  (cost=11.00..11.00 rows=100 width=262) (actual time=0.015..0.015 rows=30 loops=1)"
-- "                    Buckets: 1024  Batches: 1  Memory Usage: 10kB"
-- "                    ->  Seq Scan on riders r  (cost=0.00..11.00 rows=100 width=262) (actual time=0.007..0.009 rows=30 loops=1)"
-- "        ->  Memoize  (cost=0.15..0.41 rows=1 width=262) (actual time=0.000..0.000 rows=1 loops=200)"
-- "              Cache Key: t.driver_id"
-- "              Cache Mode: logical"
-- "              Hits: 187  Misses: 13  Evictions: 0  Overflows: 0  Memory Usage: 2kB"
-- "              ->  Index Scan using drivers_pkey on drivers d  (cost=0.14..0.40 rows=1 width=262) (actual time=0.001..0.001 rows=1 loops=13)"
-- "                    Index Cond: (driver_id = t.driver_id)"
-- "Planning Time: 0.141 ms"
-- "Execution Time: 0.193 ms"

-- QUESTION 2:
-- "  ->  Nested Loop  (cost=12.40..28.34 rows=200 width=532) (actual time=0.051..0.121 rows=200 loops=1)"
-- "        ->  Hash Join  (cost=12.25..17.80 rows=200 width=278) (actual time=0.037..0.070 rows=200 loops=1)"

-- QUESTION 3:
-- The dataset is relatively small. Postgres may have chosen sequential scanning and hash joins because reading these small tables directly and building hash tables could be less expensive than performing repeated index lookups.

-- QUESTION 4:
-- As the dataset grows, joining the trips table to the riders and drivers tables may require more processing because PostgreSQL must match more trip records. Sorting all matching trips by requested_at could also become more expensive.