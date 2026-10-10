-- 3.1.1 Active, highly rated drivers — the producers whose records
--    anchor the audit. Requirement: SELECT, WHERE, ORDER BY, LIMIT.
SELECT driver_id, driver_name, avg_rating
FROM  drivers
WHERE is_active = TRUE
AND avg_rating >= 4.5
ORDER BY avg_rating DESC
LIMIT 10;

-- RESULT:
-- driver_id | driver_name | avg_rating
--  1           Driver_01       4.97
--  2           Driver_02       4.94
--  13          Driver_13       4.94
--  4           Driver_04       4.88
--  5           Driver_05       4.85


-- 3.1.2 All possible trip statuses - Generate a list of all known statuses once
--      Requirement: SELECT, DISTINCT

SELECT DISTINCT trip_status
FROM  trips;

-- RESULT:
-- driver_id
--  disputed
--  completed
--  cancelled


-- 3.1.3 Subset of trips depending on filter in two ways - Generate a subset of trips in two
--      different ways using range and IN Requirement: SELECT, WHERE, BETWEEN, AND, IN

SELECT trip_id, rider_id, driver_id, pickup_city, fare_amount
FROM  trips
WHERE fare_amount BETWEEN 5.00 AND 6.00;

-- RESULT:
-- trip_id | rider_name | driver_id | pickup_city | fare_amount
--  76          2           6           Danang          5.24
--  91          24          7           Hue             5.59
--  93          19          7           Haiphong        5.73
--  141         20          10          Hanoi           5.16

SELECT trip_id, rider_id, driver_id, pickup_city
FROM  trips
WHERE pickup_city IN ('Haiphong');

-- RESULT:
-- trip_id | rider_id | driver_id | pickup_city
-- 1	14	1	"Haiphong"
-- 6	25	1	"Haiphong"
-- 7	4	1	"Haiphong"
-- 10	17	1	"Haiphong"
-- 18	28	2	"Haiphong"
-- 21	29	2	"Haiphong"
-- 22	30	2	"Haiphong"
-- 26	1	2	"Haiphong"
-- 46	7	4	"Haiphong"
-- 57	8	5	"Haiphong"
-- 58	26	5	"Haiphong"
-- 59	16	5	"Haiphong"
-- 77	1	6	"Haiphong"
-- 78	29	6	"Haiphong"
-- 81	16	6	"Haiphong"
-- 84	11	6	"Haiphong"
-- 89	6	7	"Haiphong"
-- 92	28	7	"Haiphong"
-- 93	19	7	"Haiphong"
-- 94	16	7	"Haiphong"
-- 98	8	7	"Haiphong"
-- 100	7	7	"Haiphong"
-- 101	24	7	"Haiphong"
-- 119	12	8	"Haiphong"
-- 122	6	8	"Haiphong"
-- 127	18	9	"Haiphong"
-- 132	3	9	"Haiphong"
-- 135	15	9	"Haiphong"
-- 145	2	10	"Haiphong"
-- 147	8	10	"Haiphong"
-- 160	21	11	"Haiphong"
-- 172	28	11	"Haiphong"
-- 173	21	12	"Haiphong"
-- 178	16	12	"Haiphong"
-- 182	13	12	"Haiphong"
-- 184	5	12	"Haiphong"
-- 191	27	13	"Haiphong"
-- 193	19	13	"Haiphong"
-- 199	5	13	"Haiphong"


-- 3.1.4 Drivers whose name match a certain pattern - Generate a list of drivers
--      that fulfill a certain text pattern and find a record whose value is missing
--      and replace them with 'No reason provided' Requirement: SELECT, WHERE, LIKE, COALESCE, LIMIT

SELECT driver_name
FROM drivers
WHERE driver_name LIKE 'Driver_1%';

-- RESULT:
-- driver_name
-- "Driver_10"
-- "Driver_11"
-- "Driver_12"
-- "Driver_13"
-- "Driver_14"
-- "Driver_15"

SELECT
    trip_id,
    trip_status,
    COALESCE(cancellation_reason, 'No reason provided')
        AS cancellation_reason
FROM trips
LIMIT 5;

-- RETURN:
-- trip_id | trip_status | cancellation_reason
-- 1	"completed"	"No reason provided"
-- 2	"completed"	"No reason provided"
-- 3	"completed"	"No reason provided"
-- 4	"cancelled"	"Rider no show"
-- 5	"disputed"	"No reason provided"

-- 3.1.5 Simplified Plain Text List- Generate a query that returns a list containing
--      plain text columns and renamed values Requirement: SELECT, AS, CASE, WHEN, THEN, ORDER BY, LIMIT

SELECT
    trip_id AS "Trip Number",
    pickup_city AS "Pickup City",
    fare_amount AS "Fare Amount",
    CASE
        WHEN fare_amount = 0 THEN 'No Fare Charged'
        WHEN fare_amount < 10 THEN 'Low Fare'
        WHEN fare_amount < 25 THEN 'Medium Fare'
        ELSE 'High Fare'
    END AS "Fare Category"
FROM trips
ORDER BY trip_id
LIMIT 20;

-- RETURNS:
-- Trip Number | Pickup City | Fare Amount | Fare Category
-- 1	"Haiphong"	19.74	"Medium Fare"
-- 2	"Danang"	7.40	"Low Fare"
-- 3	"Saigon"	22.43	"Medium Fare"
-- 4	"Hue"	0.00	"No Fare Charged"
-- 5	"Hanoi"	7.07	"Low Fare"
-- 6	"Haiphong"	21.89	"Medium Fare"
-- 7	"Haiphong"	26.17	"High Fare"
-- 8	"Hue"	0.00	"No Fare Charged"
-- 9	"Hue"	20.06	"Medium Fare"
-- 10	"Haiphong"	29.07	"High Fare"
-- 11	"Saigon"	22.46	"Medium Fare"
-- 12	"Hue"	0.00	"No Fare Charged"
-- 13	"Hanoi"	19.89	"Medium Fare"
-- 14	"Hanoi"	0.00	"No Fare Charged"
-- 15	"Hanoi"	20.29	"Medium Fare"
-- 16	"Hanoi"	19.83	"Medium Fare"
-- 17	"Hue"	29.42	"High Fare"
-- 18	"Haiphong"	47.81	"High Fare"
-- 19	"Saigon"	15.21	"Medium Fare"
-- 20	"Danang"	13.50	"Medium Fare"