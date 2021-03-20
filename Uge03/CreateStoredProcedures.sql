-- Stored Procedures used with FanzyBooks.
USE FanzyBooks;
GO

IF EXISTS   (SELECT *
                FROM INFORMATION_SCHEMA.ROUTINES
                WHERE SPECIFIC_SCHEMA = N'dbo'
                    AND SPECIFIC_NAME = N'CreateCategory'
                    AND ROUTINE_TYPE = N'PROCEDURE'
            )
    DROP PROCEDURE dbo.CreateCategory
GO
CREATE or ALTER PROCEDURE [dbo].[CreateCategory]
    @CategoryName NVARCHAR(50) = 'New Cat',
    @Description NVARCHAR(50) = 'New Description'
AS
BEGIN
    INSERT INTO [dbo].[Category]
    ( [Name], [Description] )
    VALUES
    ( 
    @CategoryName, @Description
    )
END
GO

CREATE or ALTER PROCEDURE [dbo].[CreateAuthor]
    @AuthorFirstName NVARCHAR(50) = 'New first',
    @AuthorLastName NVARCHAR(50) = 'New last',
    @email NVARCHAR(50) = 'New email'
AS
BEGIN
    INSERT INTO [dbo].[Author]
    ( [FirstName], [LastName], [email] )
    VALUES
    ( @AuthorFirstName, @AuthorLastName, @email )
END;
GO

CREATE or ALTER PROCEDURE [dbo].[CreateBook]
    @Title NVARCHAR(50) = 'New title',
    @Summery NVARCHAR(50) = 'New summary',
    @ISBN NVARCHAR(13) = 'New ISBN',
    @Price SMALLMONEY = '0.00'
AS
BEGIN
    INSERT INTO [dbo].[Book]
    ( [Title], [Summery], [ISBN], [Price] )
    VALUES
    ( @Title, @Summery, @ISBN, @Price) 
END;
GO

/*IF EXISTS   (SELECT *
                FROM INFORMATION_SCHEMA.ROUTINES
                WHERE SPECIFIC_SCHEMA = N'dbo'
                    AND SPECIFIC_NAME = N'GetBooks'
                    AND ROUTINE_TYPE = N'PROCEDURE'
            )
    DROP PROCEDURE dbo.GetBooks
GO
CREATE or ALTER PROCEDURE dbo.GetBooks_Ver00
    @Title NVARCHAR(50) = '',
    @Catagory NVARCHAR(50) = '',
    @AuthorFirstName NVARCHAR(50) = '',
    @AuthorLastName NVARCHAR(50) = '',
    @ISBN NVARCHAR(13) = '',
    @Summary NVARCHAR(255) = ''--,
    --@Price SMALLMONEY = 0

AS
BEGIN
    SELECT b.[Title], b.[Summery], b.[ISBN], CAST([Price] AS nvarchar) AS 'Price'
           --,a.[FirstName] + ' ' + a.[LastName] as 'Name'
        FROM [Book] AS b
        JOIN [AuthorBook] AS ab ON ab.[BookId] = b.[Id]
        JOIN [Author] AS a ON a.[Id] = ab.[AuthorId]
        WHERE b.[Title] like ('%' + @Title + '%')

            --AND c.[Catagory] like ('%' + @Catagory + '%')
            AND a.[FirstName] like ('%' + @AuthorFirstName + '%')
            AND a.[LastName] like ('%' + @AuthorLastName + '%')

            AND b.[Summery] like ('%' + @Summary + '%')
            AND b.[ISBN] LIKE  ('%' + @ISBN + '%')
            AND b.[Summery] like ('%' + @Summary + '%')
            --AND b.Price LIKE ('%' + @Price + '%')
END
GO*/

CREATE or ALTER PROCEDURE [dbo].[GetBooks]
-- Bøger der matcher parametrene:
    @Title NVARCHAR(50) = '',
    @Catagory NVARCHAR(50) = '',
    @AuthorFirstName NVARCHAR(50) = '',
    @AuthorLastName NVARCHAR(50) = '',
    @ISBN NVARCHAR(13) = '',
    @Summary NVARCHAR(255) = '',
    @Price NVARCHAR(50) = ''
AS
BEGIN
    SELECT DISTINCT b.[Title] AS 'Title', b.[ISBN] AS 'ISBN', CAST(b.[Price] AS nvarchar) AS 'Price',
        STUFF ((SELECT '; ' + [FirstName] + ' ' + [LastName]
                    FROM [dbo].[Author] AS aNames
                    JOIN [dbo].[AuthorBook] as abNames on abNames.[AuthorId] = aNames.[Id]
                    JOIN [dbo].[Book] as bNames on bNames.[Id] = abNames.[BookId]
                    WHERE bNames.[Id] = b.[Id]
                    ORDER BY aNames.LastName, aNames.FirstName
                    FOR XML PATH ('')
                ) , 1, 1, '') AS 'Author(s)',

        STUFF ((SELECT '; ' + [Name]
                    FROM [dbo].[Category] AS cCat
                    JOIN [dbo].[BookCategory] as bcCat on bcCat.[CategoryId] = cCat.[Id]
                    JOIN [dbo].[Book] as bCat on bCat.[Id] = bcCat.[BookId]
                    WHERE bCat.[Id] = b.[Id]
                    ORDER BY cCat.[Name]
                    FOR XML PATH ('')
                ) , 1, 1, '') AS 'Category(ies)',
        b.[Summery] AS 'Summery'
        FROM [dbo].[Book] as b
        -- Author data:
        JOIN [AuthorBook] AS ab ON ab.[BookId] = b.[Id]
        JOIN [Author] AS a ON a.[Id] = ab.[AuthorId]
        -- Category data:
        JOIN [dbo].[BookCategory] as bc on bc.[BookId] = b.[Id]
        JOIN [dbo].[Category] AS c ON c.[Id] = bc.[CategoryId]

        WHERE b.[Title] LIKE ('%' + @Title + '%')
            AND b.[ISBN] LIKE  ('%' + @ISBN + '%')
            AND b.[Summery] LIKE ('%' + @Summary + '%')
            AND a.[FirstName] LIKE ('%' + @AuthorFirstName + '%')
            AND a.[LastName] LIKE ('%' + @AuthorLastName + '%')            
            AND c.[Name] LIKE ('%' + @Catagory + '%' )
            AND b.[Price] LIKE ( '%' + @Price + '%')
        ORDER BY [Title]
END;
GO


CREATE or ALTER PROCEDURE [dbo].[GetAllBooks]
-- Alle bøger med info:
AS
BEGIN
    SELECT DISTINCT b.[Title] AS 'Title', b.[ISBN] AS 'ISBN', CAST(b.[Price] AS nvarchar) AS 'Price',
        STUFF ((SELECT '; ' + [FirstName] + ' ' + [LastName]
                    FROM [dbo].[Author] AS aNames
                    JOIN [dbo].[AuthorBook] as abNames on abNames.[AuthorId] = aNames.[Id]
                    JOIN [dbo].[Book] as bNames on bNames.[Id] = abNames.[BookId]
                    WHERE bNames.[Id] = b.[Id]
                    ORDER BY aNames.LastName, aNames.FirstName
                    FOR XML PATH ('')
                ) , 1, 1, '') AS 'Author(s)',

        STUFF ((SELECT '; ' + [Name]
                    FROM [dbo].[Category] AS cCat
                    JOIN [dbo].[BookCategory] as bcCat on bcCat.[CategoryId] = cCat.[Id]
                    JOIN [dbo].[Book] as bCat on bCat.[Id] = bcCat.[BookId]
                    WHERE bCat.[Id] = b.[Id]
                    ORDER BY cCat.[Name]
                    FOR XML PATH ('')
                ) , 1, 1, '') AS 'Category(ies)'
        FROM [dbo].[Book] as b
        -- Author data:
        JOIN [AuthorBook] AS ab ON ab.[BookId] = b.[Id]
        JOIN [Author] AS a ON a.[Id] = ab.[AuthorId]
        -- Category data:
        JOIN [dbo].[BookCategory] as bc on bc.[BookId] = b.[Id]
        JOIN [dbo].[Category] AS c ON c.[Id] = bc.[CategoryId]
        ORDER BY [Title]
END;
GO