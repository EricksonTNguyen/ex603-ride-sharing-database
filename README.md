# EX603 Ride Sharing Database

Name: Erickson Nguyen

Theme: Ride Sharing

Repository Purpose: Contains a Postgres SQL Database for ride sharing.

Questions to be answered:

1. Project title and one-line summary — what system you modelled, in a sentence.
2. The domain — your theme and the questions the platform must answer. Two to three paragraphs.
3. Schema — embed the ERD image; summarize the five roles and your key design decisions.
4. Query catalogue — per unit, a short table listing the queries and the business question each answers, linked to the .sql files.
5. Technical highlights — three to five things a reader should notice.
6. What I would do differently — an honest paragraph. Critiquing your own work is a senior signal, not a weakness.
7. Video presentation — embed or link the video.
8. How to run it — the commands to create the schema and execute a query. Assume the reader has a database and nothing else.

# Schema

## Tables

1. Riders - Table containing all riders
2. Drivers - Table containing all drivers
3. Badges - Table containing types of badges
4. Trips - Table containing all trips, has linkages to Riders and Drivers
5. Awards - Table containing all awards, has linkages to Drivers and Badges

## Design Decisions

1. `Awards` uses `(driver_id, badge_id)` as a composite primary key because it represents the relationship between a driver and a badge.
2. `RESTRICT` is used for `Trips` foreign keys to preserve historical trip records.
3. `CASCADE` is used for `Awards` foreign keys because award records represent relationships dependent on their referenced driver and badge.
4. The specified rules for driver filters, trip duration, and trip fares are implemented as database CHECK constraints.
5. `Trips.pickup_time` is explicitly required with `NOT NULL`.
6. The implementation is intended for PostgreSQL 14 and avoids MySQL-specific syntax.