---- 11-1

DROP TABLE IF EXISTS dbo.Demo;
CREATE TABLE dbo.Demo( ID int PRIMARY KEY, Name VARCHAR(25));
-- 1.
BEGIN TRANSACTION;
    INSERT INTO dbo.Demo (ID, Name)
        VALUES (1, 'AAAA'), (2, 'BBBB');
COMMIT TRANSACTION;
SELECT * FROM dbo.Demo;
GO
-- 2.
BEGIN TRANSACTION;
    INSERT INTO dbo.Demo (ID, Name)
        VALUES ('3', 'CCCC'), ('D', 'DDDD');
COMMIT TRANSACTION;
GO
SELECT * FROM dbo.Demo;
GO
-- Det er ingen af de 2 nye records der bliver indsat i tabellen,
-- selvom det kun er den sidste record der indeholder en fejl.

-- 3.
BEGIN TRANSACTION;

-- 4.
BEGIN TRAN
    SELECT * INTO dbo.Demo2 FROM dbo.Demo
ROLLBACK TRAN;
SELECT * FROM dbo.Demo2;
GO
-- SELECT * INTO opretter tabellen dbo.Demo2, men ROLLBACK TRAN
-- fjerner den igen, så sidste SELECT fejler.

---- 11-2
-- 1.
USE AdventureWorks2019;
GO

SELECT * FROM [HumanResources].[Department];

BEGIN TRY
    INSERT INTO [HumanResources].[Department] 
        (DepartmentID, Name, GroupName, ModifiedDate)
        VALUES (1, 'ENG', 'R&D', GETDATE());
END TRY
BEGIN CATCH
    PRINT 'ErrorNumber: ' + CAST(ERROR_NUMBER() AS NVARCHAR) + '. ' +
        'ErrorMessage: ' + ERROR_MESSAGE() + ' ' +
        'ErrorSeverity: ' + CAST(ERROR_SEVERITY() AS NVARCHAR) + '.';
END CATCH;
GO

BEGIN TRY
    INSERT INTO [HumanResources].[Department] 
        (DepartmentID, Name, GroupName, ModifiedDate)
        VALUES (1, 'ENG', 'R&D', GETDATE());
END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS 'ErrorNumber',
        ERROR_MESSAGE() AS 'ErrorMessage',
        ERROR_SEVERITY() AS 'ErrorSeverity';
END CATCH;
GO

-- 2.
USE AdventureWorks2019;
GO

BEGIN TRY
    INSERT INTO [HumanResources].[Department] 
        (DepartmentID, Name, GroupName, ModifiedDate)
        VALUES (1, 'ENG', 'R&D', GETDATE());
END TRY
BEGIN CATCH
    RAISERROR('Could not insert the record because it already exists.', 16, 1);
END CATCH;
GO

-- 3.
BEGIN
    BEGIN TRY
        SELECT 1.234 + 'A';
    END TRY
    BEGIN CATCH
    END CATCH
END;
-- Ikke god fordi der ikke er noget i CATCH blokken.

-- 4.
RAISERROR('message', 20, 2) WITH LOG;
-- Processen termineres af SQL Server.

-- 5.
BEGIN
    BEGIN TRY
        SELECT 1.234 + 'A';
    END TRY
    BEGIN CATCH
        THROW 59999, 'An error has been thrown', 1;
    END CATCH
END;