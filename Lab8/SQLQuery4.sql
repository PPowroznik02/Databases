--1. Wykorzystując wyrażenie CTE zbuduj zapytanie, które znajdzie informacje na temat stawki
--pracownika oraz jego danych, a następnie zapisze je do tabeli tymczasowej
--TempEmployeeInfo. Rozwiąż w oparciu o AdventureWorks.

WITH TmpEmployeeInfo
AS(
	SELECT FirstName, LastName, e.BirthDate, e.Gender, e.JobTitle, e.LoginID, eph.Rate 
	FROM Person.Person p
	LEFT JOIN HumanResources.EmployeePayHistory eph ON eph.BusinessEntityID = p.BusinessEntityID
	LEFT JOIN HumanResources.Employee e ON eph.BusinessEntityID = e.BusinessEntityID
	WHERE eph.Rate IS NOT NULL

)
SELECT * FROM TmpEmployeeInfo


--2. Uzyskaj informacje na temat przychodów ze sprzedaży według firmy i kontaktu (za pomocą
--CTE i bazy AdventureWorksL). Wynik powinien wyglądać następująco:

WITH TmpRevenueInfo 
AS(
	SELECT (c.CompanyName + ' (' + c.FirstName + ' ' + c.LastName + ')') AS CompanyContact, soh.TotalDue AS Revenue
	FROM SalesLT.Customer c
	INNER JOIN SalesLT.SalesOrderHeader soh ON soh.CustomerID = c.CustomerID
)
SELECT * FROM TmpRevenueInfo ORDER BY CompanyContact

--3. Napisz zapytanie, które zwróci wartość sprzedaży dla poszczególnych kategorii produktów.
--Wykorzystaj CTE i bazę AdventureWorksLT.

WITH TmpProductSaleValue
AS(
	SELECT pc.Name AS Category, ROUND(sod.UnitPrice * sod.OrderQty, 2) AS SalesValue
	FROM SalesLT.Product p
	INNER JOIN SalesLT.ProductCategory pc ON pc.ProductCategoryID = p.ProductCategoryID
	INNER JOIN SalesLT.SalesOrderDetail sod ON sod.ProductID = p.ProductID
)
SELECT Category, SUM(SalesValue) AS SalesValue FROM TmpProductSaleValue
GROUP BY Category ORDER BY SUM(SalesValue) DESC
