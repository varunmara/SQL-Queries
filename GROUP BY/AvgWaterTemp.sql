/* 
What was the average water temperature for the months June and July by year?
This query could, of course, be used to compute temp for all 12 months.
List vwYear.TripYear, vwWaterTempJune.WaterTempJune and vwWaterTempJuly.WaterTempJuly for each year.
Order the result by vwWaterTempJune.TripYear ASC.
vwYear.TripYear is the years for which the AVG water temperatures are calculated. This is the driving subquery.
vwWaterTempJune.WaterTempJune is the AVG water temp for June.
vwWaterTempJuly.WaterTempJuly is the AVG water temp for July.
vwWaterTemp... is the alias name of the subqueries.
Use YEAR() and MONTH() or DATEPART() to retrieve date information.
vwYear is the driving subquery. LEFT OUTER JOIN is used to link the two vwWaterTemp... subqueries back to vwYear.
For practice, it is recommended that you try solving this query with a CORRELATED subquery in the SELECT clause. The FROM queries will perform MUCH better.
Another approach would be to produce the results using a GROUP BY operation and then using a PIVOT operator to transpose the data into columns. This would perform the best because PIVOT is a specialized solution and not generalized solution. However, a generalized solution such as this one, works in any DBMS. The PIVOT operator is different in all DBMSs.
*/


SELECT vwYear.TripYear,
        ISNULL(vwWaterJune.WaterTempJune, 0) AS WaterTempJune,
        ISNULL(vwWaterJuly.WaterTempJuly, 0) AS WaterTempJuly
FROM (SELECT YEAR(slTrip.TripStart) AS TripYear
      FROM slTrip
      GROUP BY YEAR(slTrip.TripStart)) AS vwYear
LEFT OUTER JOIN (SELECT YEAR(slTrip.TripStart) AS TripYear,
                        avg(slTrip.WaterTemp) as watertempjune
                 FROM slTrip
                 WHERE MONTH(slTrip.TripStart) = 6
                 GROUP BY YEAR(slTrip.TripStart)) AS vwWaterJune ON vwYear.TripYear = vwWaterJune.TripYear
LEFT OUTER JOIN (SELECT YEAR(slTrip.TripStart) AS TripYear,
                        avg(slTrip.WaterTemp) as watertempjuly
                 FROM slTrip
                 WHERE MONTH(slTrip.TripStart) = 7
                 GROUP BY YEAR(slTrip.TripStart)) AS vwWaterJuly ON vwYear.TripYear = vwWaterJuly.TripYear

ORDER BY vwYear.TripYear ASC