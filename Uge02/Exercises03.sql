---- 3.1
-- 1.
USE AdventureWorks2019;
SELECT CustomerID, StoreID, AccountNumber
    FROM sales.Customer;

-- 2.
SELECT Name, ProductNumber, Color
    FROM Production.Product;

-- 3.
SELECT CustomerID, SalesOrderID
    FROM Sales.SalesOrderHeader;

-- 4.
USE WideWorldImporters;
SELECT StateProvinceCode as "State Abbr/Name:", StateProvinceName
    FROM Application.StateProvinces;

-- 5.
USE WideWorldImporters;
SELECT StateProvinceCode as "ST/Name:", StateProvinceName
    FROM Application.StateProvinces;

-- 6.
USE WideWorldImporters;
SELECT '[Application].[StateProvinves]' as TABLE;
/* Querien fejler, fordi TABLE er et reserveret ord. */

-- 7.
-- Det giver dårligere performance at returnere flere kolonner end nøødvendigt både på db og nettrafik;
-- Der kan være felter der ikke må vises/ses af alle;

---- 3.2
-- 1.
USE AdventureWorks2019;
SELECT BusinessEntityID, LoginID, JobTitle
    FROM HumanResources.Employee
    WHERE JobTitle = 'Research and Development Engineer';

-- 2.
USE AdventureWorks2019;
SELECT *
    FROM Production.ProductCostHistory
    WHERE StandardCost BETWEEN 10 and 13;
    --ORDER BY StandardCost

-- 3.
USE AdventureWorks2019;
SELECT BusinessEntityID, LoginID, JobTitle
    from HumanResources.Employee
    WHERE JobTitle <> 'Research and Development Engineer';

-- 4.
USE WideWorldImporters;
SELECT CityName, LatestRecordedPopulation
    FROM Application.Cities
    WHERE CityName = 'Simi Valley';

-- 5.
USE WideWorldImporters;
SELECT CustomerID, CustomerName, AccountOpenedDate
    FROM Sales.Customers
    WHERE AccountOpenedDate BETWEEN '2016-01-01 00:00:00' AND '2016-12-31 23:59:59'

USE WideWorldImporters;
SELECT CustomerID, CustomerName, AccountOpenedDate
    FROM Sales.Customers
    WHERE AccountOpenedDate BETWEEN '2016-01-01' AND '2016-12-31'

USE WideWorldImporters;
SELECT CustomerID, CustomerName, AccountOpenedDate
    FROM Sales.Customers
    WHERE YEAR(AccountOpenedDate) = '2016'

-- 6.
-- WHERE reducerer antallet af records der sendes ud af databasen.
-- Det er bedre at reducere antallet af records på databasen end i programmet.

---- 3.3
-- 1.
USE AdventureWorks2019;
SELECT SalesOrderID, CONVERT(NVARCHAR, OrderDate, 23) as [Date of Order], TotalDue
    FROM Sales.SalesOrderHeader
    WHERE YEAR(OrderDate) = '2012'
      AND MONTH(OrderDate) = '09'

-- 2.
USE AdventureWorks2019;
SELECT SalesOrderID, CONVERT(NVARCHAR, OrderDate, 23) as [Date of Order], TotalDue
    FROM Sales.SalesOrderHeader
    WHERE (TotalDue >= 10000)
       OR (SalesOrderID < 43000);

-- 3.
USE WideWorldImporters
SELECT *
    FROM [Application].[StateProvinces]
    WHERE StateProvinceID IN ( 1, 45 );

-- 4.
USE WideWorldImporters
SELECT *
    FROM [Application].[StateProvinces]
    WHERE StateProvinceID = 1 OR StateProvinceID = 45;

-- 5.
USE WideWorldImporters
SELECT *
    FROM [Application].[StateProvinces]
    WHERE StateProvinceID NOT IN ( 1, 45 );
-- Denne query returnerer alle records der ikke har StateProvinceID = 1 eller 45,
-- dvs. der returneres 51 records ud af 53.
-- Included er 2 - 44 og 46 - 53.
-- Excluded er 1 og 45.

-- 6.
-- IN operator er god at anvende når resultatet fra sub-query kan anvendes i WHERE clause.
-- IN operator kan anvendes når liste af værdier er kendt.

---- 3.4
-- 1.
USE AdventureWorks2019;
SELECT [ProductID], [Name], [Color]
    FROM [Production].[Product]
    where [Color] IS NULL;

-- 2.
USE AdventureWorks2019;
SELECT [ProductID], [Name], [Color]
    FROM [Production].[Product]
    where [Color] <> 'Blue';

-- 3.
USE AdventureWorks2019;
SELECT [ProductID], [Name], [Style], [Size], [Color]
    FROM [Production].[Product]
    where [Size] IS NOT NULL
       OR [Color] IS NOT NULL;

-- 4.
USE WideWorldImporters;
SELECT *
    FROM [Purchasing].[Suppliers]
    WHERE [DeliveryMethodID] IS NULL;

-- 5.
-- Hvorfor er der NULLs i spørgsmål 4?
-- 1: Det er ikke besluttet endnu hvilken leverings metode der skal anvendes.
-- 2: Leverings metoden er ved at blive ændret.
-- 3: Der er ikke nogen, det er afhæntning.

---- 3.5
-- 1.
USE AdventureWorks2019
SELECT [BusinessEntityID], [FirstName], Coalesce([MiddleName], ''), [LastName]
    FROM [Person].[Person]
    ORDER BY [LastName], [FirstName], [MiddleName]

-- 2.
USE AdventureWorks2019
SELECT [BusinessEntityID], [FirstName], Coalesce([MiddleName], '') as 'MiddleName', [LastName]
    FROM [Person].[Person]
    ORDER BY [LastName] DESC, [FirstName] DESC, [MiddleName] DESC

-- 3.
USE WideWorldImporters
SELECT CountryID, CountryName, FormalName
    FROM [Application].[Countries]
    ORDER BY FormalName ASC;

-- 4.
USE WideWorldImporters
SELECT CountryID, CountryName
    FROM [Application].[Countries]
    ORDER BY FormalName ASC; 
-- Det er OK at sortere på et felt der ikke er i select.       