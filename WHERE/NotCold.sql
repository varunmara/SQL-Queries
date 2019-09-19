/* List slPax.PaxFirstName and slPax.PaxLastName for passengers who have not sailed when the WaterTemp was colder than 80 degrees, the "warm weather passengers".
Order the result by slPax.PaxLastName, slPax.PaxFirstName ASC.
*/

SELECT slPax.PaxFirstName,
        slPax.PaxLastName
FROM slPax
WHERE slPax.PaxID NOT IN (SELECT slCensus.PaxID
                      FROM slCensus
                      WHERE slCensus.TripID IN (SELECT slTrip.TripID
                                                    FROM slTrip
                                                    WHERE slTrip.WaterTemp < 80))
ORDER BY slPax.PaxLastName, slPax.PaxFirstName ASC