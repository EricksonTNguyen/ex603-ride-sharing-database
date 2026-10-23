# Unit 4 Write Ups

## Task 4.1 Write Up

The Data team would use the per-producer breakdown to identify which drivers may be contributing most to the platform's failure rate. The aggregate failure rate shows the overall percentage of trips that fail, but it hides how failures are distributed among individual drivers. A high platform-wide rate could be driven by a small number of drivers or reflect a broader problem across the platform.

The next step would be to examine each producer's identifier, total trip count, failure count, and failure rate. I would also want to compare producers across regions and account for differences in the number of trips each producer handles. This would help leadership identify patterns that deserve further investigation without assuming that a high failure rate automatically means a driver is performing poorly.

## Task 4.2 Write Up

For Part A, the two questions my conditional aggreation answered side by side are:

1. How many total trips did each driver handle?
2. How many of those trips were classified as failures?

For Part B, I would say the regional director would need regional subtotals rather than individual driver details to review performance across regions. The grand total showed the total number of trips and failures across the entire platform. This supports a platform-wide assessment of overall performance and the actual failure rate which individual regional managers won't be able to compute alone.

For Part C, the pipeline answers the question: **What is the average failure rate among high-volume porducers who handled at least 10 trips?**