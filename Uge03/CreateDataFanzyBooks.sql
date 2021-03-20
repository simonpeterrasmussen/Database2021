-- Insert default data into the database FanzyBooks.
USE FanzyBooks;
GO

-- Create Category values:
EXECUTE dbo.CreateCategory 'Kogebøger', 'Bøger der indeholder opskrifter.'
EXECUTE dbo.CreateCategory 'Krimi', 'Kriminalhistorier'
EXECUTE dbo.CreateCategory 'SciFi', 'Science Fiction'
EXECUTE dbo.CreateCategory 'Gyser', 'Historier der giver et gys.'
EXECUTE dbo.CreateCategory 'Hobby', 'Bøger om hobbies'
EXECUTE dbo.CreateCategory 'Biler', 'Bilbøger'
EXECUTE dbo.CreateCategory 'Årbog', 'Årbøger'
EXECUTE dbo.CreateCategory 'XML', 'Bøger om XML formatet.'
EXECUTE dbo.CreateCategory 'Programmering', 'Bøger der beskriver programmering.'
EXECUTE dbo.CreateCategory 'SQL', 'Bøger der omhandler SQL programmering.'
EXECUTE dbo.CreateCategory 'JavaScript', 'Bøger der omhandler JavaScript programmering.';
GO

-- Create Authors:
EXECUTE [dbo].[CreateAuthor] 'Kathi', 'Kellenberg', 'kk@apress.com';
EXECUTE [dbo].[CreateAuthor] 'Lee', 'Everest', 'le@apress.com';
EXECUTE [dbo].[CreateAuthor] 'Mike', 'McGrath', 'mm@ineasysteps.com';
EXECUTE [dbo].[CreateAuthor] 'Thomas', 'Connolly', 'tc@pearson.com';
EXECUTE [dbo].[CreateAuthor] 'Carolyn', 'Begg', 'cb@pearson.com';
EXECUTE [dbo].[CreateAuthor] 'Elliotte Rusty', 'Harold', 'erh@idgbooks.com';
GO

-- Create Books:
EXECUTE [dbo].[CreateBook] 'Beginning T-SQL', 'A Step-by-Step Approach', '9781484266052', 299.00
EXECUTE [dbo].[CreateBook] 'SQL in easy steps', 'SQL for web developers, programmers & students', '9781840785432', 139.00
EXECUTE [dbo].[CreateBook] 'JavaScript in easy steps', 'Create functions for the web', '9781840785702', 139.00
EXECUTE [dbo].[CreateBook] 'Database Systems', 'A Practical Approach to Design, implementation and Management', '9781292061184', 399.95;
GO

-- Insert rows into table 'BookCategory' in schema '[dbo]'
INSERT INTO [dbo].[BookCategory]
( [BookId], [CategoryId] )
VALUES
( 1, 9 ),
( 1, 10),
( 2, 9 ),
( 2, 10),
( 3, 9 ),
( 3, 11),
( 4, 10)
GO

-- Insert rows into table 'AuthorBook' in schema '[dbo]'
INSERT INTO [dbo].[AuthorBook]
( [AuthorId], [BookId] )
VALUES
( 1, 1 ),
( 2, 1 ),
( 3, 2 ),
( 3, 3 ),
( 4, 4 ),
( 5, 4 )
GO