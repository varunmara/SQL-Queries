/* 
List slWayPoint.WayPointID, slWayPoint.WayPoint and WayPointCnt where the slTrip.WaterTemp was > 90.
WayPointCnt is the count of the number of trips for a given WayPoint.
Write this query as a subquery in the FROM clause.
Order the result by WayPointCnt DESC, slWayPoint.WayPointID ASC.
*/

SELECT vwWayPointCnt.WayPointID,
        vwWayPointCnt.WayPoint,
        WayPointCnt
FROM (SELECT slWayPoint.WayPointID,
        slWayPoint.WayPoint,
        COUNT(slTrip.TripID) AS WayPointCnt
        FROM slWayPoint
        Inner join slFloatPlan on slFloatPlan.WayPointID = slWayPoint.WayPointID
        Inner join slTrip on slTrip.TripID = slFloatPlan.TripID
        GROUP BY slWayPoint.WayPointID
        WHERE slTrip.WaterTemp > 40) AS vwWayPointCnt