-- 3.2a.1 - Pick a nullable column on your event or producer table.
-- CHOSEN NULLABLE COLUMN: trips.cancellation_reason

-- 3.2a.2 - Query with negation or inequality that predicate on that column, forces an omission
--         without error or notification. Requirements: SELECT, WHERE

SELECT trip_id, trip_status, cancellation_reason
FROM trips
WHERE cancellation_reason != 'Rider cancelled';

-- RESULT:
-- trip_id | trip_status | cancellation_reason
-- 4	"cancelled"	"Rider no show"
-- 8	"cancelled"	"Payment failed"
-- 12	"cancelled"	"Rider no show"
-- 14	"cancelled"	"Driver unavailable"
-- 21	"cancelled"	"Rider no show"
-- 26	"cancelled"	"Rider no show"
-- 31	"cancelled"	"Rider no show"
-- 40	"cancelled"	"Rider no show"
-- 44	"cancelled"	"Payment failed"
-- 46	"cancelled"	"Rider no show"
-- 57	"cancelled"	"Payment failed"
-- 65	"cancelled"	"Rider no show"
-- 66	"cancelled"	"Payment failed"
-- 74	"cancelled"	"Driver unavailable"
-- 75	"cancelled"	"Driver unavailable"
-- 87	"cancelled"	"Payment failed"
-- 103	"cancelled"	"Rider no show"
-- 120	"cancelled"	"Payment failed"
-- 125	"cancelled"	"Rider no show"
-- 134	"cancelled"	"Driver unavailable"
-- 136	"cancelled"	"Driver unavailable"
-- 162	"cancelled"	"Driver unavailable"
-- 163	"cancelled"	"Rider no show"
-- 168	"cancelled"	"Driver unavailable"
-- 171	"cancelled"	"Payment failed"
-- 181	"cancelled"	"Rider no show"

-- 3.2a.3 - Two queries displaying count of results from 3.2a_2 and 
--         one of the rows omitted to show discrepency. Requirements: SELECT, WHERE

SELECT COUNT(*)
FROM trips
WHERE cancellation_reason != 'Rider cancelled';

-- RETURNS: 26

SELECT COUNT(*)
FROM trips
WHERE cancellation_reason IS NULL;

-- RETURNS: 166

-- Total rows: 200 != (26 + 166)

-- 3.2a.4 Repaired Query fixing omission problem, Requirements: SELECT, WHERE, OR, IS NULL

SELECT trip_id, trip_status, cancellation_reason
FROM trips
WHERE cancellation_reason != 'Rider cancelled'
   OR cancellation_reason IS NULL;


------------------------------------------------------------------------------------------

-- 3.2b.1 Query that displays the error of using an alias and referencing it in WHERE.
--      Requirements: SELECT, CASE, WHERE, WHEN, THEN

SELECT
    trip_id,
    fare_amount,
    CASE
        WHEN fare_amount = 0 THEN 'No Fare Charged'
        WHEN fare_amount < 10 THEN 'Low Fare'
        WHEN fare_amount < 25 THEN 'Medium Fare'
        ELSE 'High Fare'
    END AS fare_category
FROM trips
WHERE fare_category = 'Low Fare';

-- RESULT: ERROR:  column "fare_category" does not exist
-- LINE 11: WHERE fare_category = 'Low Fare';
--                ^ 
-- SQL state: 42703
-- Character: 261

-- 3.2b.2 2 queries, one repeating expression in WHERE, the other using a CTE
--      Requirements:

SELECT
    trip_id,
    fare_amount,
    CASE
        WHEN fare_amount = 0 THEN 'No Fare Charged'
        WHEN fare_amount < 10 THEN 'Low Fare'
        WHEN fare_amount < 25 THEN 'Medium Fare'
        ELSE 'High Fare'
    END AS fare_category
FROM trips
WHERE CASE
        WHEN fare_amount = 0 THEN 'No Fare Charged'
        WHEN fare_amount < 10 THEN 'Low Fare'
        WHEN fare_amount < 25 THEN 'Medium Fare'
        ELSE 'High Fare'
      END = 'Low Fare';

--------------------------------------------------------

WITH fare_types AS (
    SELECT
        trip_id,
        fare_amount,
        CASE
            WHEN fare_amount = 0 THEN 'No Fare Charged'
            WHEN fare_amount < 10 THEN 'Low Fare'
            WHEN fare_amount < 25 THEN 'Medium Fare'
            ELSE 'High Fare'
        END AS fare_category
    FROM trips
)
SELECT
    trip_id,
    fare_amount,
    fare_category
FROM fare_types
WHERE fare_category = 'Low Fare';