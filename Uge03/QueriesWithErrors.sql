USE FanzyBooks;
GO

-- Insert rows into table 'Author' in schema '[dbo]'
INSERT INTO [dbo].[Author]
( -- Columns to insert data into
 [FirstName], [LastName], [email]
)
VALUES
( 
 'First', 'Last', 'kk@apress.com' -- email exist!
);
GO

-- Insert rows into table 'BookCategory' in schema '[dbo]'
INSERT INTO [dbo].[BookCategory]
( [BookId], [CategoryId] )
VALUES
( 1, 9 );
GO

-- Insert rows into table 'AuthorBook' in schema '[dbo]'
INSERT INTO [dbo].[AuthorBook]
( [AuthorId], [BookId] )
VALUES
( 1, 1 );
GO

-- Insert rows into table 'BookCategory' in schema '[dbo]'
INSERT INTO [dbo].[BookCategory]
( [BookId], [CategoryId] )
VALUES
( 0, 9 );
GO
-- Insert rows into table 'BookCategory' in schema '[dbo]'
INSERT INTO [dbo].[BookCategory]
( [BookId], [CategoryId] )
VALUES
( 1, 0 );
GO

-- Insert rows into table 'AuthorBook' in schema '[dbo]'
INSERT INTO [dbo].[AuthorBook]
( [AuthorId], [BookId] )
VALUES
( 0, 1 );
GO
-- Insert rows into table 'AuthorBook' in schema '[dbo]'
INSERT INTO [dbo].[AuthorBook]
( [AuthorId], [BookId] )
VALUES
( 1, 0 );
GO