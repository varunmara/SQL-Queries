/* 
List slCensus.PaxID and PaxCnt for all passengers who have been a passenger more than the average number of times.
PaxCnt is the count of the number of trips taken by a passenger. Only list a passenger if their count is above the average number of trips taken by all passengers.
Order the result by PaxCnt DESC.

*/

SELECT slCensus.PaxID,
        COUNT(*) AS PaxCnt
FROM slCensus
GROUP BY slCensus.PaxID
HAVING COUNT(*) > (SELECT ROUND(CONVERT(FLOAT, AVG(vwPaxCnt.PaxCnt)), 2) AS AVGPaxCnt
                  FROM (SELECT slCensus.PaxID,
                   CONVERT (FLOAT, COUNT(*)) AS PaxCnt
                   FROM slCensus
                   GROUP BY slCensus.PaxID) AS vwPaxCnt
)
ORDER BY PaxCnt DESCj