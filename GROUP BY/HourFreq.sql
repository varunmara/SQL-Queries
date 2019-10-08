/* 
Compute TripHour, HourCnt, RelativeFreq, TotalCnt for all trips having a non-zero TripHour.
TripHour is the differnce in hours between TripStart and TripEnd. TripHour is the bins of the histogram.
HourCnt is the count of the number of trips for a given TripHour.
RelativeFreq is the relative occurence of a TripHour computed as ((HourCnt / TotalCnt) * 100)
TotalCnt is the total number of trips with non-zero TripHours.
Order the result by TripHour DESC.
*/

SELECT DATEDIFF(hour, slTrip.TripStart, slTrip.TripEnd) AS TripHour,
        CONVERT(FLOAT, COUNT(*)) AS HourCnt,
        ROUND( ((CONVERT(FLOAT, COUNT(*))  / (SELECT CONVERT(FLOAT, COUNT(*))
                                                     FROM slTrip
                                                     WHERE slTrip.TripHour > 0)) * 100), 2) AS RelativeFreq,
        (SELECT CONVERT(FLOAT, COUNT(*))
         FROM slTrip
         WHERE slTrip.TripHour > 0) AS TotalCnt
FROM slTrip
WHERE DATEDIFF(hour, slTrip.TripStart, slTrip.TripEnd) > 0
GROUP BY DATEDIFF(hour, slTrip.TripStart, slTrip.TripEnd)
ORDER BY slTrip.TripHour DESC