# **Ride Sharing Relational Database Constraints**

## **Primary Keys:**

**rider_id**: NOT NULL, UNIQUE, PRIMARY KEY

**driver_id**: NOT NULL, UNIQUE, PRIMARY KEY

**trip_id**: NOT NULL, UNIQUE, PRIMARY KEY

**badge_id**: NOT NULL, UNIQUE, PRIMARY KEY

**Awards(driver_id, badge_id)**: PRIMARY KEY

## **Foreign Keys:**

**Trips.driver_id**: FOREIGN KEY referencing Drivers(driver_id) ON DELETE RESTRICT

<ul>
    Justification: The removal of a driver should not remove the historical trip data.
</ul>

**Trips.rider_id**: FOREIGN KEY referencing Riders(rider_id) ON DELETE RESTRICT

<ul>
    Justification: The removal of a rider should not remove the historical data. If a trip references the rider, it the rider's information should be preserved.
</ul

**Awards.driver_id**: FOREIGN KEY referencing Drivers(driver_id) ON DELETE CASCADE

<ul>
    Justification: Awards are a relationship between the producer and the catalog. If the driver is deleted, their associated awards have no purpose.
</ul

**Awards.badge_id**: FOREIGN KEY referencing Badges(badge_id) ON DELETE CASCADE

<ul>
    Justification: If a badge is deleted, the corresponding Awards record should also be removed becaused the referenced badge no longer exists.
</ul

## **Attributes**

**Trips.pickup_time**: NOT NULL

**Trips.duration**: CHECK (> 0)

**Trips.fare_amount**: CHECK (>= 0)

**Drivers.filter**: CHECK (>= 0)

**(driver_id, badge_id) pair in Awards**: UNIQUE (COMPOSITE PRIMARY KEY)