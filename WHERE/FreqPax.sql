SELECT  vwPaxCnt.PaxID,
        ('') AS PassengerName,
        vwPaxCnt.PaxCnt
FROM (SELECT slCensus.PaxID,
             COUNT(slCensus.TripID) AS PaxCnt
     FROM slCensus
     GROUP BY slCensus.PaxID) AS vwPaxCnt
WHERE vwPaxCnt.PaxCnt = (SELECT MAX(PaxCnt) AS MaxPxCnt
                         FROM   (SELECT    slCensus.PaxID,
                                COUNT(slCensus.TripID) AS PaxCnt
                         FROM     slCensus
                         GROUP BY slCensus.PaxID) AS vwPaxCnt)