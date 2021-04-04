---- 7-1

-- 1.
USE AdventureWorks2019;
GO
SELECT COUNT(*) FROM [Sales].[Customer];

-- 2.
USE AdventureWorks2019;
GO
SELECT SUM(OrderQty) FROM [Sales].[SalesOrderDetail];

-- 3.
USE AdventureWorks2019;
GO
SELECT MAX(UnitPrice) FROM [Sales].[SalesOrderDetail];
SELECT Format(MAX(UnitPrice), 'N2') AS 'MaxUnitePrice' FROM [Sales].[SalesOrderDetail];
SELECT Cast(MAX(UnitPrice) as numeric(17,2)) AS 'MaxUnitePrice' FROM [Sales].[SalesOrderDetail];

-- 4.
USE AdventureWorks2019;
GO
SELECT AVG(Freight) AS 'Average Freight' FROM [Sales].[SalesOrderHeader];

-- 5.
USE AdventureWorks2019;
GO
SELECT MIN(ListPrice) AS 'Min', MAX(ListPrice) AS 'Max', AVG(ListPrice) AS 'Avg' FROM [Production].[Product];

-- 6.
USE WideWorldImporters;
GO
SELECT AVG([UnitPrice]) AS 'AvgPrice' FROM [Sales].[OrderLines];

-- 7.
USE WideWorldImporters;
GO
SELECT  MAX([TransactionAmount]) AS 'TransactionAmount',
        MAX([AmountExcludingTax] + [TaxAmount]) AS 'Amount + Tax'
    FROM [Purchasing].[SupplierTransactions];


---- 7-2

-- 1.
USE AdventureWorks2019;
GO
SELECT [ProductID], SUM(OrderQty) AS 'Total ordered'
    FROM [Sales].[SalesOrderDetail]
    GROUP BY [ProductID];

-- 2.
USE AdventureWorks2019;
GO
SELECT [SalesOrderID], COUNT(*) AS 'NumberOfLines'
    FROM [Sales].[SalesOrderDetail]
    GROUP BY [SalesOrderID];

-- 3.
USE AdventureWorks2019;
GO
SELECT [ProductLine], COUNT(*)
    FROM [Production].[Product]
    GROUP BY [ProductLine];

-- 4.
USE AdventureWorks2019;
GO
SELECT [CustomerID], YEAR([OrderDate]), COUNT(*) AS 'Orders'
    FROM [Sales].[SalesOrderHeader]
    GROUP BY [CustomerID], YEAR([OrderDate])
    ORDER BY [CustomerID], YEAR([OrderDate]);

-- 5.
USE WideWorldImporters;
GO
SELECT Continent, COUNT(CountryName) AS 'CountCountries'
    FROM [Application].[Countries]
    GROUP BY Continent
    ORDER BY Continent;

-- 6.
USE WideWorldImporters;
GO
SELECT InvoiceID, Count(*) AS cnt
    FROM Sales.InvoiceLines;
-- 
SELECT InvoiceID, Count(*) AS cnt
    FROM Sales.InvoiceLines
    GROUP BY InvoiceID;    

---- 7-3

-- 1.
USE AdventureWorks2019;
GO
SELECT SalesOrderID, COUNT(*) AS 'Count'
    FROM [Sales].[SalesOrderDetail]
    GROUP BY SalesOrderID
    HAVING COUNT(*) > 3;

-- 2.
USE AdventureWorks2019;
GO
SELECT SalesOrderID, SUM(LineTotal) AS 'LineTotal'
    FROM [Sales].[SalesOrderDetail]
    GROUP BY SalesOrderID
    HAVING SUM(LineTotal) > 1000;

-- 3.
USE AdventureWorks2019;
GO
SELECT ProductModelID, COUNT(*) AS 'ProductCount'
    FROM [Production].[Product]
    GROUP BY ProductModelID
    HAVING COUNT(*) = 1;

-- 4.
USE AdventureWorks2019;
GO
SELECT ProductModelID, COUNT(*) AS 'ProductCount', Color
    FROM [Production].[Product]
    GROUP BY ProductModelID, Color
    HAVING Color IN ('Blue', 'Red')
    ORDER BY ProductModelID;

USE AdventureWorks2019;
GO
SELECT ProductModelID, COUNT(*) AS 'ProductCount', Color
    FROM [Production].[Product]
    WHERE Color IN ('Blue', 'Red')
    GROUP BY ProductModelID, Color
    HAVING COUNT(*) = 1; 

SELECT ProductModelID, ProductID, Color FROM [Production].[Product]
    WHERE Color IN ('Blue', 'Red')
        AND ProductModelID != 33;

-- 5.
USE WideWorldImporters;
GO
SELECT StockItemID, SUM(QuantityOnHand) AS 'QuantityOnHandSum'
    FROM [Warehouse].[StockItemHoldings]
    GROUP BY StockItemID
    ORDER BY SUM(QuantityOnHand) DESC;
-- Men dette giver ikke meget mening?
SELECT StockItemID, QuantityOnHand
    FROM [Warehouse].[StockItemHoldings]
    ORDER BY StockItemID;

-- 6.
USE WideWorldImporters;
GO
SELECT * FROM [Purchasing].[SupplierTransactions] ORDER BY TransactionDate;

SELECT TransactionDate, COUNT(*) AS 'TransactionCount'
    FROM [Purchasing].[SupplierTransactions]
    WHERE YEAR(TransactionDate) = 2016
        AND DATEPART(quarter, TransactionDate) = 1
    GROUP BY TransactionDate
    HAVING COUNT(*) > 1
    ORDER BY TransactionDate;


---- 7-4

-- 1.
USE AdventureWorks2019;
GO
SELECT COUNT(*) AS 'Count', COUNT(DISTINCT ProductID ) AS 'DistinctCount'
    FROM [Sales].[SalesOrderDetail];

-- 2.
SELECT CustomerID, COUNT(DISTINCT TerritoryID) AS 'DistinctTerritoryID'
    FROM [Sales].[SalesOrderHeader]
    GROUP BY CustomerID;

SELECT CustomerID, COUNT(DISTINCT TerritoryID) AS 'DistinctTerritoryID'
    FROM [Sales].[SalesOrderHeader]
    GROUP BY CustomerID
    ORDER BY COUNT(DISTINCT TerritoryID) DESC, CustomerID;

-- 3.
USE WideWorldImporters;
GO

SELECT DISTINCT UnitPrice 
    FROM [Sales].[OrderLines]
    ORDER BY UnitPrice DESC;

-- 4.
SELECT UnitPrice
    FROM [Sales].[OrderLines]
    GROUP BY UnitPrice
    ORDER BY UnitPrice DESC;


---- 7-5
-- 1.
USE AdventureWorks2019;
GO
SELECT p.FirstName + ' ' + p.LastName AS 'Name', COUNT(soh.SalesOrderID) AS 'SalesOrderCount'
    FROM [Person].[Person] AS p
    JOIN [Sales].[Customer] AS c ON c.PersonID = p.BusinessEntityID
    JOIN [Sales].[SalesOrderHeader] AS soh ON soh.CustomerID = c.CustomerID
    GROUP BY p.FirstName, p.LastName;

-- 2.
USE AdventureWorks2019;
GO
SELECT p.Name, soh.OrderDate, SUM(sod.OrderQty) AS 'OrderQuantitySum'
    FROM [Sales].[SalesOrderHeader] AS soh
    JOIN [Sales].[SalesOrderDetail] AS sod ON sod.SalesOrderID = soh.SalesOrderID
    JOIN [Production].[Product] AS p ON p.ProductID = sod.ProductID
    GROUP BY p.Name, soh.OrderDate
    ORDER BY p.Name, soh.OrderDate;

-- Facitlisten har denne:
SELECT p.Name, soh.OrderDate, SUM(sod.OrderQty) AS 'OrderQuantitySum'
    FROM [Sales].[SalesOrderHeader] AS soh
    JOIN [Sales].[SalesOrderDetail] AS sod ON sod.SalesOrderDetailID = soh.SalesOrderID -- Dette kan ikke passe?!?!
    JOIN [Production].[Product] AS p ON p.ProductID = sod.ProductID
    GROUP BY p.Name, soh.OrderDate
    ORDER BY p.Name, soh.OrderDate;

SELECT * FROM [Sales].[SalesOrderDetail]

-- 3.
USE WideWorldImporters;
GO
SELECT sup.SupplierID, sup.SupplierName, supcat.SupplierCategoryName, people.PreferredName,
        people.PhoneNumber, sup.WebsiteURL,
        COUNT(po.PurchaseOrderId) AS 'OrderCount'
    FROM [Purchasing].[Suppliers] AS sup
    JOIN [Purchasing].[SupplierCategories] AS supcat ON supcat.SupplierCategoryID = sup.SupplierCategoryID
    JOIN [Application].[People] AS people ON people.PersonID = sup.PrimaryContactPersonID
    LEFT OUTER JOIN [Purchasing].[PurchaseOrders] AS po ON po.SupplierID = sup.SupplierID
    GROUP BY sup.SupplierID, sup.SupplierName, supcat.SupplierCategoryName, people.PreferredName,
        people.PhoneNumber, sup.WebsiteURL;
-- Facitliste:
SELECT sup.SupplierID, sup.SupplierName, supcat.SupplierCategoryName, people.FullName,
        sup.PhoneNumber, sup.FaxNumber, sup.WebsiteURL,
        COUNT(po.PurchaseOrderId) AS 'OrderCount'
    FROM [Purchasing].[Suppliers] AS sup
    JOIN [Purchasing].[SupplierCategories] AS supcat ON supcat.SupplierCategoryID = sup.SupplierCategoryID
    JOIN [Application].[People] AS people ON people.PersonID = sup.PrimaryContactPersonID
    LEFT OUTER JOIN [Purchasing].[PurchaseOrders] AS po ON po.SupplierID = sup.SupplierID
    GROUP BY sup.SupplierID, sup.SupplierName, supcat.SupplierCategoryName, people.FullName,
        sup.PhoneNumber, sup.FaxNumber, sup.WebsiteURL;

SELECT * FROM [Purchasing].[PurchaseOrders]