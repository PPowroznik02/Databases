--1. Napisz procedurę wypisującą do konsoli ciąg Fibonacciego. Procedura musi przyjmować jako
--argument wejściowy liczbę n. Generowanie ciągu Fibonacciego musi zostać
--zaimplementowane jako osobna funkcja, wywoływana przez procedurę.

CREATE SCHEMA fun 
GO

DROP FUNCTION IF EXISTS fun.Fibonacci 
GO

CREATE FUNCTION fun.Fibonacci (@n  INT)
RETURNS @numbers TABLE (fib INT)
AS 
BEGIN
	DECLARE @first INT = 0,  @second INT = 1, @i INT = 1, @tmp INT 

	INSERT INTO @numbers VALUES (@first), (@second)

	WHILE (@i < @n-1)
	BEGIN
	SET @tmp = @first + @second
	SET @first = @second
	SET @second = @tmp

	INSERT INTO @numbers VALUES(@tmp)

	SET @i += 1
	END
	RETURN 
END
GO


DROP PROCEDURE IF EXISTS FibonacciSeq
GO

CREATE PROCEDURE FibonacciSeq (@n INT)
AS
BEGIN
	SELECT * FROM fun.Fibonacci(@n) 
END
GO

EXEC FibonacciSeq 20



--2. Napisz trigger DML, który po wprowadzeniu danych do tabeli Persons zmodyfikuje nazwisko
--tak, aby było napisane dużymi literami.

USE AdventureWorks2019
GO

CREATE TRIGGER NazwiskoUpperCase
ON Person.Person
AFTER INSERT
AS
BEGIN
	UPDATE Person.Person SET LastName = UPPER(LastName) WHERE LastName IN (SELECT LastName FROM inserted)
END


BEGIN TRANSACTION
ALTER TABLE Person.Person NOCHECK CONSTRAINT ALL

DECLARE @myid uniqueidentifier  
SET @myid = NEWID()  

INSERT INTO Person.Person 
VALUES (20778, 'EM', 0, NULL, 'Mateusz', 'A', 'Osolinski', NULL, 2, NULL, NULL, @myid, '2023-05-29 00:00:00:000')



SELECT * FROM Person.Person WHERE BusinessEntityID = 20778


COMMIT
ROLLBACK
GO


--3. Przygotuj trigger ‘taxRateMonitoring’, który wyświetli komunikat o błędzie, jeżeli nastąpi
--zmiana wartości w polu ‘TaxRate’ o więcej niż 30%.

Create TRIGGER taxRateMonitoring 
ON Sales.SalesTaxRate 
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	DECLARE @Max FLOAT = 0.3, @OldTaxRate FLOAT, @NewTaxRate FLOAT

	SET @NewTaxRate = (SELECT TaxRate FROM inserted)
	SET @OldTaxRate = (SELECT TaxRate FROM deleted)


	IF ( @OldTaxRate + (@OldTaxRate * @Max) < @NewTaxRate AND @NewTaxRate > @OldTaxRate )
		PRINT ('Blad: zmieniono wartosc TaxRate o wiecej niz 30%' )
	ELSE IF ( @OldTaxRate - (@OldTaxRate * @Max) > @NewTaxRate AND @NewTaxRate < @OldTaxRate )
		PRINT ('Blad: zmieniono wartosc TaxRate o wiecej niz 30%')
END
GO


BEGIN TRANSACTION
ALTER TABLE Sales.SalesTaxRate NOCHECK CONSTRAINT ALL

UPDATE Sales.SalesTaxRate  SET TaxRate = TaxRate*1.4 WHERE SalesTaxRateID = 1


Select * FROM Sales.SalesTaxRate 

ROLLBACK
COMMIT