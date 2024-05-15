-- Verificare che il campo ProductKey nella tabella DimProduct sia una chiave primaria
SHOW CREATE TABLE DimProduct;

-- Verificare che la combinazione dei campi SalesOrderNumber e SalesOrderLineNumber sia una PK
SELECT COUNT(*) AS Is_Composite_Primary_Key
FROM information_schema.KEY_COLUMN_USAGE
WHERE CONSTRAINT_SCHEMA = 'adv'
  AND TABLE_NAME = 'FactResellerSales'
  AND COLUMN_NAME IN ('SalesOrderNumber', 'SalesOrderLineNumber')
  AND CONSTRAINT_NAME = 'PRIMARY';

-- Contare il numero di transazioni (SalesOrderLineNumber) realizzate ogni giorno a partire dal 1 Gennaio 2020
SELECT DATE(OrderDate) AS Data_Transazione, COUNT(SalesOrderLineNumber) AS Numero_Transazioni
FROM FactResellerSales
WHERE OrderDate >= '2020-01-01'
GROUP BY DATE(OrderDate);

-- Calcolare il fatturato totale, la quantità totale venduta e il prezzo medio di vendita per prodotto a partire dal 1 Gennaio 2020
SELECT 
    DP.EnglishProductName AS Nome_Prodotto,
    SUM(FRS.SalesAmount) AS Fatturato_Totale,
    SUM(FRS.OrderQuantity) AS Quantita_Totale_Venduta,
    AVG(FRS.UnitPrice) AS Prezzo_Medio_Vendita
FROM
    FactResellerSales FRS
    JOIN DimProduct DP ON FRS.ProductKey = DP.ProductKey
WHERE
    FRS.OrderDate >= '2020-01-01'
GROUP BY
    DP.EnglishProductName;

-- Calcolare il fatturato totale e la quantità totale venduta per categoria prodotto
SELECT 
    DP.EnglishProductName AS Nome_Categoria_Prodotto,
    SUM(FRS.SalesAmount) AS Fatturato_Totale,
    SUM(FRS.OrderQuantity) AS Quantita_Totale_Venduta
FROM
    FactResellerSales FRS
    JOIN DimProduct DP ON FRS.ProductKey = DP.ProductKey
    JOIN DimProductSubcategory DPS ON DP.ProductSubcategoryKey = DPS.ProductSubcategoryKey
    JOIN DimProductCategory DPC ON DPS.ProductCategoryKey = DPC.ProductCategoryKey
WHERE
    FRS.OrderDate >= '2020-01-01'
GROUP BY
    DP.EnglishProductName;
    
    -- Calcolare il fatturato totale per area città realizzato a partire dal 1 Gennaio 2020
    SELECT 
    DG.City AS Città,
    SUM(FRS.SalesAmount) AS Fatturato_Totale
FROM
    FactResellerSales FRS
    JOIN DimGeography DG ON FRS.GeographyKey = DG.GeographyKey
WHERE
    FRS.OrderDate >= '2020-01-01'
GROUP BY
    DG.City
HAVING
    SUM(FRS.SalesAmount) > 60000;



    
    





