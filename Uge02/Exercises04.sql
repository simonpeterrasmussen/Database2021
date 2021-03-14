---- 4.1
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


---- 4.2
-- 1.
USE AdventureWorks2019;
SELECT SpecialOfferID, [Description], MaxQty - MinQty As 'MaxQty - Min'
    FROM [Sales].[SpecialOffer]