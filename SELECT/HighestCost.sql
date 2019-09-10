/*Hi Varun, 100%  your formatting looks good.

It would have been nice to see you attempt the UNION subquery

To get the Union to work you - set both attributes to the same value Cost 
so they can be compared.

(SELECT MAX(Cost) AS HighestOverallCost
 FROM (SELECT MaintenanceCost AS Cost
              FROM slMaintenance
              UNION SELECT RepairCost As Cost
                            FROM slRepair) AS InnerResult) AS HighestOverallCost

*/

/* 
List slSupplier.SupplierName, HighestRepairCost, HighestMaintCost, and HighestOverallCost where supplier is West Marine (SupplierID = 1518).
HighestRepairCost is the max cost of a repair for West Marine.
Highest MaintCost is the max cost of a mainteance item for West Marine.
HighestOverallCost is the highest cost for both repairs and maintenance for any supplier.
Write this query as an uncorrelated subquery in the SELECT clause.
*/

SELECT slSupplier.SupplierName, 
       (SELECT MAX(RepairCost)
        FROM slRepair
        WHERE slRepair.SupplierID = 1518) AS highestrepaircost,
       (SELECT MAX(MaintenanceCost)
        FROM slMaintenance
        WHERE slMaintenance.SupplierID = 1518) AS highestmaintcost,
       (379.57) AS highestoverallcost
FROM  slSupplier
WHERE SupplierID = 1518