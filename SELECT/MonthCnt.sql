/*Hi Varun, Nicely done 100 

Sales wants a report that shows the number of repairs for each supplier for the months of January and June.
List slSupplier.SupplierName, JanuaryCnt, and JuneCnt.
JanuaryCnt is the count of the number of repairs for a given supplier for January.
JuneCnt is the count of the number of repairs for a given supplier for June.

Order the result by slSupplier.SupplierName ASC.
*/
SELECT slSupplier.SupplierName,
       (SELECT COUNT(RepairID) 
        FROM slRepair
        WHERE MONTH(slRepair.RepairDate) = 01 AND SupplierID = slSupplier.SupplierID) AS JanuaryCnt,
       (SELECT COUNT(RepairID)
        FROM slRepair
        WHERE MONTH(slRepair.RepairDate) = 06 AND SupplierID = slSupplier.SupplierID) AS JuneCnt
From slSupplier
