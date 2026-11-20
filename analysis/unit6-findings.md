# Task 6.4 - The Closing Memo

## 1. Is the failure problem getting better or worse over the time your data covers?

        The platform appears to be improving overall, but the improvement has not been consistent. After investigating the original dashboard and breaking the failure rate down by driver, the monthly results show that the failure rate decreased from 28.57% in January to 18.75% in December. However, there were still increases during the year, including a peak of 40% in June. This suggests that the platform has made progress, but the failure problem has not been completely resolved. Using the queries that we ran to view our total fare cost month by month modified slightly to build a result that level sets the overall improvement month by month:


| Month | Total Events | Failed Events | Failure Rate (%) | Previous Month Rate (%) | Change (Percentage Points) |
|---|---:|---:|---:|---:|---:|
| 2023-01-01 | 21 | 6 | 28.57 | — | — |
| 2023-02-01 | 21 | 4 | 19.05 | 28.57 | -9.52 |
| 2023-03-01 | 11 | 3 | 27.27 | 19.05 | +8.22 |
| 2023-04-01 | 11 | 0 | 0.00 | 27.27 | -27.27 |
| 2023-05-01 | 17 | 2 | 11.76 | 0.00 | +11.76 |
| 2023-06-01 | 20 | 8 | 40.00 | 11.76 | +28.24 |
| 2023-07-01 | 17 | 5 | 29.41 | 40.00 | -10.59 |
| 2023-08-01 | 18 | 3 | 16.67 | 29.41 | -12.74 |
| 2023-09-01 | 16 | 5 | 31.25 | 16.67 | +14.58 |
| 2023-10-01 | 18 | 2 | 11.11 | 31.25 | -20.14 |
| 2023-11-01 | 14 | 3 | 21.43 | 11.11 | +10.32 |
| 2023-12-01 | 16 | 3 | 18.75 | 21.43 | -2.68 |



## 2. What should the team do next quarter?

        Next quarter, I recommend focusing on the drivers with the highest failure rates, especially Drivers 3, 1, and 9. The team should investigate their cancelled and disputed trips to identify common causes, such as driver availability, rider no-shows, or payment issues. The team should also continue tracking monthly failure rates and comparing them with the previous month to determine whether the changes are actually improving performance. This decision was based off our previous queries about the failure events and the overall failure rates of our drivers on the platform. Here is a table showing the data to back this up:


| Driver ID | Driver Name | Total Events | Failed Events | Failure Rate (%) |
|---:|---|---:|---:|---:|
| 3 | Driver_03 | 13 | 5 | 38.46 |
| 1 | Driver_01 | 11 | 4 | 36.36 |
| 9 | Driver_09 | 14 | 5 | 35.71 |
| 4 | Driver_04 | 6 | 2 | 33.33 |
| 11 | Driver_11 | 16 | 5 | 31.25 |
| 5 | Driver_05 | 18 | 5 | 27.78 |
| 2 | Driver_02 | 16 | 4 | 25.00 |
| 7 | Driver_07 | 18 | 4 | 22.22 |
| 6 | Driver_06 | 21 | 4 | 19.05 |
| 13 | Driver_13 | 11 | 2 | 18.18 |
| 12 | Driver_12 | 17 | 3 | 17.65 |
| 8 | Driver_08 | 20 | 1 | 5.00 |
| 10 | Driver_10 | 19 | 0 | 0.00 |

## Reflection

Window functions are useful because they let me compare individual rows while keeping the original event-level details. One reporting question for the rideshare platform would be whether each trip's fare is higher or lower than that driver's average fare. This would help identify unusual fares that might need further investigation. Using GROUP BY alone would make this difficult because it combines trips into one row per driver when calculating the average. I would lose the individual trip details, such as the trip ID, timestamp, and fare amount. I could use a separate query and join the results back to the trips table, but that adds extra steps. With a window function like AVG(fare_amount) OVER (PARTITION BY driver_id), I can calculate the average fare for each driver while keeping every trip in the results. I can then compare each trip's fare against that average. This makes it easier to identify unusual transactions without losing the details needed to investigate them. Overall, window functions make reporting more flexible because they allow me to analyze individual events and compare them with larger patterns at the same time.