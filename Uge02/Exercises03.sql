-- 3.1
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