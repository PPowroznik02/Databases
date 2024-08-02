USE AdventureWorks2019;

-- 1. Napisz zapytanie, które wykorzystuje transakcję (zaczyna ją), a następnie
-- aktualizuje cenę produktu o ProductID równym 680 w tabeli Production.Product
-- o 10% i następnie zatwierdza transakcję.

BEGIN TRANSACTION 

UPDATE Production.Product SET ListPrice = ListPrice*1.1
WHERE ProductID = 680

COMMIT;



SELECT p.ProductID, ListPrice FROM Production.Product p
WHERE p.ProductID = 680



-- 2. Napisz zapytanie, które zaczyna transakcję, usuwa produkt o ProductID równym
-- 707 z tabeli Production.Product, ale następnie wycofuje transakcję.

BEGIN TRANSACTION 

EXEC sp_MSForEachTable @command1 = "ALTER TABLE ? NOCHECK CONSTRAINT ALL"

DELETE Product 
FROM Production.Product
JOIN Production.ProductCostHistory pch ON Product.ProductID = pch.ProductID
WHERE Product.ProductID = 707; 

ROLLBACK



SELECT * FROM Production.Product p
WHERE p.ProductID = 707



-- 3. Napisz zapytanie, które zaczyna transakcję, dodaje nowy produkt do tabeli
-- Production.Product, a następnie zatwierdza transakcję.

BEGIN TRANSACTION

SET IDENTITY_INSERT Production.Product ON

DECLARE @tmpRowGuid uniqueidentifier
SET @tmpRowGuid = 'A972C577-DFB0-064E-1189-0154C99310DAAC12'

INSERT INTO Production.Product (ProductID,Name,ProductNumber, MakeFlag,FinishedGoodsFlag,Color,SafetyStockLevel,ReorderPoint,StandardCost,ListPrice,Size,SizeUnitMeasureCode,WeightUnitMeasureCode,Weight,DaysToManufacture,ProductLine,Class,Style,ProductSubcategoryID,ProductModelID,SellStartDate,SellEndDate,DiscontinuedDate,rowguid,ModifiedDate)
VALUES (1000, 'Soap', 'SO-1000', 0, 1, 'Grey', 200, 80, 4.20, 8.50,NULL,NULL,'G', 100, 1,NULL,NULL,NULL,NULL,NULL,'2023-05-28 00:00:00:000',NULL,NULL,@tmpRowGuid,'2023-05-28 00:01:00:000')

COMMIT



SELECT * FROM Production.Product
WHERE ProductID = 1000



-- 4. Napisz zapytanie, które zaczyna transakcję i aktualizuje StandardCost wszystkich
-- produktów w tabeli Production.Product o 10%, jeżeli suma wszystkich
-- StandardCost po aktualizacji nie przekracza 50000. W przeciwnym razie zapytanie
-- powinno wycofać transakcję.

BEGIN TRANSACTION

UPDATE Production.Product SET StandardCost = StandardCost*1.1

DECLARE @SUM INTEGER
SET @SUM =(SELECT SUM(StandardCost) FROM Production.Product)

	IF ( @SUM <= 50000) 
		COMMIT
	ELSE
		ROLLBACK



-- 5. Napisz zapytanie SQL, które zaczyna transakcję i próbuje dodać nowy produkt do
-- tabeli Production.Product. Jeśli ProductNumber już istnieje w tabeli, zapytanie
-- powinno wycofać transakcję.

BEGIN TRANSACTION 

BEGIN 
	DECLARE @tmpRowGuid2 uniqueidentifier
	SET @tmpRowGuid2 = 'A972C577-DFB0-064E-1189-3091C99310DAAC12'

	DECLARE @tmpProductNumber nvarchar(25) =   'JEL-1120' --'BK-R19B-52' 

	
	IF EXISTS (SELECT ProductNumber FROM Production.Product WHERE ProductNumber = @tmpProductNumber)
		ROLLBACK
	ELSE
	BEGIN
		INSERT INTO Production.Product (ProductID,Name,ProductNumber, MakeFlag,FinishedGoodsFlag,Color,SafetyStockLevel,ReorderPoint,StandardCost,ListPrice,Size,SizeUnitMeasureCode,WeightUnitMeasureCode,Weight,DaysToManufacture,ProductLine,Class,Style,ProductSubcategoryID,ProductModelID,SellStartDate,SellEndDate,DiscontinuedDate,rowguid,ModifiedDate)
		VALUES (1001, 'Jellies',@tmpProductNumber , 0, 1, 'Rainbow', 100, 60, 4.20, 6.50,NULL,NULL,'G', 200, 1,NULL,NULL,NULL,NULL,NULL,'2023-05-28 00:00:00:000',NULL,NULL,@tmpRowGuid2,'2023-05-28 00:01:00:000')
		COMMIT
	END
END



SELECT * FROM Production.Product WHERE ProductID = 1001



-- 6. Napisz zapytanie SQL, które zaczyna transakcję i aktualizuje wartość OrderQty
-- dla każdego zamówienia w tabeli Sales.SalesOrderDetail. Jeżeli którykolwiek z
-- zamówień ma OrderQty równą 0, zapytanie powinno wycofać transakcję.

BEGIN TRANSACTION 

ALTER TABLE Sales.SalesOrderDetail NOCHECK CONSTRAINT ALL

UPDATE Sales.SalesOrderDetail SET OrderQty = OrderQty - 1

DECLARE @countzero INTEGER
SET @countzero = (SELECT COUNT(OrderQty) FROM Sales.SalesOrderDetail WHERE OrderQty = 0)

IF @countzero > 0 
		ROLLBACK
ELSE
	BEGIN
		ALTER TABLE Sales.SalesOrderDetail CHECK CONSTRAINT ALL
		COMMIT
	END



SELECT * FROM Sales.SalesOrderDetail



-- 7. Napisz zapytanie SQL, które zaczyna transakcję i usuwa wszystkie produkty,
-- których StandardCost jest wyższy niż średni koszt wszystkich produktów w tabeli
-- Production.Product. Jeżeli liczba  produktów do usunięcia przekracza 10,
-- zapytanie powinno wycofać transakcję.

BEGIN TRANSACTION 

DECLARE @avgcost MONEY = (SELECT (SUM(StandardCost) / COUNT(StandardCost)) as AvgPrice  FROM Production.Product) 
DECLARE @countaboveavg INTEGER = (SELECT COUNT(*) FROM Production.Product WHERE StandardCost > @avgcost)

IF @countaboveavg > 10
	ROLLBACK
ELSE
	BEGIN
	EXEC sp_MSForEachTable @command1 = "ALTER TABLE ? NOCHECK CONSTRAINT ALL"

	DELETE Product From Production.Product
	JOIN Production.BillOfMaterials ON BillOfMaterials.ComponentID = Product.ProductID
	WHERE StandardCost > @avgcost
	COMMIT
	END



SELECT * FROM Production.Product
SELECT COUNT(StandardCost) FROM Production.Product
