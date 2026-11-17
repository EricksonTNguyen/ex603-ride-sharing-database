# Unit 6

## Task 6.1 Write Up

1. **Are there any trip's fare higher or lower than the average fare for that driver?** For this question using the group average alone (GROUP BY) isn't capable of answering it. This is because with the group average it returns the average fare for each driver. It would combine the trips into one result per driver, thus losing the individual trip information. Without those individual trip rows, I cannot compare each trip's fare to its driver's average.

2. A platform feature that could use my producer rankings is a driver leaderboard that ranks the most active drivers based on their total number of trips. For this feature, I would use the RANK() function because drivers with the same number of trips should receive the same ranking. The other two options ROW_NUMBER() and DENSE_RANK() would force unique positions and avoid skipping rankings based off ties respectively. For this specific feature, RANK() fits the best in my opinion.