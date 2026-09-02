# Ride Share Relation Schema

**Riders(rider_id, r_name)**
<ul>
    <li>Primary Key: rider_id</li>
    <li>Domains:</li>
        <ul>
            <li>rider_id: INT</li>
            <li>r_name: VARCHAR</li>
        </ul>
</ul>

**Drivers(driver_id, d_name, flag, filter)**
<ul>
    <li>Primary Key: driver_id</li>
    <li>Domains:</li>
        <ul>
            <li>driver_id: INT</li>
            <li>d_name: VARCHAR</li>
            <li>flag: VARCHAR</li>
            <li>filter: INT</li>
        </ul>
</ul>

**Trips(trip_id, driver_id, rider_id, pickup_time, duration, fare_amount)**
<ul>
    <li>Primary Key: trip_id</li>
    <li>Domains:</li>
        <ul>
            <li>trip_id: INT</li>
            <li>driver_id: INT (Foreign Key)</li>
            <li>rider_id: INT (Foreign Key)</li>
            <li>pickup_time: DATE</li>
            <li>duration: INT</li>
            <li>fare_amount: NUMERIC</li>
        </ul>
</ul>

**Badges(badge_id, b_name)**
<ul>
    <li>Primary Key: badge_id</li>
    <li>Domains:</li>
        <ul>
            <li>badge_id: INT</li>
            <li>b_name: VARCHAR</li>
        </ul>
</ul>

**Awards(driver_id, badge_id)**
<ul>
    <li>Primary Key: (driver_id, badge_id)</li>
    <li>Domains:</li>
        <ul>
            <li>driver_id: INT</li>
            <li>badge_id: INT</li>
        </ul>
</ul>