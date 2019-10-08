/* 
SELECT ROUND(slGasPurchase.Gallons * slGasPurchase.CostPerGallon, 0) AS PurchasePrice,
        (0) AS PurchaseCnt
FROM slGasPurchase
ORDER BY PurchasePrice DESC
*/

SELECT ROUND(slGasPurchase.Gallons * slGasPurchase.CostPerGallon, 0) AS PurchasePrice,
        COUNT(*) AS PurchaseCnt
FROM slGasPurchase
WHERE CostPerGallon > 0
GROUP BY ROUND(slGasPurchase.Gallons * slGasPurchase.CostPerGallon, 0)
ORDER BY PurchaseCnt DESC, PurchasePrice DESC