/* 
We need a list of the Launches and the lowest water temp that was reported when out of the ship.
List LaunchID, Launch, MinWaterTemp.
This query should be written as a FROM subquery.

The output should also be displayed with MinWaterTemp in descending order.
*/


SELECT slLaunch.LaunchID,
        slLaunch.Launch,
        vwMinWaterTemp.MinWaterTemp
FROM slLaunch 
INNER JOIN (SELECT slTrip.LaunchID,
                   MIN(slTrip.WaterTemp) AS MinWaterTemp
           FROM slTrip 
           GROUP BY slTrip.LaunchID) AS vwMinWaterTemp
       ON vwMinWaterTemp.LaunchID = slLaunch.LaunchID
ORDER BY MinWaterTemp DESC