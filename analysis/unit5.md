# Unit 5

## Task 5.1 Write Up

Q1: What feature or report on your platform could use the three-table join from Question 1? What information would it display?

A1: A Trip Activity Report could use this three-table join. It would connect trips with the riders who requested them and the drivers who provided them. The report would display the trip ID, rider name, driver name, and trip request date and time. This would help leadership identify who was involved in each trip and review platform activity more easily.

Q2: Why is the junction table important for answering Question 2? What would make this analysis more difficult without it?

A2: The junction table, driver_badge_awards, connects our producers (drivers) to the catalog records (badges). It establishes which badges have been awarded to each driver through their driver and badge IDs. Without this table, it would be more difficult to determine which producers are associated with specific catalog tags because there would be no direct relationship connecting the two tables. The junction table allows us to join the producers to their associated badges and identify which producers share a particular catalog tag.

## Task 5.2 Write Up

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

## Task 5.3 Write Up

Q1: Give an example of when a Cartesian product could be useful on your platform, or explain why you would not need one.

A1: I don't believe for the rideshare database a cartesian product would be needed. The database is very much a snapshot of the rideshare database at that time. It cares more about the trips, riders, and drivers and the statistics and accolades of the driver at that time. There is no express need to see all possible badges a driver can get. It is more pertinent to the organization and the riders of what accolades the driver already has.

Q2: Which join algorithms did PostgreSQL choose for your query?

A2: Hash Join

Q3: What information in the execution plan helps explain those choices?

A3: The execution plan shows the estimated costs, estimated number of rows.

Q4: Why is it useful to understand the selected join algorithms?

A4: Understanding join algorithms helps identify potential performance bottlenecks and understand how efficiently a query retrieves data. It can also help developers decide whether adding indexes or changing a query could improve performance as the database grows.

Q5: What changes to the data or database might make another join algorithm more appropriate?

A5: If the tables grow significantly, PostgreSQL might choose a different join algorithm depending on the number of rows, available indexes, and how the data is sorted.