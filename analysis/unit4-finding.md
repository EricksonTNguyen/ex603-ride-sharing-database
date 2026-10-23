# Unit 4 Findings

## The Breakdown

Across the 200 trips in the dataset, 44 were classified as failures, giving the platform an overall failure rate of 22%. For this analysis, failures include both cancelled and disputed trips.

The platform-wide rate provides a useful baseline, but it does not show how failures are distributed across individual producers. To make the comparison more meaningful, I focused on drivers who handled at least 10 trips and compared their total trips, failed trips, and failure rates.

| Driver ID | Total Trips | Failed Trips | Failure Rate |
| ----------- | ----------- | ------------ | ------------ |
| 3           | 13          | 5            | 38.5%        |
| 1           | 11          | 4            | 36.4%        |
| 9           | 14          | 5            | 35.7%        |

Drivers 3, 1, and 9 should be investigated first. Their failure rates are all much higher than the platform-wide rate of 22%. Driver 3 has the highest failure rate, while Drivers 3 and 9 each have five failed trips.

## Reflection

Conditional aggregation is useful because it allows a query to answer multiple related questions during a single pass over the event table. For example, COUNT(*) counts all trips, while SUM(CASE WHEN trip_status IN ('cancelled', 'disputed') THEN 1 ELSE 0 END) counts failed trips. Both results are calculated together for each producer. An alternative would be to run two separate queries: one to count all trips and another to count only failed trips using a WHERE clause. Although both queries could produce the correct results, the database may need to scan the event table twice. With one million rows, repeatedly reading and processing the same data can increase execution time and consume additional database resources. Conditional aggregation reduces this duplicated work by evaluating both calculations as the database processes each row. Another advantage is consistency. Both totals come from the same query execution, reducing the possibility that changes to the data between separate queries could cause the results to disagree. This is especially important when leadership uses the results to evaluate producers or make financial decisions.Conditional aggregation does not guarantee that every query will run faster, because indexes, caching, and the database optimizer also affect performance. However, it is an efficient and clear approach when several related metrics must be calculated from the same dataset.

