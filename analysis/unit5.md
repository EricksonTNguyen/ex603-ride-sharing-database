# Unit 5

## Task 5.1 Write Up

Q1: What feature or report on your platform could use the three-table join from Question 1? What information would it display?

A1: A Trip Activity Report could use this three-table join. It would connect trips with the riders who requested them and the drivers who provided them. The report would display the trip ID, rider name, driver name, and trip request date and time. This would help leadership identify who was involved in each trip and review platform activity more easily.

Q2: Why is the junction table important for answering Question 2? What would make this analysis more difficult without it?

A2: The junction table, driver_badge_awards, connects our producers (drivers) to the catalog records (badges). It establishes which badges have been awarded to each driver through their driver and badge IDs. Without this table, it would be more difficult to determine which producers are associated with specific catalog tags because there would be no direct relationship connecting the two tables. The junction table allows us to join the producers to their associated badges and identify which producers share a particular catalog tag.

## Tasks 5.2 Write Up

Q1: Which producers were excluded by the inner join? Report their identifiers.

A1: Driver 14 and Driver 15 were excluded by the inner join. Their corresponding trip linkage returned NULL.

Q2: What does it mean when a producer has no events? What are some possible explanations?

A2: It could mean that the producer didn't do an event yet, or in some cases the producer may not actually exist.

Q3: How could a report based only on an inner join give leadership an incomplete picture of the platform?

A3: Depending on the parameters provided, the corresponding event relation could exclude a subset of all the total producers from the resultant table.

Q4: Why might leadership want to identify producers who have never been active?

A4: A multitude of reasons. It could be that there may be producers that no longer exist and needs to be pruned, or it could be a way of viewing useless producers for disciplinary action.

Q5:What action could leadership take based on these findings?

A5: They could remove those producers completely, or use it as data to justify disciplinary action.