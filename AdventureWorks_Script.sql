--Part 2
USE AdventureWorks2022
--Basic queries
SELECT BusinessEntityID, JobTitle, HireDate FROM HumanResources.Employee;

SELECT ProductNumber,Name,SellStartDate FROM Production.Product;

--Filtering
SELECT * FROM HumanResources.Employee
WHERE VacationHours > 50				--147 employess have vacation hours greater than 50

SELECT * FROM Production.Product
WHERE StandardCost <100;					--311 products returned

--Aggregates
SELECT COUNT(*) AS Total_Products
FROM Production.Product;				--Total product is 504

SELECT MIN(ListPrice) AS minimum_list_price
FROM Production.Product;					--minimum list price is 0

--Grouping (group by)
SELECT ProductModelID, COUNT(*) AS product_count
FROM Production.Product
WHERE ProductModelID IS NOT NULL
GROUP BY ProductModelID;

SELECT SalesPersonID, SUM(TotalDue) AS Total_Sales
FROM Sales.SalesOrderHeader
WHERE SalesPersonID IS NOT NULL  -- To ensure no NULL values affect grouping
GROUP BY SalesPersonID;

--ordering
SELECT Name, Weight
FROM Production.Product
WHERE Weight IS NOT NULL
ORDER BY Weight ASC;					--default is ascending

SELECT LastName, FirstName
FROM Person.Person
ORDER By LastName DESC;

--Having
SELECT ProductModelID, COUNT (*) AS Product_model_count
FROM Production.Product
WHERE ProductModelID IS NOT NULL
GROUP BY ProductModelID
HAVING ProductModelID > 10;

SELECT SalesPersonID, SUM(TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader
WHERE SalesPersonID IS NOT NULL
GROUP BY SalesPersonID
HAVING SUM(TotalDue) > 50000;

--Top
SELECT TOP (10) ProductID, Name
FROM Production.Product;

SELECT TOP 5 CustomerID, SUM(TotalDue) 
FROM Sales.SalesOrderHeader
GROUP BY CustomerID;

--Joins
SELECT 
    p.FirstName, 
    p.LastName, 
    d.Name AS DepartmentName
FROM HumanResources.Employee e
JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
JOIN HumanResources.EmployeeDepartmentHistory edh ON e.BusinessEntityID = edh.BusinessEntityID
JOIN HumanResources.Department d ON edh.DepartmentID = d.DepartmentID;

SELECT 
    p.Name AS ProductName, 
    ps.Name AS SubcategoryName
FROM Production.Product p
LEFT JOIN Production.ProductSubcategory ps 
    ON p.ProductSubcategoryID = ps.ProductSubcategoryID;

--Like
SELECT *
FROM Production.Product
WHERE Name LIKE '%Road%';

SELECT * 
FROM Purchasing.Vendor
WHERE Name LIKE '%cycles';

--Between
SELECT *
FROM HumanResources.Employee
WHERE HireDate BETWEEN '2017-01-01' AND '2017-12-31';		--No employee was hired between january 1st 2017 and december 31st 2017

SELECT *
FROM Production.Product  
WHERE ListPrice BETWEEN 200 AND 800;

--And/or
SELECT *
FROM HumanResources.Employee
WHERE Gender = 'F' AND VacationHours >30;

SELECT *
FROM Production.Product
WHERE Color = 'Black' OR SafetyStockLevel < 1000;

--Is Null/Null
SELECT Suffix
FROM Person.Person
WHERE Suffix IS NULL;			--19,919 rows have no suffix

SELECT *
FROM Production.Product
WHERE SizeUnitMeasureCode IS NULL;

--BONUS QUESTIONS
--CASE statement
SELECT BusinessEntityID, JobTitle,HireDate, VacationHours,
	CASE
		WHEN VacationHours < 20 THEN 'Low'
		WHEN VacationHours BETWEEN 20 AND 50 THEN 'Medium'
		ELSE 'High'
	END AS Vacation_category
FROM HumanResources.Employee;

--string functions
SELECT Name AS Full_name,
	LEFT(Name, 3) AS First_3_name
FROM Production.Product

SELECT FirstName, LastName,
CONCAT (FirstName,' ',LastName) AS Full_name
FROM Person.Person;

--Date function
SELECT BirthDate,
DATEDIFF(YEAR, BirthDate, GETDATE()) AS Age
FROM HumanResources.Employee;

SELECT *
FROM Sales.SalesOrderHeader
WHERE MONTH(OrderDate) = MONTH(GETDATE()) 
AND YEAR (OrderDate) = YEAR(GETDATE());				--no output. incorrect code??????

--subqueries
SELECT *
FROM Production.Product
WHERE ListPrice = (SELECT MAX(ListPrice) FROM Production.Product);