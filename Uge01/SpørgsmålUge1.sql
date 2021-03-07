-- Uge 1 3 spørgsmål:
-- 1: Hvormange personer er der i tabellen Person.Person?
-- Der er 19972, der er dog kun 19801 unike navne.
USE AdventureWorks2019;
SELECT count(*) as [#Persons] from Person.Person;
SELECT FirstName, MiddleName, LastName from Person.Person;
SELECT count( distinct (FirstName + coalesce(MiddleName, ' ') + LastName)) from Person.Person;
SELECT distinct FirstName, MiddleName, LastName from Person.Person;

-- 2: Er der, i tabellen Person.Address, en 1:1 mellem city og postalcode.
--  Nej der 575 unikke cities og der er 661 unikke postalcodes.
USE AdventureWorks2019;
SELECT top 10 * FROM Person.Address;
SELECT count(*) FROM Person.Address;
SELECT count(distinct(City+PostalCode)) AS [City+PostalCode], count(distinct(PostalCode+City)) AS [PostalCode+City] FROM Person.Address;
SELECT count(distinct City) AS [#Cities], COUNT(distinct PostalCode) AS [#PostalCode] FROM Person.Address;

-- 3: Hvad bruges kollenen Person.Person.Demographics til
-- <IndividualSurvey xmlns="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"><TotalPurchaseYTD>0</TotalPurchaseYTD></IndividualSurvey>
USE AdventureWorks2019;
SELECT top 5 * FROM Person.Person;


