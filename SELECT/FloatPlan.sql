/* 
Problem statement

List slTrip.TripID, slTrip.TripStart, WayPoint1, WayPoint2, and WayPoint3 for trips that have at least three waypoints (WayPointOrder = 3).
WayPoint1, 2, and 3 are the names of the WayPoints for each point on the float plan.
Test your inner queries with TripID=22. The Float Plan for TripID 22 is WP1="Delta", WP2="Bay", WP3="Dog River Bridge".
Write this as a correlated subquery in the SELECT statement.
You will have to use an alias for your outer query for the table slFloatPlan (or for your subqueries... either way). You will be referencing slFloatPlan twice.

No intermediate steps are given for this query.

*/

SELECT slFloatPlan.TripID,
        (SELECT slTrip.TripStart
        FROM slTrip
        WHERE slTrip.TripID = slFloatPlan.TripID) AS TripStart,
       (SELECT slWayPoint.WayPoint
       FROM slWayPoint
       WHERE slWayPoint.WayPointID = slFloatPlan.WayPointID) AS WayPoint1, 
       (0) AS WayPoint2, 
       (0) AS WayPoint3
FROM slFloatPlan 
WHERE slFloatPlan.WayPointOrder >= 3