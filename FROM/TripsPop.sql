/*

Self-Join
Produce a report of trips with the most popular start times in July, that is trips with the same start times.
List DISTINCT sltrip1.TripID, slTrip1.TripStart, slTrip1.StartHour, and slTrip1.StartMinute for trips in the month of July. Only use DISTINCT in the last step, not in the intermediate steps.
sltrip1.TripID is the TripID returned by the first subquery.
slTrip1.TripStart is the TripStart returned by the first subquery.
slTrip1.StartHour is the derived hour from the first subquery.
slTrip1.StartMinute is the derived minute from the first subquery.
slTrip1 and slTrip2 are the alias names for the subqueries in the FROM clause.
This is an example of a self-join. In this case we are joining the same subquery or view to itself to look for duplicate start times. We have to create a subquery because we are deriving date values and filtering the table for the month of July.
We will also solve this in the GROUP BY homework. We can group on hour and minute, count the start times, return those counts > 1, and then look up the trips with those start times.
It looks like 1:00pm was the most popular departure time.
 */

SELECT DISTINCT slTrip1.TripID,
        slTrip1.TripStart,
        slTrip1.STARTHOUR,
        slTrip1.STARTMINUTE
FROM (SELECT sltrip.TripID, 
        slTrip.TripStart,
        DATEPART(HOUR, slTrip.TripStart) AS STARTHOUR,
        DATEPART(MINUTE, slTrip.TripStart) AS STARTMINUTE
        FROM slTrip
        WHERE MONTH(slTrip.TripStart) = 7) AS slTrip1
INNER JOIN
     (SELECT sltrip.TripID, 
        slTrip.TripStart,
        DATEPART(HOUR, slTrip.TripStart) AS STARTHOUR,
        DATEPART(MINUTE, slTrip.TripStart) AS STARTMINUTE
        FROM slTrip
        WHERE MONTH(slTrip.TripStart) = 7) AS slTrip2
ON slTrip1.TripID <> slTrip2.TripID
AND slTrip1.STARTHOUR = slTrip2.STARTHOUR AND slTrip1.STARTMINUTE = slTrip2.STARTMINUTE
ORDER BY slTrip1.STARTHOUR, slTrip1.startminute