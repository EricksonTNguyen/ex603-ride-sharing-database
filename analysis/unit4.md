# Unit 4 Write Ups

## Task 4.1 Write Up

The Data team would use the per-producer breakdown to identify which drivers may be contributing most to the platform's failure rate. The aggregate failure rate shows the overall percentage of trips that fail, but it hides how failures are distributed among individual drivers. A high platform-wide rate could be driven by a small number of drivers or reflect a broader problem across the platform.

The next step would be to examine each producer's identifier, total trip count, failure count, and failure rate. I would also want to compare producers across regions and account for differences in the number of trips each producer handles. This would help leadership identify patterns that deserve further investigation without assuming that a high failure rate automatically means a driver is performing poorly.