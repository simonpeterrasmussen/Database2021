---- 6-1
-- 1.
USE AdventureWorks2019;
GO
SELECT [Production].[Product].[Name], [Production].[Product].[ProductID]
    FROM [Production].[Product]
    WHERE [Production].[Product].[ProductID] IN (SELECT [SalesOrderDetail].[ProductID]
                                                    FROM [Sales].[SalesOrderDetail])

-- 2.
USE AdventureWorks2019;
GO
SELECT [Production].[Product].[Name], [Production].[Product].[ProductID]
    FROM [Production].[Product]
    WHERE [Production].[Product].[ProductID] NOT IN (SELECT [SalesOrderDetail].[ProductID]
                                                        FROM [Sales].[SalesOrderDetail]);

SELECT [Production].[Product].[ProductID], [Production].[Product].[Name]
    FROM [Production].[Product]
    WHERE [Production].[Product].[ProductID] NOT IN (SELECT [SalesOrderDetail].[ProductID]
                                                        FROM [Sales].[SalesOrderDetail]
                                                        WHERE [ProductID] IS NOT NULL);
-- !! IS NOT NULL skal med !! Hvis der bare er en record i subquery der giver NULL er der ikke noget.
-- Se næste opgave

-- 3.
-- Code from listing 5.11:
USE AdventureWorks2019;
GO
DROP TABLE IF EXISTS Production.ProductColor;
CREATE table Production.ProductColor
    (Color nvarchar(15) NOT NULL PRIMARY KEY);
GO
--Insert most of the existing colors
INSERT INTO Production.ProductColor
SELECT DISTINCT Color
FROM Production.Product
WHERE Color IS NOT NULL and Color <> 'Silver';
--Insert some additional colors
INSERT INTO Production.ProductColor
VALUES ('Green'),('Orange'),('Purple');

SELECT Color
    FROM [Production].[ProductColor]
    WHERE Color NOT IN (SELECT Color
                            FROM [Production].[Product]
                            WHERE Color IS NOT NULL);

-- 4.
USE AdventureWorks2019;
GO
SELECT DISTINCT [Color]
    FROM [Production].[Product] AS p
    WHERE NOT EXISTS ( SELECT [Color]
                            FROM [Production].[ProductColor] AS pc 
                            WHERE p.[COLOR] = pc.[Color]);

-- 5.
USE AdventureWorks2019;
GO
SELECT DISTINCT CAST(per.[ModifiedDate] AS date)
    FROM [Person].[Person] AS per
    CROSS APPLY (SELECT *
                    FROM [HumanResources].[Employee] AS emp
                    WHERE per.[ModifiedDate] = emp.[HireDate]) AS a; 

SELECT ModifiedDate FROM [Person].[Person]
UNION
SELECT HireDate FROM [HumanResources].[Employee]

-- 6.
USE WideWorldImporters;
GO
SELECT c.[CityName]
    FROM [Application].[Cities] AS c
    WHERE c.[StateProvinceID] IN ( SELECT [StateProvinceID]
                                        FROM [Application].[StateProvinces] AS s
                                        WHERE s.[StateProvinceName] = 'Texas' );

SELECT * FROM [WideWorldImporters].[Application].[StateProvinces];
SELECT count(*)
  FROM [WideWorldImporters].[Application].[Cities]
  WHERE [StateProvinceID] = 45;

-- 7.
USE WideWorldImporters;
GO
SELECT [StockItemID], [StockItemName]
    FROM [Warehouse].[StockItems] AS s
    WHERE NOT EXISTS ( SELECT *
                            FROM [Sales].[OrderLines] AS o
                            WHERE s.[StockItemID] = o.[StockItemID]);

-- Ifølge bogen er der ikke nogen records, fordi alle har værest ordered.

-- 8.
USE WideWorldImporters;
GO
SELECT DISTINCT c.[CityName]
    FROM [Application].[Cities] AS c
    JOIN [Application].[StateProvinces] AS s ON c.[StateProvinceID] = s.[StateProvinceID]
    WHERE s.[StateProvinceName] = 'Utah'
UNION
SELECT DISTINCT c.[CityName]
    FROM [Application].[Cities] AS c
    JOIN [Application].[StateProvinces] AS s ON c.[StateProvinceID] = s.[StateProvinceID]
    WHERE s.[StateProvinceName] = 'Wyoming'

-- 9.
USE WideWorldImporters;
GO
SELECT DISTINCT c.[CityName]
    FROM [Application].[Cities] AS c
    JOIN [Application].[StateProvinces] AS s ON c.[StateProvinceID] = s.[StateProvinceID]
    WHERE s.[StateProvinceName] = 'Utah'
INTERSECT
SELECT DISTINCT c.[CityName]
    FROM [Application].[Cities] AS c
    JOIN [Application].[StateProvinces] AS s ON c.[StateProvinceID] = s.[StateProvinceID]
    WHERE s.[StateProvinceName] = 'Wyoming'


---- 6-2
-- 1.
USE AdventureWorks2019;
GO

SELECT soh.[SalesOrderID], CAST(soh.[OrderDate] AS date), sod.[ProductID]
    FROM [Sales].[SalesOrderHeader] AS soh
    JOIN (SELECT [SalesOrderID], [ProductID]
            FROM [SALES].[SalesOrderDetail]) AS sod ON soh.[SalesOrderID] = sod.[SalesOrderID];


-- 2.
WITH orderdetail AS (
    SELECT [SalesOrderID], [ProductID]
            FROM [SALES].[SalesOrderDetail]
    )
SELECT soh.[SalesOrderID], soh.[OrderDate], orderdetail.ProductID
    FROM [Sales].[SalesOrderHeader] as soh
    JOIN orderdetail ON soh.[SalesOrderID] = orderdetail.[SalesOrderID];
GO

-- 3.
WITH [order] AS (
    SELECT [SalesOrderID], [OrderDate], [CustomerID]
        FROM [Sales].[SalesOrderHeader]
    )
SELECT  c.[CustomerID], [order].[SalesOrderID], [order].[OrderDate]
    FROM [Sales].[Customer] AS c
    JOIN [order] ON c.[CustomerID] = [order].[CustomerID]
    WHERE Year([order].[OrderDate]) = '2011';

-- 4.
USE WideWorldImporters;
GO
SELECT [CustomerName], [CustomerID] FROM (SELECT [CustomerID], [CustomerName] FROM [Sales].[Customers]) AS Cust;
-- Kan kun returnerer data der er i tabellen under FROM i derived, så fx PosalCityID kan ikke returneres, som
--SELECT [CustomerName], [CustomerID], [PostalCityCode] FROM (SELECT [CustomerID], [CustomerName] FROM [Sales].[Customers]) AS Cust;

-- 5.
USE WideWorldImporters;
GO
-- Der skal være en AS alias til den dirived tabel.
--SELECT [CustomerName], [CustomerID] FROM (SELECT [CustomerID], [CustomerName] FROM [Sales].[Customers]);
-- Ellers er der syntaks fejl.