-- 5.2.A Write two queries to compare the results of an inner join and a left join.
-- Requirement: SELECT, LEFT JOIN, GROUP BY, ORDER BY, INNER JOIN, DISTINCT, COUNT

-- QUERY 1 - LEFT JOIN
SELECT
    d.driver_id,
    d.driver_name,
    COUNT(t.trip_id) AS total_trips
FROM drivers AS d
LEFT JOIN trips AS t
    ON d.driver_id = t.driver_id
GROUP BY
    d.driver_id,
    d.driver_name
ORDER BY d.driver_id;

-- RESULTS:
-- driver_id | driver_name | total_trips
-- 1	"Driver_01"	11
-- 2	"Driver_02"	16
-- 3	"Driver_03"	13
-- 4	"Driver_04"	6
-- 5	"Driver_05"	18
-- 6	"Driver_06"	21
-- 7	"Driver_07"	18
-- 8	"Driver_08"	20
-- 9	"Driver_09"	14
-- 10	"Driver_10"	19
-- 11	"Driver_11"	16
-- 12	"Driver_12"	17
-- 13	"Driver_13"	11
-- 14	"Driver_14"	0
-- 15	"Driver_15"	0

--QUERY 2 - INNER JOIN
SELECT
    d.driver_id,
    d.driver_name,
    COUNT(t.trip_id) AS total_trips
FROM drivers AS d
INNER JOIN trips AS t
    ON d.driver_id = t.driver_id
GROUP BY
    d.driver_id,
    d.driver_name
ORDER BY d.driver_id;

--RESULTS:
-- driver_id | driver_name | total_trips
-- 1	"Driver_01"	11
-- 2	"Driver_02"	16
-- 3	"Driver_03"	13
-- 4	"Driver_04"	6
-- 5	"Driver_05"	18
-- 6	"Driver_06"	21
-- 7	"Driver_07"	18
-- 8	"Driver_08"	20
-- 9	"Driver_09"	14
-- 10	"Driver_10"	19
-- 11	"Driver_11"	16
-- 12	"Driver_12"	17
-- 13	"Driver_13"	11

-- Question 3: Two producers are missing.
SELECT
    COUNT(DISTINCT d.driver_id) AS excluded_driver_count
FROM drivers AS d
LEFT JOIN trips AS t
    ON d.driver_id = t.driver_id
WHERE t.trip_id IS NULL;

-- RESULTS:
-- excluded_driver_count
--          2

-- Question 4: Driver 14 and Driver 15 are missing. Driver_14 and Driver_15 are missing because neither has a record in the trips table.
-- This  means they have no recorded trips in the trips table.

SELECT
    d.driver_id,
    d.driver_name
FROM drivers AS d
LEFT JOIN trips AS t
    ON d.driver_id = t.driver_id
WHERE t.trip_id IS NULL
ORDER BY d.driver_id;

-- RESULTS:
-- driver_id | driver_name
-- 14	"Driver_14"
-- 15	"Driver_15"

-- 5.2.B Write two queries to compare the results of an RIGHT JOIN and an FULL OUTER JOIN.
-- Requirement: SELECT, RIGHT JOIN, GROUP BY, ORDER BY, FULL OUTER JOIN, DISTINCT, COUNT, WHEN

-- QUERY 1 - RIGHT JOIN
SELECT
    d.driver_id,
    d.driver_name,
    COUNT(t.trip_id) AS total_trips
FROM trips AS t
RIGHT JOIN drivers AS d
    ON t.driver_id = d.driver_id
GROUP BY
    d.driver_id,
    d.driver_name
ORDER BY d.driver_id;

-- RESULTS:
-- driver_id | driver_name | total_trips
-- 1	"Driver_01"	11
-- 2	"Driver_02"	16
-- 3	"Driver_03"	13
-- 4	"Driver_04"	6
-- 5	"Driver_05"	18
-- 6	"Driver_06"	21
-- 7	"Driver_07"	18
-- 8	"Driver_08"	20
-- 9	"Driver_09"	14
-- 10	"Driver_10"	19
-- 11	"Driver_11"	16
-- 12	"Driver_12"	17
-- 13	"Driver_13"	11
-- 14	"Driver_14"	0
-- 15	"Driver_15"	0

-- QUESTION 2: Verifying the results from the LEFT JOIN and RIGHT JOIN query, I can confirm that they match.

-- QUESTION 3:
SELECT
    d.driver_id,
    d.driver_name,
    t.trip_id,
    t.driver_id AS trip_driver_id,
    CASE
        WHEN d.driver_id IS NULL THEN 'Unmatched trip'
        WHEN t.trip_id IS NULL THEN 'Driver with no trips'
        ELSE 'Matched driver and trip'
    END AS record_status
FROM drivers AS d
FULL OUTER JOIN trips AS t
    ON d.driver_id = t.driver_id
ORDER BY
    d.driver_id,
    t.trip_id;

-- RESULTS:
-- driver_id | driver_name | trip_id | trip_driver_id | record_status
-- 1	"Driver_01"	1	1	"Matched driver and trip"
-- 1	"Driver_01"	2	1	"Matched driver and trip"
-- 1	"Driver_01"	3	1	"Matched driver and trip"
-- 1	"Driver_01"	4	1	"Matched driver and trip"
-- 1	"Driver_01"	5	1	"Matched driver and trip"
-- 1	"Driver_01"	6	1	"Matched driver and trip"
-- 1	"Driver_01"	7	1	"Matched driver and trip"
-- 1	"Driver_01"	8	1	"Matched driver and trip"
-- 1	"Driver_01"	9	1	"Matched driver and trip"
-- 1	"Driver_01"	10	1	"Matched driver and trip"
-- 1	"Driver_01"	11	1	"Matched driver and trip"
-- 2	"Driver_02"	12	2	"Matched driver and trip"
-- 2	"Driver_02"	13	2	"Matched driver and trip"
-- 2	"Driver_02"	14	2	"Matched driver and trip"
-- 2	"Driver_02"	15	2	"Matched driver and trip"
-- 2	"Driver_02"	16	2	"Matched driver and trip"
-- 2	"Driver_02"	17	2	"Matched driver and trip"
-- 2	"Driver_02"	18	2	"Matched driver and trip"
-- 2	"Driver_02"	19	2	"Matched driver and trip"
-- 2	"Driver_02"	20	2	"Matched driver and trip"
-- 2	"Driver_02"	21	2	"Matched driver and trip"
-- 2	"Driver_02"	22	2	"Matched driver and trip"
-- 2	"Driver_02"	23	2	"Matched driver and trip"
-- 2	"Driver_02"	24	2	"Matched driver and trip"
-- 2	"Driver_02"	25	2	"Matched driver and trip"
-- 2	"Driver_02"	26	2	"Matched driver and trip"
-- 2	"Driver_02"	27	2	"Matched driver and trip"
-- 3	"Driver_03"	28	3	"Matched driver and trip"
-- 3	"Driver_03"	29	3	"Matched driver and trip"
-- 3	"Driver_03"	30	3	"Matched driver and trip"
-- 3	"Driver_03"	31	3	"Matched driver and trip"
-- 3	"Driver_03"	32	3	"Matched driver and trip"
-- 3	"Driver_03"	33	3	"Matched driver and trip"
-- 3	"Driver_03"	34	3	"Matched driver and trip"
-- 3	"Driver_03"	35	3	"Matched driver and trip"
-- 3	"Driver_03"	36	3	"Matched driver and trip"
-- 3	"Driver_03"	37	3	"Matched driver and trip"
-- 3	"Driver_03"	38	3	"Matched driver and trip"
-- 3	"Driver_03"	39	3	"Matched driver and trip"
-- 3	"Driver_03"	40	3	"Matched driver and trip"
-- 4	"Driver_04"	41	4	"Matched driver and trip"
-- 4	"Driver_04"	42	4	"Matched driver and trip"
-- 4	"Driver_04"	43	4	"Matched driver and trip"
-- 4	"Driver_04"	44	4	"Matched driver and trip"
-- 4	"Driver_04"	45	4	"Matched driver and trip"
-- 4	"Driver_04"	46	4	"Matched driver and trip"
-- 5	"Driver_05"	47	5	"Matched driver and trip"
-- 5	"Driver_05"	48	5	"Matched driver and trip"
-- 5	"Driver_05"	49	5	"Matched driver and trip"
-- 5	"Driver_05"	50	5	"Matched driver and trip"
-- 5	"Driver_05"	51	5	"Matched driver and trip"
-- 5	"Driver_05"	52	5	"Matched driver and trip"
-- 5	"Driver_05"	53	5	"Matched driver and trip"
-- 5	"Driver_05"	54	5	"Matched driver and trip"
-- 5	"Driver_05"	55	5	"Matched driver and trip"
-- 5	"Driver_05"	56	5	"Matched driver and trip"
-- 5	"Driver_05"	57	5	"Matched driver and trip"
-- 5	"Driver_05"	58	5	"Matched driver and trip"
-- 5	"Driver_05"	59	5	"Matched driver and trip"
-- 5	"Driver_05"	60	5	"Matched driver and trip"
-- 5	"Driver_05"	61	5	"Matched driver and trip"
-- 5	"Driver_05"	62	5	"Matched driver and trip"
-- 5	"Driver_05"	63	5	"Matched driver and trip"
-- 5	"Driver_05"	64	5	"Matched driver and trip"
-- 6	"Driver_06"	65	6	"Matched driver and trip"
-- 6	"Driver_06"	66	6	"Matched driver and trip"
-- 6	"Driver_06"	67	6	"Matched driver and trip"
-- 6	"Driver_06"	68	6	"Matched driver and trip"
-- 6	"Driver_06"	69	6	"Matched driver and trip"
-- 6	"Driver_06"	70	6	"Matched driver and trip"
-- 6	"Driver_06"	71	6	"Matched driver and trip"
-- 6	"Driver_06"	72	6	"Matched driver and trip"
-- 6	"Driver_06"	73	6	"Matched driver and trip"
-- 6	"Driver_06"	74	6	"Matched driver and trip"
-- 6	"Driver_06"	75	6	"Matched driver and trip"
-- 6	"Driver_06"	76	6	"Matched driver and trip"
-- 6	"Driver_06"	77	6	"Matched driver and trip"
-- 6	"Driver_06"	78	6	"Matched driver and trip"
-- 6	"Driver_06"	79	6	"Matched driver and trip"
-- 6	"Driver_06"	80	6	"Matched driver and trip"
-- 6	"Driver_06"	81	6	"Matched driver and trip"
-- 6	"Driver_06"	82	6	"Matched driver and trip"
-- 6	"Driver_06"	83	6	"Matched driver and trip"
-- 6	"Driver_06"	84	6	"Matched driver and trip"
-- 6	"Driver_06"	85	6	"Matched driver and trip"
-- 7	"Driver_07"	86	7	"Matched driver and trip"
-- 7	"Driver_07"	87	7	"Matched driver and trip"
-- 7	"Driver_07"	88	7	"Matched driver and trip"
-- 7	"Driver_07"	89	7	"Matched driver and trip"
-- 7	"Driver_07"	90	7	"Matched driver and trip"
-- 7	"Driver_07"	91	7	"Matched driver and trip"
-- 7	"Driver_07"	92	7	"Matched driver and trip"
-- 7	"Driver_07"	93	7	"Matched driver and trip"
-- 7	"Driver_07"	94	7	"Matched driver and trip"
-- 7	"Driver_07"	95	7	"Matched driver and trip"
-- 7	"Driver_07"	96	7	"Matched driver and trip"
-- 7	"Driver_07"	97	7	"Matched driver and trip"
-- 7	"Driver_07"	98	7	"Matched driver and trip"
-- 7	"Driver_07"	99	7	"Matched driver and trip"
-- 7	"Driver_07"	100	7	"Matched driver and trip"
-- 7	"Driver_07"	101	7	"Matched driver and trip"
-- 7	"Driver_07"	102	7	"Matched driver and trip"
-- 7	"Driver_07"	103	7	"Matched driver and trip"
-- 8	"Driver_08"	104	8	"Matched driver and trip"
-- 8	"Driver_08"	105	8	"Matched driver and trip"
-- 8	"Driver_08"	106	8	"Matched driver and trip"
-- 8	"Driver_08"	107	8	"Matched driver and trip"
-- 8	"Driver_08"	108	8	"Matched driver and trip"
-- 8	"Driver_08"	109	8	"Matched driver and trip"
-- 8	"Driver_08"	110	8	"Matched driver and trip"
-- 8	"Driver_08"	111	8	"Matched driver and trip"
-- 8	"Driver_08"	112	8	"Matched driver and trip"
-- 8	"Driver_08"	113	8	"Matched driver and trip"
-- 8	"Driver_08"	114	8	"Matched driver and trip"
-- 8	"Driver_08"	115	8	"Matched driver and trip"
-- 8	"Driver_08"	116	8	"Matched driver and trip"
-- 8	"Driver_08"	117	8	"Matched driver and trip"
-- 8	"Driver_08"	118	8	"Matched driver and trip"
-- 8	"Driver_08"	119	8	"Matched driver and trip"
-- 8	"Driver_08"	120	8	"Matched driver and trip"
-- 8	"Driver_08"	121	8	"Matched driver and trip"
-- 8	"Driver_08"	122	8	"Matched driver and trip"
-- 8	"Driver_08"	123	8	"Matched driver and trip"
-- 9	"Driver_09"	124	9	"Matched driver and trip"
-- 9	"Driver_09"	125	9	"Matched driver and trip"
-- 9	"Driver_09"	126	9	"Matched driver and trip"
-- 9	"Driver_09"	127	9	"Matched driver and trip"
-- 9	"Driver_09"	128	9	"Matched driver and trip"
-- 9	"Driver_09"	129	9	"Matched driver and trip"
-- 9	"Driver_09"	130	9	"Matched driver and trip"
-- 9	"Driver_09"	131	9	"Matched driver and trip"
-- 9	"Driver_09"	132	9	"Matched driver and trip"
-- 9	"Driver_09"	133	9	"Matched driver and trip"
-- 9	"Driver_09"	134	9	"Matched driver and trip"
-- 9	"Driver_09"	135	9	"Matched driver and trip"
-- 9	"Driver_09"	136	9	"Matched driver and trip"
-- 9	"Driver_09"	137	9	"Matched driver and trip"
-- 10	"Driver_10"	138	10	"Matched driver and trip"
-- 10	"Driver_10"	139	10	"Matched driver and trip"
-- 10	"Driver_10"	140	10	"Matched driver and trip"
-- 10	"Driver_10"	141	10	"Matched driver and trip"
-- 10	"Driver_10"	142	10	"Matched driver and trip"
-- 10	"Driver_10"	143	10	"Matched driver and trip"
-- 10	"Driver_10"	144	10	"Matched driver and trip"
-- 10	"Driver_10"	145	10	"Matched driver and trip"
-- 10	"Driver_10"	146	10	"Matched driver and trip"
-- 10	"Driver_10"	147	10	"Matched driver and trip"
-- 10	"Driver_10"	148	10	"Matched driver and trip"
-- 10	"Driver_10"	149	10	"Matched driver and trip"
-- 10	"Driver_10"	150	10	"Matched driver and trip"
-- 10	"Driver_10"	151	10	"Matched driver and trip"
-- 10	"Driver_10"	152	10	"Matched driver and trip"
-- 10	"Driver_10"	153	10	"Matched driver and trip"
-- 10	"Driver_10"	154	10	"Matched driver and trip"
-- 10	"Driver_10"	155	10	"Matched driver and trip"
-- 10	"Driver_10"	156	10	"Matched driver and trip"
-- 11	"Driver_11"	157	11	"Matched driver and trip"
-- 11	"Driver_11"	158	11	"Matched driver and trip"
-- 11	"Driver_11"	159	11	"Matched driver and trip"
-- 11	"Driver_11"	160	11	"Matched driver and trip"
-- 11	"Driver_11"	161	11	"Matched driver and trip"
-- 11	"Driver_11"	162	11	"Matched driver and trip"
-- 11	"Driver_11"	163	11	"Matched driver and trip"
-- 11	"Driver_11"	164	11	"Matched driver and trip"
-- 11	"Driver_11"	165	11	"Matched driver and trip"
-- 11	"Driver_11"	166	11	"Matched driver and trip"
-- 11	"Driver_11"	167	11	"Matched driver and trip"
-- 11	"Driver_11"	168	11	"Matched driver and trip"
-- 11	"Driver_11"	169	11	"Matched driver and trip"
-- 11	"Driver_11"	170	11	"Matched driver and trip"
-- 11	"Driver_11"	171	11	"Matched driver and trip"
-- 11	"Driver_11"	172	11	"Matched driver and trip"
-- 12	"Driver_12"	173	12	"Matched driver and trip"
-- 12	"Driver_12"	174	12	"Matched driver and trip"
-- 12	"Driver_12"	175	12	"Matched driver and trip"
-- 12	"Driver_12"	176	12	"Matched driver and trip"
-- 12	"Driver_12"	177	12	"Matched driver and trip"
-- 12	"Driver_12"	178	12	"Matched driver and trip"
-- 12	"Driver_12"	179	12	"Matched driver and trip"
-- 12	"Driver_12"	180	12	"Matched driver and trip"
-- 12	"Driver_12"	181	12	"Matched driver and trip"
-- 12	"Driver_12"	182	12	"Matched driver and trip"
-- 12	"Driver_12"	183	12	"Matched driver and trip"
-- 12	"Driver_12"	184	12	"Matched driver and trip"
-- 12	"Driver_12"	185	12	"Matched driver and trip"
-- 12	"Driver_12"	186	12	"Matched driver and trip"
-- 12	"Driver_12"	187	12	"Matched driver and trip"
-- 12	"Driver_12"	188	12	"Matched driver and trip"
-- 12	"Driver_12"	189	12	"Matched driver and trip"
-- 13	"Driver_13"	190	13	"Matched driver and trip"
-- 13	"Driver_13"	191	13	"Matched driver and trip"
-- 13	"Driver_13"	192	13	"Matched driver and trip"
-- 13	"Driver_13"	193	13	"Matched driver and trip"
-- 13	"Driver_13"	194	13	"Matched driver and trip"
-- 13	"Driver_13"	195	13	"Matched driver and trip"
-- 13	"Driver_13"	196	13	"Matched driver and trip"
-- 13	"Driver_13"	197	13	"Matched driver and trip"
-- 13	"Driver_13"	198	13	"Matched driver and trip"
-- 13	"Driver_13"	199	13	"Matched driver and trip"
-- 13	"Driver_13"	200	13	"Matched driver and trip"
-- 14	"Driver_14"			"Driver with no trips"
-- 15	"Driver_15"			"Driver with no trips"

-- QUESTION 4: A FULL OUTER JOIN can reveal unmatched records from both tables. A LEFT JOIN preserves unmatched drivers, while a RIGHT JOIN preserves unmatched trips when the tables are ordered as in the RIGHT JOIN query above.
-- This makes the full outer join useful for identifying potential data linkage issues such as trips referencing drivers that do not exist in the drivers table.


-- 5.2.C Write two queries that identify producers who have never had an event and compare them.
-- Requirement: SELECT, WHERE, NOT EXISTS, EXCEPT, ORDER BY

-- NOT EXISTS QUERY:
SELECT
    d.driver_id,
    d.driver_name
FROM drivers AS d
WHERE NOT EXISTS (
    SELECT 1
    FROM trips AS t
    WHERE t.driver_id = d.driver_id
)
ORDER BY d.driver_id;

-- RESULTS:
-- driver_id | driver_name
-- 14	"Driver_14"
-- 15	"Driver_15"

--EXCEPT QUERY:
SELECT driver_id, driver_name
FROM drivers

EXCEPT

SELECT d.driver_id, d.driver_name
FROM drivers AS d
JOIN trips AS t
    ON d.driver_id = t.driver_id

ORDER BY driver_id;

-- RESULTS:
-- driver_id | driver_name
-- 14	"Driver_14"
-- 15	"Driver_15"

-- The NOT EXISTS query checks each driver for a missing trip value. The EXCEPT query subtracts the drivers who have trips from the complete list of drivers. Both queries return the same producers.