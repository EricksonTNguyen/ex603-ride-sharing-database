-- Two-Step Question: Which Riders took trips that were disputed?

-- 3.3.1 - Subquery using IN or NOT IN - Requirements: SELECT, WHERE, IN, ORDER BY

SELECT r.rider_id, r.rider_name
FROM riders AS r
WHERE r.rider_id IN (
    SELECT t.rider_id
    FROM trips AS t
    WHERE t.trip_status = 'disputed'
)
ORDER BY r.rider_id;

-- 3.3.2 - Subquery with a CTE using WITH - Requirements: SELECT, DISTINCT, WHERE, JOIN, ORDER BY

WITH disputed_riders AS (
    SELECT DISTINCT rider_id
    FROM trips
    WHERE trip_status = 'disputed'
)
SELECT r.rider_id, r.rider_name
FROM riders AS r
JOIN disputed_riders AS d
    ON r.rider_id = d.rider_id
ORDER BY r.rider_id;

-- 3.3.3 - CASE-based subquery or set based approach - Requirements: SELECT, WHERE EXISTS, WHERE, ORDER BY

SELECT r.rider_id, r.rider_name
FROM riders AS r
WHERE EXISTS (
    SELECT 1
    FROM trips AS t
    WHERE t.rider_id = r.rider_id
      AND t.trip_status = 'disputed'
)
ORDER BY r.rider_id;

-- 3.3.4 - Show resultant output all match from 3.3.1 - 3.3.3

-- RESULT:
-- rider_id | rider_name
-- 1	        "Rider_01"
-- 3	        "Rider_03"
-- 5	        "Rider_05"
-- 9	        "Rider_09"
-- 16	        "Rider_16"
-- 24	        "Rider_24"
-- 25	        "Rider_25"

-- 3.3.5 - name one input condition where the three would not be equivalent

-- The omission of DISTINCT from the CTE based query would cause it to return with duplicates.
-- This would make it so that the three queries wouldn't match. The IN based and distinct queries will continue to remain the same
-- but the CTE based one will return duplicates. Thus I had to add the distinct keyword into the query.