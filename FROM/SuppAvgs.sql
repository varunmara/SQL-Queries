/* 
Marketing wants a report that lists the average cost for both repairs and maintenance items for all suppliers who appear on a repair item.
List slSupplier.SupplierName, slSupplier.SupplierID, AvgRepAmt, and AvgMaintAmt for all suppliers who appear on a repair.
AvgRepAmt is the average of slRepair.RepairCost for a given supplier.
AvgMaintAmt is the average of slMaintenance.MaintenanceCost for a given supplier.
vwRepairAvg and vwMainAvg are the names of the subqueries in the FROM clause. These are the names I would use were we to store the queries as views.
If the supplier does not appear on a maintenance item, display zero (0).
Averages should be rounded to two decimal places.
Order the result by vwRepairAvg.AvgRepAm in DESC order.
Note that this query is functionally equivalent to HighestCostCor. For practice, it is recommended you reformulate using a correlated subquery in the SELECT clause.
*/
SELECT  
    slSupplier.SupplierName AS SupplierName,
    slSupplier.SupplierID AS SupplierID,
        vwRepairAvg.AvgRepAmt,
        ISNULL(vwMainAvg.AvgMaintAmt,0) AS AvgMainAmt
FROM (SELECT slRepair.SupplierID,
      ROUND(AVG(slRepair.RepairCost), 2) AS AVGREPAMT
      FROM slRepair
      GROUP BY slRepair.SupplierID) AS vwRepairAvg
LEFT OUTER JOIN 
        (SELECT slMaintenance.SupplierID,
        ROUND(AVG(slMaintenance.MaintenanceCost), 2) AS AVGMAINTAMT
        FROM slMaintenance
        GROUP BY slMaintenance.SupplierID) AS vwMainAvg
ON vwRepairAvg.SupplierID = vwMainAvg.SupplierID
INNER JOIN slSupplier ON slSupplier.SupplierID = vwRepairAvg.SupplierID
ORDER BY vwRepairAvg.AVGREPAMT DESC
