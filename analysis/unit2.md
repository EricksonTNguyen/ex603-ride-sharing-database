# Unit 2

## Constraints

| Foreign Key                                                 | ON DELETE  | Reason |
| ----------------------------------------------------------- | ---------- | ------ |
| `fk_trips_driver` -- Trips.driver_id -> Drivers.driver_id   | `RESTRICT` | Prevents a driver from being deleted while historical trip records still reference that driver.|
| `fk_trips_rider` -- Trips.rider_id -> Riders.rider_id      | `RESTRICT` | Prevents a rider from being deleted while historical trip records still reference that rider.|
| `fk_awards_driver` -- Awards.driver_id -> Drivers.driver_id | `CASCADE`  | Removes a driver's associated award records when that driver is deleted because the awards relationship no longer has a purpose.|
| `fk_awards_badge` -- Awards.badge_id -> Badges.badge_id   | `CASCADE`  | Removes associated award records when a badge is deleted because the award can no longer reference an existing badge.|

## CHECK Constraints

| CHECK Constraint                             | Invalid State Description                   | Reasoning |
| -------------------------------------------- | ------------------------------------------- | --------- |
| `chk_drivers_filter` -- filter >= 0         | A driver's `filter` value is less than `0`. | User inputs a negative value would not fit any pre-existing filter. CHECK constraints disallows such inputs.|
| `chk_trips_duration` -- duration > 0        | A trip has a `duration` of zero or less.     | Rider enters the ride share and immediately leaves|
| `chk_trips_fare_amount` -- fare_amount >= 0 | A trip has a negative `fare_amount`.        | Rider gets charged a negative amount due to POS errors|
