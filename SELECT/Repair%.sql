/* 
The sales department wants to know the percentage of repairs that had parts supplied by iboats.com.
List the slSupplier.SupplierName, SuppCnt, TotalCnt, and SuppPct for supplier iboats.com (SupplierID 1509).
SuppCnt is number (count) of repairs (slRepair) for which iboats.com was the supplier.
TotalCnt is the number (count) of repairs in slRepair.
SuppPct is the percentage of repairs (SuppCnt/TotalCnt). Use CONVERT() to cast COUNT(*) as FLOAT for division operator.
Write this query as an uncorrelated subquery in the SELECT clause.
*/


SELECT slSupplier.SupplierName, 
       (SELECT CONVERT(float, COUNT(RepairID))
        FROM slRepair 
        WHERE slRepair.SupplierID = 1509 ) AS SuppCnt,
       (SELECT CONVERT(float, COUNT(RepairID))
        FROM slRepair) AS TotalCnt,
       ((SELECT CONVERT(float, COUNT(RepairID))
        FROM slRepair 
        WHERE slRepair.SupplierID = 1509 ) /  (SELECT CONVERT(float, COUNT(RepairID))
        FROM slRepair) ) AS SuppPct
FROM  slSupplier
WHERE SupplierID = 1509
       