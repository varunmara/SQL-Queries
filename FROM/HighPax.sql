/* 
Provide a report that lists trips to Gravine Island that had more than 3 passengers (High passenger count)
List slTrip.TripStart, slTrip.TripHour, slWayPoint.WayPoint, Captain, and vwPaxCnt.PaxCnt for all trips to "Gravine Island" (WayPointID=919) that had more than 3 passengers (Pax).
vwPaxCnt.PaxCnt is the count of the number of passengers on a trip (slCensus).
vwpaxCnt is the alias name of the inner subquery in the FROM clause.
Captain is the concatenation of the slPax.PaxFirstName and slPax.PaxLastName for slTrip.CaptianID.
Order the result by sltrip.TripStart ASC.
*/

SELECT slTrip.TripStart AS TripStart, 
       slTrip.TripHour AS TripHour,
       slWayPoint.WayPoint AS WayPoint, 
       slPax.PaxFirstName + ' ' + slPax.PaxLastName AS Captain, 
       vwPaxCnt.PaxCnt
FROM (SELECT slCensus.TripID,
      COUNT(slCensus.CensusID) AS PaxCnt
      FROM slCensus
      GROUP BY slCensus.TripID
      HAVING COUNT(slCensus.CensusID) > 3) AS vwPaxCnt
INNER JOIN slTrip ON slTrip.TripID = vwPaxCnt.TripID
INNER JOIN slFloatPlan ON slFloatPlan.TripID = vwPaxCnt.TripID
INNER JOIN slWayPoint ON slWayPoint.WayPointID = slFloatPlan.WayPointID
INNER JOIN slPax ON slTrip.CaptainID = slPax.PaxID
WHERE slWayPoint.WayPointID = 919

ORDER BY slTrip.TripStart ASC