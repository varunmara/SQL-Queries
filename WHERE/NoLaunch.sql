/* 
List slLaunch.LaunchID and slLaunch.Launch for launches from which 'Harold Pardue' (PaxID=174) never launched as Captain.
Write this query as a NOT IN() subquery.

*/

SELECT slLaunch.LaunchID,
       slLaunch.Launch
FROM slLaunch
WHERE slLaunch.LaunchID NOT IN (SELECT slTrip.LaunchID
                                FROM slTrip
                                WHERE slTrip.CaptainID = 174)
ORDER BY Launch ASC