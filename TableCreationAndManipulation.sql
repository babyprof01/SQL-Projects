USE Assignment

--This is an independent table
CREATE TABLE Authors(
	Author_ID INT PRIMARY KEY,
	First_Name VARCHAR(50),
	Last_Name VARCHAR(50),
	Birth_Year INT
);


--This is also an independent table
CREATE TABLE Categories(
	Category_ID INT PRIMARY KEY,
	Category_Name VARCHAR(100)
);

--This is a dependent table. It depends on authors and categories table
CREATE TABLE Books(
	Book_ID INT PRIMARY KEY,
	Title VARCHAR (100),
	Author_ID INT,
	Category_ID INT,
	Publication_Year INT,
	FOREIGN KEY (Author_ID) REFERENCES Authors (Author_ID),
	FOREIGN KEY (Category_ID) REFERENCES Categories (Category_ID)
);

--This is also an independent table
CREATE TABLE Members(
	Member_ID INT PRIMARY KEY,
	First_Name VARCHAR(50),
	Last_Name VARCHAR(50),
	Membership_Date DATE
);

--This is a dependent table. It depends on members and books table
CREATE TABLE Borrowing(
	Borrowing_ID INT PRIMARY KEY,
	Member_ID INT,
	Book_ID INT,
	Borrow_Date DATE,
	Return_Date DATE
	FOREIGN KEY (Member_ID) REFERENCES Members(Member_ID),
	FOREIGN KEY (Book_ID) REFERENCES Books(Book_ID)
);

--Inserting sample data
INSERT INTO Authors(Author_ID, First_Name, Last_Name,Birth_Year) VALUES
(1,'Deborah', 'Ellis', 1920),
(2, 'Robert', 'Greene', 1930),
(3, 'Kabir', 'Alabi', 1940),
(4, 'Chinua', 'Achebe', 1950),
(5, 'Chimamanda', 'Adichie', 1960),
(6, 'Sarah', 'Ladipo', 1970),
(7, 'Mark', 'Manson', 1980),
(8, 'Benjamin', 'Carson', 1990),
(9, 'Damilare', 'Kuku', 2000),
(10, 'Barrack', 'Obama', 2001);

INSERT INTO Categories (Category_ID, Category_Name) VALUES
(10, 'Fiction'),
(11, 'Self help'),
(12, 'Fiction'),
(13, 'Classic'),
(14, 'Fiction'),
(15, 'Fiction'),
(16, 'Self help'),
(17, 'Autobiography'),
(18, 'Nigerian literature'),
(19, 'Autobiography');


INSERT INTO Books(Book_ID, Title, Author_ID, Category_ID, Publication_Year) VALUES
(2, 'The breadwinner', 1, 10, 2000),
(3, '48 Laws of power', 2, 11, 1998),
(4, 'The Lekki headmaster', 3, 12, 2023),
(5, 'Things fall apart', 4, 13, 1958),
(6, 'Americanah', 5,  14, 2013),
(7, 'In dependence', 6, 15, 2008),
(8, 'The subtle art of not giving a fuck', 7, 16, 2016),
(9, 'Gifted hands', 8, 17, 1990),
(10, 'Nearly all men in Lagos are mad', 9, 18, 2021),
(11, 'Dreams from my father', 10, 19, 1995);

INSERT INTO Members(Member_ID, First_Name, Last_Name, Membership_Date) VALUES
(10, 'Mariam', 'Rasaq', '2022-01-15'),
(20, 'AbdulMalik', 'Mutmainat', '2023-10-25'),
(30, 'David', 'Oladipupo', '2021-05-12'),
(40, 'Baruwa', 'AbdulSlaam', '2020-09-30'),
(50, 'Opeyemi', 'James', '2023-07-20'),
(60, 'Esther', 'Williams', '2019-03-18'),
(70, 'Emmanuel', 'Johnson', '2022-08-10'),
(80, 'Tolu', 'Olaegbe', '2021-12-25'),
(90, 'Toheeb', 'Olalekan', '2023-06-14'),
(99, 'Muatpha', 'Adejuwon', '2020-11-29');

INSERT INTO Borrowing(Borrowing_ID,Member_ID,Book_ID, Borrow_Date, Return_Date) VALUES
(3, 10, 2, '2024-01-10', '2025-02-10'),
(6, 20, 3, '2024-02-15', '2024-03-15'),
(4, 30, 4, '2023-03-10', NULL),					--not returned
(2, 40, 5, '2023-04-20', NULL),					--not returned
(8, 50, 6, NULL, NULL),							--not borrowed
(9, 60, 7, '2024-07-15', '2024-08-15'),
(12, 70, 8, '2024-08-10', '2024-09-10'),
(11, 80, 9, '2024-09-28', NULL),				--not returned
(5, 90, 10, '2024-10-05', '2024-11-05'),
(7, 99, 11, '2024-11-18', '2024-12-18');

SELECT * FROM Borrowing