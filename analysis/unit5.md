# Unit 5

## Task 5.1 Write Up

Q1: What feature or report on your platform could use the three-table join from Question 1? What information would it display?

A1: A Trip Activity Report could use this three-table join. It would connect trips with the riders who requested them and the drivers who provided them. The report would display the trip ID, rider name, driver name, and trip request date and time. This would help leadership identify who was involved in each trip and review platform activity more easily.

Q2: Why is the junction table important for answering Question 2? What would make this analysis more difficult without it?

A2: The junction table, driver_badge_awards, connects our producers (drivers) to the catalog records (badges). It establishes which badges have been awarded to each driver through their driver and badge IDs. Without this table, it would be more difficult to determine which producers are associated with specific catalog tags because there would be no direct relationship connecting the two tables. The junction table allows us to join the producers to their associated badges and identify which producers share a particular catalog tag.