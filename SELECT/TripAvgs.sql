/* 
List slTrip.TripStart, slTrip.TripHour, slTrip.WaterTemp for trips in June 2011 and AvgHour, and AvgTemp for all trips.
AvgHour is the average TripHour for all trips.
AvgTemp is the average WaterTemp for all trips.
Round Averages to two decimal places.
Write this as an uncorrelated subquery in the SELECT clause.
Order the result by slTrip.TripStart ASC.

No intermediate steps are given for this query.
*/
SELECT  slTrip.TripStart, 
        slTrip.TripHour,
        slTrip.WaterTemp, 
        (SELECT ROUND(AVG(slTrip.TripHour), 2)
        FROM slTrip) AS AvgHour, 
        (SELECT ROUND(AVG(slTrip.WaterTemp), 2)
        FROM slTrip) AS AvgTemp
FROM  slTrip
WHERE slTrip.TripStart BETWEEN '2011-06-01' AND '2011-07-01'
ORDER BY slTrip.TripStart ASC