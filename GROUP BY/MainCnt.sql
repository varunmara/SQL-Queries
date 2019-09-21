/* 
List Month and MonthCnt for all maintenance items in slMaintenance.
Derive Month using MONTH() or DATEPART().
MonthCnt is the count of maintenance items for each month.
This is a subquery in the sense that we are grouping by a value derived by a function (a subquery can be saved as a function).
Order the result by Month ASC.
*/


SELECT MONTH(slMaintenance.MaintenanceDate) AS MONTH,
        COUNT(MaintenanceDate) AS MonthCnt
FROM slMaintenance
GROUP BY MONTH(slMaintenance.MaintenanceDate)
ORDER BY MONTH ASC