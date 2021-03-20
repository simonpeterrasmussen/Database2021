USE FanzyBooks;
GO

-- Bøger og deres kategori
SELECT Book.*, Category.*
    FROM [dbo].[Book]
    JOIN BookCategory ON BookCategory.BookId = Book.Id
    JOIN Category ON Category.Id = BookCategory.CategoryId
    /*WHERE add search conditions here */
GO

-- Fortattere og deres bøger
SELECT Author.*, Book.*
    FROM [dbo].[Author]
    JOIN AuthorBook ON AuthorBook.AuthorId = Author.Id
    JOIN Book ON Book.Id = AuthorBook.BookId
    /*WHERE add search conditions here */
GO


SELECT * FROM [dbo].[Author];
SELECT * FROM [dbo].[Book];
SELECT * FROM [dbo].[Category];

SELECT * FROM [dbo].[AuthorBook]
SELECT * FROM [dbo].[AuthorBook]

EXECUTE dbo.GetBooks;
EXECUTE dbo.GetBooks /*@Title = 'Be',*/ @Summary = 'by'  ;
EXECUTE dbo.GetBooks @AuthorFirstName = 'Lee';
EXECUTE dbo.GetBooks @AuthorLastName = 'eve';
EXECUTE dbo.GetBooks @ISBN = '02';
EXECUTE dbo.GetBooks @Catagory = 'Prog';
EXECUTE dbo.GetBooks @Catagory = 'SQL';
EXECUTE dbo.GetBooks @Price = 13;

EXECUTE [dbo].[GetAllBooks];

GO

-- Alle bøger med info: Ori
SELECT b.[Title], b.[ISBN], --CAST(b.[Price] AS nvarchar) AS 'Price',
    STUFF ((SELECT '; ' + [FirstName] + ' ' + [LastName]
                FROM [dbo].[Author] AS a
                JOIN [dbo].[AuthorBook] as ab on ab.[AuthorId] = a.[Id]
                JOIN [dbo].[Book] as bb on bb.[Id] = ab.[BookId]
                WHERE bb.[Id] = b.[Id]
                FOR XML PATH ('')
            ) , 1, 1, '') AS 'Author(s)',

    STUFF ((SELECT '; ' + [Name]
                FROM [dbo].[Category] AS c
                JOIN [dbo].[BookCategory] as bc on bc.[CategoryId] = c.[Id]
                JOIN [dbo].[Book] as bb on bb.[Id] = bc.[BookId]
                WHERE bb.[Id] = b.[Id]
                FOR XML PATH ('')
            ) , 1, 1, '') AS 'Category(ies)'
    --,b.[Summery]
    FROM [dbo].[Book] as b
    ORDER BY [Title]
GO

-- Alt om en bog: Ori
SELECT b.[Title], b.[ISBN], CAST(b.[Price] AS nvarchar) AS 'Price',
    STUFF ((SELECT '; ' + [FirstName] + ' ' + [LastName]
                FROM [dbo].[Author] AS a
                JOIN [dbo].[AuthorBook] as ab on ab.[AuthorId] = a.[Id]
                JOIN [dbo].[Book] as bb on bb.[Id] = ab.[BookId]
                WHERE bb.[Id] = b.[Id]
                FOR XML PATH ('')
            ) , 1, 1, '') AS 'Author(s)',

    STUFF ((SELECT '; ' + [Name]
                FROM [dbo].[Category] AS c
                JOIN [dbo].[BookCategory] as bc on bc.[CategoryId] = c.[Id]
                JOIN [dbo].[Book] as bb on bb.[Id] = bc.[BookId]
                WHERE bb.[Id] = b.[Id]
                FOR XML PATH ('')
            ) , 1, 1, '') AS 'Category(ies)',
    b.[Summery]
    FROM [dbo].[Book] as b
    ORDER BY [Title]
GO

SELECT [Book].[Title]
    FROM [dbo].[Author]
    JOIN AuthorBook ON AuthorBook.AuthorId = Author.Id
    JOIN Book ON Book.Id = AuthorBook.BookId
    /*WHERE add search conditions here */
GO




-- Alle bøger med info:
SELECT b.[Title], b.[ISBN], --CAST(b.[Price] AS nvarchar) AS 'Price',
    STUFF ((SELECT '; ' + [FirstName] + ' ' + [LastName]
                FROM [dbo].[Author] AS aNames
                JOIN [dbo].[AuthorBook] as abNames on abNames.[AuthorId] = aNames.[Id]
                JOIN [dbo].[Book] as bNames on bNames.[Id] = abNames.[BookId]
                WHERE bNames.[Id] = b.[Id]
                FOR XML PATH ('')
            ) , 1, 1, '') AS 'Author(s)',

    STUFF ((SELECT '; ' + [Name]
                FROM [dbo].[Category] AS cCat
                JOIN [dbo].[BookCategory] as bcCat on bcCat.[CategoryId] = cCat.[Id]
                JOIN [dbo].[Book] as bCat on bCat.[Id] = bcCat.[BookId]
                WHERE bCat.[Id] = b.[Id]
                FOR XML PATH ('')
            ) , 1, 1, '') AS 'Category(ies)'
    --,b.[Summery]
    FROM [dbo].[Book] as b
    ORDER BY [Title]
GO

-- Alt om en bog:
SELECT b.[Title], b.[ISBN], CAST(b.[Price] AS nvarchar) AS 'Price',
    STUFF ((SELECT '; ' + [FirstName] + ' ' + [LastName]
                FROM [dbo].[Author] AS aNames
                JOIN [dbo].[AuthorBook] as abNames on abNames.[AuthorId] = aNames.[Id]
                JOIN [dbo].[Book] as bbNames on bbNames.[Id] = abNames.[BookId]
                WHERE bbNames.[Id] = b.[Id]
                FOR XML PATH ('')
            ) , 1, 1, '') AS 'Author(s)',

    STUFF ((SELECT '; ' + [Name]
                FROM [dbo].[Category] AS cCat
                JOIN [dbo].[BookCategory] as bcCat on bcCat.[CategoryId] = cCat.[Id]
                JOIN [dbo].[Book] as bbCat on bbCat.[Id] = bcCat.[BookId]
                WHERE bbCat.[Id] = b.[Id]
                FOR XML PATH ('')
            ) , 1, 1, '') AS 'Category(ies)',
    b.[Summery]
    FROM [dbo].[Book] as b
    ORDER BY [Title]
GO