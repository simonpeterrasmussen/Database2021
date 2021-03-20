-- Create the new database 'FanzyBooks' if it does not exist already and create tables.
IF NOT EXISTS (
    SELECT [name]
        FROM sys.databases
        WHERE [name] = N'FanzyBooks'
)
CREATE DATABASE FanzyBooks
GO

USE FanzyBooks;
GO

-- References must be deleted first if they exist:
IF OBJECT_ID('[dbo].[BookCategory]', 'U') IS NOT NULL
DROP TABLE [dbo].[BookCategory]
GO
IF OBJECT_ID('[dbo].[AuthorBook]', 'U') IS NOT NULL
DROP TABLE [dbo].[AuthorBook]
GO

IF OBJECT_ID('[dbo].[Author]', 'U') IS NOT NULL
DROP TABLE [dbo].[Author]
GO
CREATE TABLE [dbo].[Author]
(
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [FirstName] NVARCHAR(50) NOT NULL,
    [LastName] NVARCHAR(50) NOT NULL,
    [email] NVARCHAR(50) UNIQUE NOT NULL
);
GO

IF OBJECT_ID('[dbo].[Book]', 'U') IS NOT NULL
DROP TABLE [dbo].[Book]
GO
CREATE TABLE [dbo].[Book]
(
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [Title] NVARCHAR(100) NOT NULL,
    [Summery] NVARCHAR(255) NOT NULL,
    [ISBN] NVARCHAR(13) UNIQUE NOT NULL,
    [Price] SMALLMONEY NOT NULL
);
GO

IF OBJECT_ID('[dbo].[Category]', 'U') IS NOT NULL
DROP TABLE [dbo].[Category]
GO
CREATE TABLE [dbo].[Category]
(
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [Name] NVARCHAR(50) NOT NULL,
    [Description] NVARCHAR(255) NULL
);
GO

IF OBJECT_ID('[dbo].[AuthorBook]', 'U') IS NOT NULL
DROP TABLE [dbo].[AuthorBook]
GO
CREATE TABLE [dbo].[AuthorBook]
(
    [AuthorId] INT NOT NULL,
    [BookId] INT NOT NULL,
    CONSTRAINT [UniqueAuthorIdBookId] UNIQUE ([AuthorID], [BookId]),
    CONSTRAINT [FKAuthorBook01] FOREIGN KEY ([AuthorId]) REFERENCES [Author]([Id]),
    CONSTRAINT [FKAuthorBook02] FOREIGN KEY ([BookId]) REFERENCES [Book]([Id])
);
GO

IF OBJECT_ID('[dbo].[BookCategory]', 'U') IS NOT NULL
DROP TABLE [dbo].[BookCategory]
GO
CREATE TABLE [dbo].[BookCategory]
(
    [BookId] INT NOT NULL,
    [CategoryId] INT NOT NULL,
    CONSTRAINT [UniqueBookIdCategoryID] UNIQUE ([BookId], [CategoryId]),
    CONSTRAINT [FKBookCategory01] FOREIGN KEY([BookId]) REFERENCES [Book]([Id]),
    CONSTRAINT [FKBookCategory02] FOREIGN KEY ([CategoryId]) REFERENCES [Category]([ID])
);
GO