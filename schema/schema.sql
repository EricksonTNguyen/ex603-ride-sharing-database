-- =================================================================
-- EX 603 Assignment 2 — schema.sql
-- Theme: Ride Sharing
-- Author: Erickson Nguyen
-- Target: PostgreSQL 14+
-- =================================================================
-- Reset. Reverse creation order, so no dependency blocks a drop.
DROP TABLE IF EXISTS Awards CASCADE;
DROP TABLE IF EXISTS Trips CASCADE;
DROP TABLE IF EXISTS Badges CASCADE;
DROP TABLE IF EXISTS Drivers CASCADE;
DROP TABLE IF EXISTS Riders CASCADE;
-- ----------------------------------------------------------------
-- 1. Riders — first, because it references nothing but itself.
--  Primary Key: rider_id
-- ----------------------------------------------------------------
CREATE TABLE Riders (
    rider_id INTEGER GENERATED ALWAYS AS IDENTITY,
    r_name VARCHAR(100),

    CONSTRAINT pk_riders PRIMARY KEY (rider_id)
);
-- ----------------------------------------------------------------
-- 2. Drivers — second, because it references nothing but itself.
--  Primary Key: driver_id
--  Check: Filter must be greater than zero
-- ----------------------------------------------------------------
CREATE TABLE Drivers (
    driver_id INTEGER GENERATED ALWAYS AS IDENTITY,
    d_name VARCHAR(100),
    flag VARCHAR(1),
    filter INT,

    CONSTRAINT pk_drivers PRIMARY KEY (driver_id),

    CONSTRAINT chk_drivers_filter CHECK (filter >= 0)
);
-- ----------------------------------------------------------------
-- 3. Badges — third, because it references nothing but itself.
--  Primary Key: badge_id
-- ----------------------------------------------------------------
CREATE TABLE Badges (
    badge_id INTEGER GENERATED ALWAYS AS IDENTITY,
    b_name VARCHAR(100),

    CONSTRAINT pk_badges PRIMARY KEY (badge_id)
);
-- ----------------------------------------------------------------
-- 4. Trips — fourth, because it references both Riders and Drivers.
--  Primary Key: trip_id
--  Foreign keys: fk_trips_driver, fk_trips_rider -> References Drivers(driver_id) and Riders(rider_id) respectively
--  Check: chk_trips_duration (> 0), chk_trips_fare_amount (>= 0)
-- ----------------------------------------------------------------
CREATE TABLE Trips (
    trip_id INTEGER GENERATED ALWAYS AS IDENTITY,
    driver_id INT,
    rider_id INT,
    pickup_time DATE NOT NULL,
    duration INT,
    fare_amount NUMERIC,

    CONSTRAINT pk_trips PRIMARY KEY (trip_id),

    CONSTRAINT fk_trips_driver
        FOREIGN KEY (driver_id)
        REFERENCES Drivers(driver_id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_trips_rider
        FOREIGN KEY (rider_id)
        REFERENCES Riders(rider_id)
        ON DELETE RESTRICT,

    CONSTRAINT chk_trips_duration CHECK (duration > 0),

    CONSTRAINT chk_trips_fare_amount CHECK (fare_amount >= 0)
);
-- ----------------------------------------------------------------
-- 5. Awards — last, because it references Drivers and Badges.
--  Primary Key: Composite key: (driver_id, badge_id)
--  Foreign Keys: fk_awards_driver, fk_awards_badge -> References Drivers(driver_id) and Badges(badge_id) respectively
-- ----------------------------------------------------------------
CREATE TABLE Awards (
    driver_id INT,
    badge_id INT,

    CONSTRAINT pk_awards PRIMARY KEY (driver_id, badge_id),

    CONSTRAINT fk_awards_driver
        FOREIGN KEY (driver_id)
        REFERENCES Drivers(driver_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_awards_badge
        FOREIGN KEY (badge_id)
        REFERENCES Badges(badge_id)
        ON DELETE CASCADE
);