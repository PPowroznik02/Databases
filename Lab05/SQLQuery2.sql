/*
Ćwiczenie polega na wykonaniu prostej bazy danych dla księgowości w małej firmie.  
1. Utwórz nową bazę danych nazywając ją firma. 
2. Dodaj schemat o nazwie ksiegowosc.
3. Dodaj cztery tabele: 
	pracownicy(id_pracownika, imie, nazwisko, adres, telefon)  
	godziny(id_godziny, data, liczba_godzin , id_pracownika) 
	pensja(id_pensji, stanowisko, kwota) 
	premia(id_premii, rodzaj, kwota)  
	wynagrodzenie(id_wynagrodzenia, data, id_pracownika, id_godziny, id_pensji, id_premii) 

	przyjmując następujące założenia:
		-typy atrybutów mają zostać dobrane tak, aby składowanie danych było optymalne,
		-klucz główny dla każdej tabeli oraz klucze obce tam, gdzie występują powiązania pomiędzy tabelami,
		-opisy/komentarze dla każdej tabeli 
		–użyj polecenia COMMENT 

4. Wypełnij każdą tabelę 10. rekordami.
5. Wykonaj następujące zapytania: 
	a) Wyświetl tylko id pracownika oraz jego nazwisko.
	b) Wyświetl id pracowników, których płaca jest większa niż 1000.
	c) Wyświetl id pracowników nieposiadających premii,których płaca jest większa niż 2000.
	d) Wyświetl pracowników, których pierwsza litera imienia zaczyna się na literę ‘J’. 
	e) Wyświetl pracowników, których nazwisko zawiera literę ‘n’ oraz imię kończy się na literę ‘a’.
	f) Wyświetl imię i nazwisko pracowników oraz liczbę ich nadgodzin, przyjmując, iż standardowy czas pracy to 160 h miesięcznie.
	g) Wyświetl imię i nazwisko pracowników, których pensja zawiera się w przedziale 1500 –3000PLN.
	h) Wyświetl imię i nazwisko pracowników, którzy pracowali w nadgodzinachi nie otrzymali premii.
	i) Uszereguj pracowników według pensji.
	j) Uszereguj pracowników według pensji i premii malejąco.
	k) Zlicz i pogrupuj pracowników według pola ‘stanowisko’.
	l) Policz średnią, minimalną i maksymalną płacę dla stanowiska ‘kierownik’ (jeżeli takiego nie masz, to przyjmij dowolne inne).
	m) Policz sumę wszystkich wynagrodzeń.
	f) Policz sumę wynagrodzeń w ramach danego stanowiska.
	g) Wyznacz liczbę premii przyznanych dla pracowników danego stanowiska.
	h) Usuń wszystkich pracowników mających pensję mniejszą niż 1200 zł.
*/

--1.
CREATE DATABASE firma;



--2.
CREATE SCHEMA ksiegowosc;

--3.
CREATE TABLE ksiegowosc.pracownicy(
	id_pracownika INT PRIMARY KEY NOT NULL, 
	imie NVARCHAR(50) NOT NULL, 
	nazwisko NVARCHAR(50) NOT NULL, 
	adres NVARCHAR(100) NOT NULL, 
	telefon VARCHAR(25)
);
 
EXEC sp_addextendedproperty   
@name = N'Opis tabeli', 
@value = 'Tabela przechowujaca informacje o pracownikach, np. adres: ul. Młyńska 7 30-318 Kraków, telefon: (48) 821-329-829',  
@level0type = N'Schema', @level0name = 'ksiegowosc',  
@level1type = N'Table',  @level1name = 'pracownicy' 
GO  


CREATE TABLE ksiegowosc.godziny(
	id_godziny INT PRIMARY KEY NOT NULL, 
	data DATE NOT NULL,
	liczba_godzin INT, 
	id_pracownika INT NOT NULL
);
EXEC sp_addextendedproperty   
@name = N'Opis tabeli', 
@value = 'Tabela zawierajaca informacje o ilczbie przepracowanych godzin przez przacownika w danym dniu, np. data: YYYY-MM-DD',  
@level0type = N'Schema', @level0name = 'ksiegowosc',  
@level1type = N'Table',  @level1name = 'godziny'
GO  


CREATE TABLE ksiegowosc.pensja(
	id_pensji INT PRIMARY KEY NOT NULL, 
	stanowisko NVARCHAR(70), 
	kwota DECIMAL(8,2), 

);
  
EXEC sp_addextendedproperty   
@name = N'Opis tabeli', 
@value = 'Tabela zawierajaca informacje o pensji poszczegulnych pracownikow, oraz ich stanowiska',  
@level0type = N'Schema', @level0name = 'ksiegowosc',  
@level1type = N'Table',  @level1name = 'pensja' 
GO  


CREATE TABLE ksiegowosc.premia(
	id_premii INT PRIMARY KEY NOT NULL, 
	rodzaj NVARCHAR(100), 
	kwota DECIMAL(8,2)
);

EXEC sp_addextendedproperty   
@name = N'Opis tabeli', 
@value = 'Tabela zawierajaca informacje o rodzajach premi ktore moga byc przyznawane pracownikom',  
@level0type = N'Schema', @level0name = 'ksiegowosc',  
@level1type = N'Table',  @level1name = 'premia'
GO  


CREATE TABLE ksiegowosc.wynagrodzenie(
	id_wynagrodzenia INT PRIMARY KEY NOT NULL,
	data DATE NOT NULL,
	id_pracownika INT NOT NULL,
	id_godziny INT NOT NULL,
	id_pensji INT NOT NULL,
	id_premii INT 
);
  
EXEC sp_addextendedproperty   
@name = N'Opis tabeli', 
@value = 'Tabela przechowujaca wszystkie ID oraz date wyplaty',  
@level0type = N'Schema', @level0name = 'ksiegowosc',  
@level1type = N'Table',  @level1name = 'wynagrodzenie' 
GO  


ALTER TABLE ksiegowosc.godziny	ADD FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika)
ALTER TABLE ksiegowosc.wynagrodzenie ADD FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika)
ALTER TABLE ksiegowosc.wynagrodzenie ADD FOREIGN KEY (id_godziny) REFERENCES ksiegowosc.godziny(id_godziny)
ALTER TABLE ksiegowosc.wynagrodzenie ADD FOREIGN KEY (id_pensji) REFERENCES ksiegowosc.pensja(id_pensji)
ALTER TABLE ksiegowosc.wynagrodzenie ADD FOREIGN KEY (id_premii) REFERENCES ksiegowosc.premia(id_premii)




--4.
INSERT INTO ksiegowosc.pracownicy (id_pracownika, Imie, Nazwisko, adres, telefon) VALUES 
(1, 'Tadeusz', 'Chrobak', 'ul. Narutowicza 12 33-100 Tarnów', '(48) 125-453-325'),
(2, 'Ania', 'Maj', 'ul. Pomorska 2 30-318 Kraków', '(48) 433-784-994'), 
(3, 'Ala', 'Makota', 'ul. Czarnowiejska 17c 30-318 Kraków', '(48) 832-539-648'), 
(4, 'Marek', 'Bieniek', 'ul. Hetmańska 40-560 Katowice', '(48) 342-459-144'),
(5, 'Jacek', 'Dukaj', 'ul. Urszulańska 22 33-100 Tarnów', '(48) 191-912-586'),
(6, 'Zdzisław', 'Janowicz', 'ul. Wrocławska 45 30-318 Kraków', '(48) 534-762-726'),
(7, 'Alicja', 'Kozioł', 'ul. Katowicka 12 40-173 Katowice', '(48) 153-654-974'),
(8, 'Janina', 'Niewiadomska', 'ul. Olszyny 5 30-318 Kraków', '(48) 438-918-131'),
(9, 'Kinga', 'Leszczyńska', 'ul. Młyńska 7 30-318 Kraków', '(48) 821-329-829'),
(10, 'Tomasz', 'Sętowski', 'ul. Admiralska 14 42-280 Częstochowa', '(48) 838-989-661');

Insert INTO ksiegowosc.godziny (id_godziny, data, liczba_godzin, id_pracownika) VALUES
(1,'2023-05-04', 160, 1),
(2,'2023-05-04', 200, 2),
(3, '2023-05-04', 210, 3),
(4, '2023-05-04', 160, 4),
(5, '2023-05-04', 160, 5),
(6, '2023-05-04', 140, 6),
(7, '2023-05-05', 200, 7),
(8, '2023-05-05', 100, 8),
(9, '2023-05-05', 80, 9),
(10, '2023-05-05', 80, 10);

INSERT INTO ksiegowosc.pensja (id_pensji, stanowisko, kwota) VALUES
(1, 'Główna księgowa', 3000.00),
(2, 'Księgowa', 2000.00),
(3, 'Dyrektor', 4000.00),
(4, 'Informatyk', 2800.00),
(5, 'Ochroniarz', 1150.00),
(6, 'Woźny', 1100.00),
(7, 'Stażysta', 800.00),
(8, 'Koordynator', 2000.00),
(9, 'Sekretarka', 1050.00),
(10, 'Analityk', 2600.00);

INSERT INTO ksiegowosc.premia (id_premii, rodzaj, kwota) VALUES
(1, 'Motywacyjna', 500.00),
(2, 'Motywcyjna 2', 800.00),
(3, 'Uznaniowa', 1500.00),
(4, 'Świąteczna', 800.00),
(5, 'Jubileuszowa 10lat', 2500.00),
(6, 'Jubileuszowa 20lat', 5000.00),
(7, 'Jubileuszowa 30lat', 10000.00) ,
(8, 'Wynikowa 1', 700.00),
(9, 'Wynikowa 2', 1200.00),
(10,'Frekwencyjna', 500.00);

INSERT INTO ksiegowosc.wynagrodzenie (id_wynagrodzenia, data, id_pracownika, id_godziny, id_pensji, id_premii) VALUES
(1, '2023-04-01', 1, 1, 3, 1),
(2, '2023-04-01', 2, 2, 7, NULL),
(3, '2023-04-01', 3, 3, 3, 3),
(4, '2023-04-01', 4, 4, 1, 10),
(5, '2023-04-01', 5, 5, 9, 5),
(6, '2023-05-01', 6, 6, 10, 7),
(7, '2023-05-01', 7, 7, 2, 2),
(8, '2023-05-01', 8, 8, 4, 2),
(9, '2023-05-01', 9, 9, 8, NULL),
(10, '2023-05-01', 10, 10, 7, NULL);

DROP TABLE ksiegowosc.wynagrodzenie 

--5a
SELECT id_pracownika, nazwisko FROM ksiegowosc.pracownicy;

--5b	
SELECT id_pracownika
FROM ksiegowosc.wynagrodzenie 
INNER JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji
WHERE pensja.kwota > 1000;

--5c	Wyświetl id pracowników nieposiadających premii,których płaca jest większa niż 2000.
SELECT id_pracownika FROM ksiegowosc.wynagrodzenie 
INNER JOIN ksiegowosc.premia ON ksiegowosc.wynagrodzenie.id_premii = ksiegowosc.premia.id_premii
INNER JOIN ksiegowosc.pensja ON ksiegowosc.pensja.id_pensji = ksiegowosc.wynagrodzenie.id_pensji
WHERE pensja.kwota > 2000 AND wynagrodzenie.id_premii IS NOT NULL

--6d  Wyświetl pracowników, których pierwsza litera imienia zaczyna się na literę ‘J’. 
SELECT * FROM ksiegowosc.pracownicy WHERE pracownicy.imie LIKE 'J%';

--e.	Wyświetl pracowników, których nazwisko zawiera literę ‘n’ oraz imię kończy się na literę ‘a’.
SELECT * FROM ksiegowosc.pracownicy WHERE pracownicy.imie LIKE '%a' AND pracownicy.nazwisko LIKE '%n%';

--f.	Wyświetl imię i nazwisko pracowników oraz liczbę ich nadgodzin, przyjmując, iż standardowy czas pracy to 160 h miesięcznie.
SELECT imie, nazwisko, godziny.liczba_godzin - 160 as nadgodziny 
FROM  ksiegowosc.pracownicy
INNER JOIN ksiegowosc.godziny ON pracownicy.id_pracownika = godziny.id_pracownika
WHERE godziny.liczba_godzin > 160

--g.	Wyświetl imię i nazwisko pracowników, których pensja zawiera się w przedziale 1500 –3000PLN.
SELECT imie, nazwisko
FROM ksiegowosc.pracownicy
INNER JOIN ksiegowosc.wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
INNER JOIN ksiegowosc.pensja ON wynagrodzenie.id_pensji = pensja.id_pensji
WHERE pensja.kwota > 1500 AND pensja.kwota < 3000;

--h.	Wyświetl imię i nazwisko pracowników, którzy pracowali w nadgodzinachi nie otrzymali premii.
SELECT imie, nazwisko
FROM ksiegowosc.pracownicy
INNER JOIN ksiegowosc.wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
INNER JOIN ksiegowosc.godziny ON wynagrodzenie.id_godziny = godziny.id_godziny
WHERE ksiegowosc.wynagrodzenie.id_premii IS NULL AND godziny.liczba_godzin > 160;

--i.	Uszereguj pracowników według pensji.
SELECT pracownicy.id_pracownika, pracownicy.imie, pracownicy.nazwisko, pensja.kwota 
FROM ksiegowosc.pracownicy
INNER JOIN ksiegowosc.wynagrodzenie ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika 
INNER JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji
ORDER BY pensja.kwota;

--j.	Uszereguj pracowników według pensji i premii malejąco.
SELECT pracownicy.id_pracownika, pracownicy.imie, pracownicy.nazwisko, pensja.kwota, premia.kwota as wartosc_premii
FROM ksiegowosc.pracownicy
INNER JOIN ksiegowosc.wynagrodzenie ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika 
INNER JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji
INNER JOIN ksiegowosc.premia ON ksiegowosc.wynagrodzenie.id_premii = ksiegowosc.premia.id_premii
ORDER BY pensja.kwota desc, premia.kwota desc;

--k.	Zlicz i pogrupuj pracowników według pola ‘stanowisko’.
SELECT pensja.stanowisko, count(pracownicy.id_pracownika) AS zliczeni_pracownicy
FROM ksiegowosc.pracownicy
INNER JOIN ksiegowosc.wynagrodzenie ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika
INNER JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji
GROUP BY pensja.stanowisko


--l.	Policz średnią, minimalną i maksymalną płacę dla stanowiska ‘kierownik’ (jeżeli takiego nie masz, to przyjmij dowolne inne).
SELECT pensja.stanowisko, AVG(pensja.kwota+ISNULL(premia.kwota,0)) AS srednia, MAX(pensja.kwota+ISNULL(premia.kwota,0)) AS maksymalna, MIN(pensja.kwota+ISNULL(premia.kwota,0)) AS minimalna
FROM ksiegowosc.wynagrodzenie
INNER JOIN ksiegowosc.pensja  ON pensja.id_pensji = wynagrodzenie.id_pensji
INNER JOIN ksiegowosc.premia  ON premia.id_premii = wynagrodzenie.id_premii
WHERE pensja.stanowisko = 'Dyrektor'
	GROUP BY stanowisko

--m.	Policz sumę wszystkich wynagrodzeń.
SELECT (SUM(pensja.kwota) + SUM(ISNULL (premia.kwota, 0))) AS suma_wynagrodzen
FROM ksiegowosc.wynagrodzenie
INNER JOIN ksiegowosc.pensja ON pensja.id_pensji = wynagrodzenie.id_pensji
INNER JOIN ksiegowosc.premia ON premia.id_premii = wynagrodzenie.id_premii

--f.	Policz sumę wynagrodzeń w ramach danego stanowiska.
SELECT pensja.stanowisko, (SUM(pensja.kwota) + SUM(ISNULL(premia.kwota,0))) AS suma_wynagrodzen
FROM ksiegowosc.wynagrodzenie
INNER JOIN ksiegowosc.pensja ON pensja.id_pensji = wynagrodzenie.id_pensji
INNER JOIN ksiegowosc.premia ON premia.id_premii = wynagrodzenie.id_premii
GROUP BY stanowisko

--g.	Wyznacz liczbę premii przyznanych dla pracowników danego stanowiska.
SELECT pensja.stanowisko, COUNT(ISNULL(premia.id_premii,0)) AS liczba_premii
FROM ksiegowosc.wynagrodzenie
INNER JOIN ksiegowosc.pensja ON pensja.id_pensji = wynagrodzenie.id_pensji
INNER JOIN ksiegowosc.premia ON premia.id_premii = wynagrodzenie.id_premii
GROUP BY stanowisko

--h.	Usuń wszystkich pracowników mających pensję mniejszą niż 1200 zł.
EXEC sp_MSForEachTable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL'
GO
DELETE pracownicy
FROM ksiegowosc.pracownicy
INNER JOIN ksiegowosc.wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
INNER JOIN ksiegowosc.pensja ON pensja.id_pensji = wynagrodzenie.id_pensji
	WHERE pensja.kwota < 1200;
GO

SELECT * FROM ksiegowosc.pracownicy;