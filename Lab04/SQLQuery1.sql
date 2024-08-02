/*
1. Utworz nowa baze danych nazywajac ja "firma".
2. Dodaj nowy schemat o nazwie "rozliczenia".
3. Dodaj do schematu "rozliczenia" 4 tabele:

	pracownicy (id_pracownika, Imie, Nazwisko, adres, telefon)
	godziny (id_godziny, data,liczba_godzin, id_pracownika)
	pensje (id_pensji, stanowisko, kwota, id_premi)
	premie (id_premi, rodzaj, kwota)

	Wykonujac nastepujace dzialania:
	a) Ustaw typy danych tak, aby przetwarzanie i skladowanie danych bylo optymalne
	b) Zastanow sie, ktore pola musza przyjmowac wartosc NOT NULL
	c) Ustaw klucz glowny dla kazdej tabeli (jako czesc polecenia CREATE TABLE)
	d) Zastanow sie jakie zwiazki zachodza pomiedzy tabelami, a nastepnie dodaj klucze obce
		tam, gdzie wystepuja (wykorzystaj polecenie ALTER TABLE - po uprzednim stworzeniu tabeli).

4. Wypelnij kazda tabele 10 rekordami.
5. Za pomoca zapytania SQL wyswietl nazwiska pracownikow i ich adresy.
6. Napisz zapytanie, ktore przekonwertuje date w tabeli "godziny" tak, aby wyswietlana byla
	informacja jaki to dzien tygodnia i jaki miesiac (funkcja DATEPART x2).
7. W tabeli "pensje" zmien nazwe atrybutu "kwota" na "kwota_brutto" oraz dodaj nowy o nazwie
"kwota_netto". Oblicz kwote netto i zaktualizuj wartosc tabeli.
*/

USE firma;

--1.
CREATE DATABASE firma;


--2.
CREATE SCHEMA rozliczenia;

--3.
--DROP TABLE rozliczenia.pensje;

CREATE TABLE rozliczenia.pracownicy(
	id_pracownika INT PRIMARY KEY NOT NULL, 
	Imie NVARCHAR(50) NOT NULL, 
	Nazwisko NVARCHAR(50) NOT NULL, 
	adres NVARCHAR(100) NOT NULL, 
	telefon VARCHAR(25)
);

create TABLE rozliczenia.godziny(
	id_godziny INT PRIMARY KEY NOT NULL, 
	data DATE NOT NULL,
	liczba_godzin INT, 
	id_pracownika INT NOT NULL
);

CREATE TABLE rozliczenia.pensje(
	id_pensji INT PRIMARY KEY NOT NULL, 
	stanowisko NVARCHAR(70), 
	kwota DECIMAL(8,2), 
	id_premi INT
);

CREATE TABLE rozliczenia.premie(
	id_premi INT PRIMARY KEY NOT NULL,
	rodzaj NVARCHAR(100), 
	kwota DECIMAL(8,2)
);

ALTER TABLE rozliczenia.godziny
ADD FOREIGN KEY (id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika);

ALTER TABLE rozliczenia.pensje
ADD FOREIGN KEY (id_premi) REFERENCES rozliczenia.premie(id_premi);


--4.
INSERT INTO rozliczenia.pracownicy (id_pracownika, Imie, Nazwisko, adres, telefon) VALUES 
(1, 'Tadeusz', 'Chrobak', 'ul. Narutowicza 12 33-100 Tarnów', '(48) 125-453-325'),
(2, 'Ania', 'Maj', 'ul. Pomorska 2 30-318 Kraków', '(48) 433-784-994'), 
(3, 'Ala', 'Makota', 'ul. Czarnowiejska 17c 30-318 Kraków', '(48) 832-539-648'), 
(4, 'Marek', 'Bieniek', 'ul. Hetmańska 40-560 Katowice', '(48) 342-459-144'),
(5, 'Jacek', 'Dukaj', 'ul. Urszulańska 22 33-100 Tarnów', '(48) 191-912-586'),
(6, 'Zdzisław', 'Janowicz', 'ul. Wrocławska 45 30-318 Kraków', '(48) 534-762-726'),
(7, 'Alicja', 'Kozioł', 'ul. Katowicka 12 40-173 Katowice', '(48) 153-654-974'),
(8, 'Andrzej', 'Niewiadomski', 'ul. Olszyny 5 30-318 Kraków', '(48) 438-918-131'),
(9, 'Kinga', 'Leszczyńska', 'ul. Młyńska 7 30-318 Kraków', '(48) 821-329-829'),
(10, 'Tomasz', 'Sętowski', 'ul. Admiralska 14 42-280 Częstochowa', '(48) 838-989-661');

Insert INTO rozliczenia.godziny (id_godziny, data,liczba_godzin, id_pracownika) VALUES
(1,'2023-05-04', 10, 5),
(2,'2023-05-04', 8, 4),
(3, '2023-05-04', 5, 6),
(4, '2023-05-04', 6, 7),
(5, '2023-05-04', 6, 8),
(6, '2023-05-04', 8, 9),
(7, '2023-05-05', 8, 1),
(8, '2023-05-05', 6, 2),
(9, '2023-05-05', 5, 3),
(10, '2023-05-05', 8, 10);

INSERT INTO rozliczenia.pensje (id_pensji, stanowisko, kwota, id_premi) VALUES
(1, 'Analityk', 10000.00, 9),
(2, 'Backend developer', 15000.00, 6),
(3, 'Web developer', 12000.00, 3),
(4, 'Data scientist', 11000.00, 8),
(5, 'Frontend developer', 7000.00, 2),
(6, 'Księgowy', 7000.00, 5),
(7, 'Stażysta', 4000.00, NULL),
(8, 'Stażysta', 3500.00, NULL),
(9, 'Sekretarka', 6000.00, 8),
(10, 'Project menager', 18000.00, NULL);

INSERT INTO rozliczenia.premie (id_premi, rodzaj, kwota) VALUES
(1, 'Motywacyjna', 500.00),
(2, 'Motywcyjna 2', 800.00),
(3, 'Uznaniowa', 2500.00),
(4, 'Świąteczna', 800.00),
(5, 'Jubileuszowa 10lat', 5000.00),
(6, 'Jubileuszowa 20lat', 7000.00),
(7, 'Jubileuszowa 30lat', 10000.00) ,
(8, 'Wynikowa 1', 1000.00),
(9, 'Wynikowa 2', 2000.00),
(10,'Frekwencyjna', 1000.00);


--5.
SELECT Nazwisko, adres FROM rozliczenia.pracownicy


--6.
SELECT DATEPART (dw, data) AS dzien, DATEPART (mm, data) AS miesiac FROM rozliczenia.godziny

SELECT CASE DATEPART (dw, data)  
	WHEN 1 THEN 'Poniedzialek'
	WHEN 2 THEN 'Wtorek'
	WHEN 3 THEN 'Sroda'
	WHEN 4 THEN 'Czwartek'
	WHEN 5 THEN 'Piatek'
	WHEN 6 THEN 'Sobota'
	WHEN 7 THEN 'Niedziela'
END AS dzien, 
CASE DATEPART (mm, data) 
	WHEN 1 THEN 'Styczen'
	WHEN 2 THEN 'Luty'
	WHEN 3 THEN 'Marzec'
	WHEN 4 THEN 'Kwiecien'
	WHEN 5 THEN 'Maj'
	WHEN 6 THEN 'Czerwiec'
	WHEN 7 THEN 'Lipiec'
	WHEN 8 THEN 'Sierpien'
	WHEN 9 THEN 'Wrzesien'
	WHEN 10 THEN 'Pazdziernik'
	WHEN 11 THEN 'Listopad'
	WHEN 12 THEN 'Grudzien'
END AS miesiac FROM rozliczenia.godziny


--7.
EXEC sp_rename 'rozliczenia.pensje.kwota', 'kwota_brutto', 'COLUMN';

ALTER TABLE rozliczenia.pensje ADD kwota_netto DECIMAL(8,2);

UPDATE rozliczenia.pensje SET kwota_netto = kwota_brutto*0.72;

SELECT * FROM rozliczenia.pensje