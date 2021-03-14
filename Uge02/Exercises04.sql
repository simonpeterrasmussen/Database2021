---- 4-1
-- 1.
USE AdventureWorks2019;
SELECT AddressLine1 + ' (' + City + ' ' + PostalCode + ')'
    FROM [Person].[Address]

-- 2.
USE AdventureWorks2019;
SELECT ProductID, Coalesce(Color, 'No Color') as Color, [Name]
    FROM [Production].[Product];

-- 3.
USE AdventureWorks2019;
SELECT ProductID, [Name] + Coalesce(' ' + Color, '') as 'Description'
    FROM [Production].[Product];

-- 4. 
USE AdventureWorks2019;
SELECT CAST(ProductID AS nvarchar) + ': ' + Name AS 'Description'
    FROM [Production].Product

-- 5:
USE WideWorldImporters;
SELECT CONCAT(CityName, '-', LatestRecordedPopulation) AS 'City & Pupulation'
    FROM [Application].[Cities];

USE WideWorldImporters;
SELECT CONCAT(CityName, '-', Coalesce(CAST(LatestRecordedPopulation as nvarchar), ' ?')) AS 'City & Pupulation'
    FROM [Application].[Cities];

-- 6.
USE WideWorldImporters;
SELECT FullName + ' (' + SearchName + ')' as 'FullName (SearchName)'
    FROM [Application].[People];

-- 7.
USE WideWorldImporters;
SELECT CityName, COALESCE(LatestRecordedPopulation, 0) as 'Population'
    FROM [Application].[Cities];

-- 8.
USE WideWorldImporters;
SELECT CityName, COALESCE(LatestRecordedPopulation, 'N/A') as 'Population'
    FROM [Application].[Cities];
-- 'N/A' er en char type og LatestRecordedPopulation er en integer, så der kommer en konverteringsfejl.
USE WideWorldImporters;
SELECT CityName, COALESCE(CAST(LatestRecordedPopulation as nvarchar), 'N/A') as 'Population'
    FROM [Application].[Cities];

-- 9.
-- Forskellen mellem ISNULL og COALESCE der begge tjekker for om et felt indeholder NULL:
-- ISNULL():      Skal have 2 parametre, den første der tjekkes for NULL og den næste der erstatter. Er ikke ANSI standard.
-- COALESCE():    Kan modtage et vilkårligt antal parametre og returnerer den første der ikk er NULL. Er ANSI standard.


---- 4-2
-- 1.
USE AdventureWorks2019;
SELECT SpecialOfferID, [Description], MaxQty - MinQty As 'MaxQty - Min'
    FROM [Sales].[SpecialOffer];

USE AdventureWorks2019;
SELECT SpecialOfferID, [Description], COALESCE(MaxQty - MinQty, '') As 'MaxQty - Min'
    FROM [Sales].[SpecialOffer];

-- 2.
USE AdventureWorks2019;
SELECT SpecialOfferID, [Description], MinQty * DiscountPct as 'MinQty * DiscountPct'
    FROM [Sales].[SpecialOffer];

-- 3.
USE AdventureWorks2019;
SELECT SpecialOfferID, [Description], COALESCE(MaxQty, 10) * DiscountPct as 'MaxQty * DiscountPct'
    FROM [Sales].[SpecialOffer];

-- 4.
USE WideWorldImporters;
SELECT StockItemID, Quantity * UnitPrice as 'Extended Price', ((Quantity * UnitPrice) * 0.15) AS 'Tax', ((Quantity * UnitPrice) + ((Quantity * UnitPrice) * 0.15)) AS 'Extended Amount'
    FROM [Sales].[OrderLines];

-- 5.
-- Division:    Antal gange et tal kan adderes inden der bliver størrer en det andet:  9 DIV 4 er 2, 4 kan adderes 2 gange unden at blive mere end 9.
-- Modulo:      Hvad er tilbage efter en heltals division: 9 MOD 4 er 1, 9 DIV 4  er 2 og 9 - (4 * 2) = 1.

---- 4-3
-- 1.
USE AdventureWorks2019;
SELECT LEFT(AddressLine1 , 10) AS 'First 10'
    FROM [Person].[Address];

-- 2.
USE AdventureWorks2019;
SELECT AddressLine1, SUBSTRING(AddressLine1 , 10, 6) AS '10 - 15'
    FROM [Person].[Address];

-- 3.
SELECT UPPER(FirstName) AS 'FirstName', UPPER(LastName) AS 'LastName'
    FROM [Person].[Person];

-- 4.
USE AdventureWorks2019;
SELECT ProductNumber, CHARINDEX('-',ProductNumber), SUBSTRING(ProductNumber, CHARINDEX('-',ProductNumber) + 1, 50)
    FROM [Production].[Product];

USE AdventureWorks2019;
SELECT ProductNumber, SUBSTRING(ProductNumber, CHARINDEX('-',ProductNumber) + 1, 50) as 'After -'
    FROM [Production].[Product];

-- 5.
USE WideWorldImporters;
SELECT UPPER(LEFT(CountryName, 3)) AS 'NewCode', IsoAlpha3Code
    FROM [Application].[Countries];

-- 6.
USE WideWorldImporters;
SELECT CustomerName, 
        SUBSTRING(CustomerName, CHARINDEX('(', CustomerName),  CHARINDEX(')', CustomerName) - CHARINDEX('(', CustomerName) + 1 )
    FROM [Sales].[Customers];

-- Løsning i bog:
USE WideWorldImporters;
SELECT CustomerName, 
        SUBSTRING(CustomerName, CHARINDEX('(', CustomerName),  CHARINDEX(')', CustomerName))
    FROM [Sales].[Customers];

---- 4-4
-- 1.
Use AdventureWorks2019;
SELECT SalesOrderID, OrderDate, ShipDate, DATEDIFF(DAY, OrderDate, ShipDate) AS 'Placed to Ship'
    FROM [Sales].[SalesOrderHeader];

-- 2.
Use AdventureWorks2019;
SELECT SalesOrderID, CONVERT(nvarchar, OrderDate, 23) AS 'OrderDate', CONVERT(nvarchar, ShipDate, 23) AS 'ShipData'
    FROM [Sales].[SalesOrderHeader];

-- 3.
USE AdventureWorks2019;
SELECT SalesOrderID, OrderDate, DATEADD(MM, 6, OrderDate) AS 'Add 6 month'
    FROM [Sales].[SalesOrderHeader];

-- 4.
USE AdventureWorks2019;
SELECT SalesOrderID, OrderDate, YEAR(OrderDate) AS 'Year', MONTH(OrderDate) AS 'Month'
    FROM [Sales].[SalesOrderHeader];

-- 5.
USE AdventureWorks2019;
SELECT SalesOrderID, OrderDate, YEAR(OrderDate) AS 'Year', FORMAT(OrderDate, 'MMM') AS 'Month'
    FROM [Sales].[SalesOrderHeader];

-- 6.
USE AdventureWorks2019;
SELECT CONVERT(nvarchar, GETDATE(), 23) AS 'Today', CONVERT(nvarchar, DATEADD(qq, -5, GETDATE()), 23) AS 'Past 5 quarters' ;
SELECT FORMAT(GETDATE(), 'yyyy-MM-dd') AS 'Today',  FORMAT(DATEADD(qq, -5, GETDATE()), 'yyyy-MM-dd' ) AS 'Past 5 quarters' ;


---- 4-5
-- 1.
USE AdventureWorks2019;
SELECT SalesOrderID, SubTotal, ROUND(SubTotal, 2) AS 'SubTotal'
    FROM [Sales].[SalesOrderHeader];
USE AdventureWorks2019;

-- 2.
SELECT SalesOrderID, SubTotal, CONVERT(numeric(38,2), ROUND(SubTotal, 2)) AS 'SubTotalA'
    FROM [Sales].[SalesOrderHeader];
USE AdventureWorks2019;
SELECT SalesOrderID, SubTotal, CONVERT(numeric(38,2), SubTotal) AS 'SubTotalB'
    FROM [Sales].[SalesOrderHeader];

-- 3.
USE AdventureWorks2019;
SELECT SalesOrderID, SQRT(SalesOrderID) AS 'Sqrt'
    FROM [Sales].[SalesOrderHeader];
USE AdventureWorks2019;
SELECT SalesOrderID, SQRT(SalesOrderID) AS 'Sqrt', SQUARE(SQRT(SalesOrderID)) AS 'BackAndForht'
    FROM [Sales].[SalesOrderHeader];

-- 4.
SELECT CAST(RAND() * 100 AS int) + 1 AS '1 - 100';

-- 5.
SELECT '55.6854' AS 'Value', '56.0000' AS 'WillBe', ROUND(55.6854, 0) AS 'Round0', CAST(55.6854 as DEC(38,0)) AS 'CAST';
SELECT '55.6854' AS 'Value', '55.7000' AS 'WillBe', ROUND(55.6854, 1) AS 'Round1', CAST(55.6854 as DEC(38,1)) AS 'CAST'; 
SELECT '55.6854' AS 'Value', '55.6900' AS 'WillBe', ROUND(55.6854, 2) AS 'Round2', CAST(55.6854 as DEC(38,2)) AS 'CAST';
SELECT '55.6854' AS 'Value', '55.6850' AS 'WillBe', ROUND(55.6854, 3) AS 'Round3', CAST(55.6854 as DEC(38,3)) AS 'CAST';
SELECT '55.6854' AS 'Value', '55.6854' AS 'WillBe', ROUND(55.6854, 4) AS 'Round4', CAST(55.6854 as DEC(38,4)) AS 'CAST';

-- 6.
SELECT SQRT(4), SQRT(4.5);
DECLARE @f AS FLOAT;
SET @f = 9.009;
SELECT SQRT(@f);
-- True. Function SQRT() kan håndtere både int og float.


-- 4-6
-- 1.
USE AdventureWorks2019;
SELECT BusinessEntityID, --(BusinessEntityID % 2),
        CASE
            WHEN ((BusinessEntityID % 2) = 0) THEN 'Even'
            ELSE 'Odd'
        END AS 'Even or Odd'
    FROM [HumanResources].[Employee];

-- 2.
USE AdventureWorks2019
SELECT SalesOrderID, OrderQty,
    CASE
        WHEN OrderQty < 10 THEN 'Under 10'
        WHEN OrderQty < 20 THEN '10 - 19'
        WHEN OrderQty < 30 THEN '20 - 29'
        WHEN OrderQty < 40 THEN '30 - 39'
        ELSE '40 and over'
    END AS 'Value'
    FROM [Sales].[SalesOrderDetail];

-- 3.
USE AdventureWorks2019
SELECT COALESCE(Title + ' ', '') + FirstName + COALESCE(' ' + MiddleName, '') + ' ' + LastName + COALESCE(' ' + Suffix, '') AS 'FullName'
    FROM [Person].[Person];

-- 4.
SELECT  'This server is running ' + CAST(SERVERPROPERTY('Edition') AS nvarchar) +
        ' on instance ' + COALESCE(CAST(SERVERPROPERTY('InstanceName') AS nvarchar), 'Default') +
        ' and the machine is ' + CAST(SERVERPROPERTY('MachineName') AS nvarchar);
SELECT SERVERPROPERTY('Edition'),
       SERVERPROPERTY('InstanceName'),
       SERVERPROPERTY('MachineName')

-- 5.
USE WideWorldImporters;
SELECT DeliveryMethodID,
    CASE
        WHEN DeliveryMethodID in ( 7, 8, 9 ,10) THEN Freight
        ELSE 'Other/Courier'
    END AS 'DeliveryMethod'
    FROM [Purchasing].[PurchaseOrders];

USE WideWorldImporters;
SELECT DeliveryMethodID,
    CASE
        WHEN DeliveryMethodID in ( 7, 8, 9, 10) THEN SupplierReference
        ELSE 'Other/Courier'
    END AS 'DeliveryMethod'
    FROM [Purchasing].[PurchaseOrders];

-- 6.
USE WideWorldImporters;
SELECT DeliveryMethodID,
    IIF(DeliveryMethodID = 7 OR DeliveryMethodID = 8 OR DeliveryMethodID = 9 OR DeliveryMethodID = 10, SupplierReference, 'Other/Courier')
    AS 'DeliveryMethod'
    FROM [Purchasing].[PurchaseOrders];

USE WideWorldImporters;
SELECT DeliveryMethodID,
    IIF(DeliveryMethodID IN (7,8,9,10), SupplierReference, 'Other/Courier')
    AS 'DeliveryMethod'
    FROM [Purchasing].[PurchaseOrders];

---- 4-7
-- 1.
USE AdventureWorks2019;
SELECT SalesOrderID, OrderDate
    FROM [Sales].[SalesOrderHeader]
    WHERE YEAR(OrderDate) = '2011';

-- 2.
USE AdventureWorks2019;
SELECT SalesOrderID, OrderDate
    FROM [Sales].[SalesOrderHeader]
    ORDER BY MONTH(OrderDate), YEAR(OrderDate);

-- 3.
USE AdventureWorks2019
SELECT PersonType, FirstName, MiddleName, LastName
    FROM [Person].[Person]
    ORDER BY
    CASE
        WHEN PersonType IN ('IN', 'SP', 'SC') THEN LastName
        ELSE FirstName
    END;
USE AdventureWorks2019
SELECT PersonType, FirstName, MiddleName, LastName
    FROM [Person].[Person]
    ORDER BY
    CASE PersonType 
        WHEN 'IN' THEN LastName
        WHEN 'SP' THEN LastName
        WHEN 'SC' THEN LastName
        ELSE FirstName
    END;

-- 4.
USE WideWorldImporters;
SELECT CustomerID, OrderDate, DATENAME(weekday, OrderDate) AS 'Orderday'
    FROM [Sales].[Orders]
    WHERE DATENAME(weekday, OrderDate) = 'Saturday'
-- Alternativ. Ugedag 1 er åbenbart søndag.
USE WideWorldImporters;
SELECT CustomerID, OrderDate, DATENAME(weekday, OrderDate) AS 'Orderday'
    FROM [Sales].[Orders]
    WHERE DATEPART(weekday, OrderDate) = 7;    

-- 5.
USE WideWorldImporters;
SELECT CityName, LatestRecordedPopulation
    FROM [Application].[Cities]
    ORDER BY
        CASE 
            WHEN LatestRecordedPopulation IS NULL THEN 1
            ELSE 0 
        END,
        LatestRecordedPopulation;

-- 6.
USE WideWorldImporters
SELECT *
    FROM [Application].[PaymentMethods]
    ORDER BY
    CASE PaymentMethodName
        WHEN 'Cash'  THEN 4
        WHEN 'Check' THEN 1
        WHEN 'Credit-Card' THEN 2
        WHEN 'EFT'   THEN 3
        ELSE 0
    END;

USE WideWorldImporters
SELECT PaymentMethodID, PaymentMethodName, LastEditedBy
    FROM [Application].[PaymentMethods]
    ORDER BY
    CASE WHEN PaymentMethodName = 'Check' THEN 1
         WHEN PaymentMethodName = 'Credit-Card' THEN 2
         WHEN PaymentMethodName = 'EFT'   THEN 3
         WHEN PaymentMethodName = 'Cash'  THEN 4
        ELSE 0
    END;