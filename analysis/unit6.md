# Unit 6

## Task 6.1 Write Up

1. **Are there any trip's fare higher or lower than the average fare for that driver?** For this question using the group average alone (GROUP BY) isn't capable of answering it. This is because with the group average it returns the average fare for each driver. It would combine the trips into one result per driver, thus losing the individual trip information. Without those individual trip rows, I cannot compare each trip's fare to its driver's average.

2. A platform feature that could use my producer rankings is a driver leaderboard that ranks the most active drivers based on their total number of trips. For this feature, I would use the RANK() function because drivers with the same number of trips should receive the same ranking. The other two options ROW_NUMBER() and DENSE_RANK() would force unique positions and avoid skipping rankings based off ties respectively. For this specific feature, RANK() fits the best in my opinion.

## Task 6.2 Write Up

1. What would a large delta tell someone about your platform, and what should they do about it?

        A large delta means that there was large change in the fare amount between two consecutive trips. This could indicate a change in trip distance, surge pricing, or an odd fare. Someone who monitors the platform could investigate these large changes to determine whether they are normal or caused by pricing issues or data errors.

2. Why does a running total answer a question that a plain SUM cannot?

        A plain SUM() gives one final total for all the fares but it does not show how the platform reached that amount. With a running total, we can see how the total changes with each new trip over time. This helps monitor progress toward a target and to see when the platform reaches the target.

3. Why did you pick your moving-average window size? A different size tells a different story.

        I chose a seven-row moving average because it smooths out some of the variety between individual trips without having to look too far back. It gives a better idea of recent fare costs while still responding to changes. If I were to choose a smaller window, I believe it would be more reactive to individual changes while a larger window would produce a smoother average but hide recent trends.

4. What does a gap mean in your platform: a data quality problem, a real stop in activity, or a side effect of how events were recorded? Each needs a different response. Say which one yours is and how you know.

        I chose Driver 1 as the producer for this analysis. Through the query, I found an 87-day gap between trips. I would classify this as an actual stop in activity, as opposed to a data quality problem. The query showed that no trips for Driver 1 appeared in the data set during that period. To make sure, the platform should double check driver activity records before making the call on a driver's work stoppage. In the event that is the case, the platform should reach out to the driver before making any decision like disabling or setting the Driver's account to inactive.

## Task 6.3 Write Up

1. Name the feature in your platform that top-N would power. Explain why three is the right number, rather than one or ten.

        The top-N query could be used to power a leaderboard showing each driver's three highest-fare trips. I think three is a good number because it gives users more than just one example of a driver's highest fare, while still keeping the list short and easy to review. Showing only one trip might not give enough information, while showing ten could make the leaderboard too long to use. Three gives users a quick snapshot into the profits gained by each individual driver.

2. What would a large month-over-month change mean in your domain, and what should someone do about it? A number nobody acts on is not a metric.

        A large month-over-month change in the total fares could mean the platform is experiencing a significant increase or decrease in activity or revenue. For example, a large decrease could indicate fewer trips, lower fares, or an issue with how trip data is being recorded. On the flip side, a large increase could indicate more demand or higher fares due to some event like surge pricing. In the case of the large decrease, someone should investigate into it. Look at the total fares for the month as compared to those prior, or check the total fares for the month to ensure that the data is sound. Use the database as a way to get business metrics and action based off that.