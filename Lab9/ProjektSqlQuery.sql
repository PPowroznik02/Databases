-- 1. Utworzenie dazy danych i schematu
CREATE DATABASE Geochronologia;

CREATE SCHEMA geo;




-- 2. Utworzenie tabeli, oraz kluczy opcych
CREATE TABLE geo.GeoEon(
	IdEon INTEGER NOT NULL PRIMARY KEY,
	NazwaEon VARCHAR(60)
);


CREATE TABLE geo.GeoEra(
	IdEra INTEGER NOT NULL PRIMARY KEY,
	IdEon INTEGER REFERENCES geo.GeoEon(IdEon),
	NazwaEra VARCHAR(60)
);




CREATE TABLE geo.GeoOkres(
	IdOkres INTEGER NOT NULL PRIMARY KEY,
	IdEra INTEGER REFERENCES geo.GeoEra(IdEra),
	NazwaOkres VARCHAR(60)
);




CREATE TABLE geo.GeoEpoka(
	IdEpoka INTEGER NOT NULL PRIMARY KEY,
	IdOkres INTEGER REFERENCES geo.GeoOkres(IdOkres),
	NazwaEpoka VARCHAR(60)
);




CREATE TABLE geo.GeoPietro(
	IdPietro INTEGER NOT NULL PRIMARY KEY,
	IdEpoka INTEGER REFERENCES geo.GeoEpoka(IdEpoka),
	NazwaPietro VARCHAR(60)
);





-- 3. Wypelnienie tabeli danymi
INSERT INTO geo.GeoEon VALUES
(1,'Fanerozoik');


INSERT INTO geo.GeoEra VALUES
(1, 1,'Kenzoik'),
(2, 1,'Mezozoik'),
(3, 1,'Paleozoik');


INSERT INTO geo.GeoOkres VALUES
(1, 1, 'Czwartorzed'),
(2, 1, 'Neogen'),
(3, 1, 'Paleogen'),

(4, 2, 'Kreda'),
(5, 2, 'Jura'),
(6, 2, 'Trias'),

(7, 3, 'Perm'),
(8, 3, 'Karbon'),
(9, 3, 'Dewon'),
(10, 3,'Sylur'),
(11, 3,'Ordownik'),
(12, 3,'Kambr');



INSERT INTO geo.GeoEpoka VALUES
(1, 1, 'Holocen'),
(2, 1, 'Plejstocen'),

(3, 2, 'Pliocen'),
(4, 2, 'Miocen'),

(5, 3, 'Oligocen'),
(6, 3, 'Eocen'),
(7, 3, 'Paleocen'),

(8, 4, 'Górna'),
(9, 4, 'Dolna'),

(10, 5, 'Górna'),
(11, 5, 'Środkowa'),
(12, 5, 'Dolna'),

(13, 6, 'Górny'),
(14, 6, 'Środkowy'),
(15, 6, 'Dolny'),

(16, 7, 'Loping'),
(17, 7, 'Gwadalup'),
(18, 7, 'Cisural'),

(19, 8, 'Pensylwan'),
(20, 8, 'Missisip'),

(21, 9, 'Górny'),
(22, 9, 'Środkowy'),
(23, 9, 'Dolny'),

(24, 10, 'Przydol'),
(25, 10, 'Ludlow'),
(26, 10, 'Wenlok'),
(27, 10, 'Landower'),

(28, 11, 'Gorny'),
(29, 11, 'Srodkowy'),
(30, 11, 'Dolny'),

(31, 12, 'Furong'),
(32, 12, 'Oddzial 3'),
(33, 12, 'Oddzial 2'),
(34, 12, 'Terenew');



INSERT INTO geo.GeoPietro VALUES
(1, 1, 'Megalaj'),
(2, 1, 'Northgrip'),
(3, 1, 'Grenland'),

(4, 2, 'PlejstocenGorny'),
(5, 2, 'Jon'),
(6, 2, 'Kalabr'),
(7, 2, 'Gelas'),

(8, 3, 'Piacent'),
(9, 3, 'Zankl'),

(11, 4, 'Messyn'),
(12, 4, 'Torton'),
(13, 4, 'Serrawal'),
(14, 4, 'Lang'),
(15, 4, 'Burdygal'),
(16, 4, 'Akwitan'),

(17, 5, 'Szat'),
(18, 5, 'Rupel'),

(19, 6, 'Priabon'),
(20, 6, 'Barton'),
(21, 6, 'Lutet'),
(22, 6, 'Iprez'),

(23, 7, 'Tanet'),
(24, 7, 'Zeland'),
(25, 7, 'Dan'),

(26, 8, 'Mastrycht'),
(27, 8, 'Kampan'),
(28, 8, 'Santon'),
(29, 8, 'Koniak'),
(30, 8, 'Turon'),
(31, 8, 'Cenoman'),

(32, 9, 'Alb'),
(33, 9, 'Apt'),
(34, 9, 'Barrem'),
(35, 9, 'Hoteryw'),
(36, 9, 'Walanzyn'),
(37, 9, 'Berias'),

(38, 10, 'Tyton'),
(39, 10, 'Kimeryd'),
(40, 10, 'Oksford'),

(41, 11, 'Kelowej'),
(42, 11, 'Baton'),
(43, 11, 'Bajos'),
(44, 11, 'Aalen'),

(45, 12, 'Toark'),
(46, 12, 'Pliensbach'),
(47, 12, 'Synemur'),
(48, 12, 'Hetang'),

(49, 13, 'Retyk'),
(50, 13, 'Noryk'),
(51, 13, 'Karnik'),

(52, 14, 'Ladyn'),
(53, 14, 'Anizyk'),

(54, 15, 'Olenek'),
(55, 15, 'Ind'),

(56, 16, 'Czangszing'),
(57, 16, 'Wucziaping'),

(58, 17, 'Kapitan'),
(59, 17, 'Word'),
(60, 17, 'Road'),

(61, 18, 'Kungur'),
(62, 18, 'Artynsk'),
(63, 18, 'Sakmar'),
(64, 18, 'Aselsk'),

(65, 19, 'Gzel'),
(66, 19, 'Kasimow'),
(67, 19, 'Moskow'),
(68, 19, 'Baszkir'),

(69, 20, 'Serpuchow'),
(70, 20, 'Wizen'),
(71, 20, 'Turnej'),

(72, 21, 'Famen'),
(73, 21, 'Fran'),

(74, 22, 'Zywet'),
(75, 22, 'Eifel'),
 
(76, 23, 'Ems'),
(77, 23, 'Prag'),
(78, 23, 'Lochkow'),

(79, 24, 'Przydol'),

(80, 25, 'Ludford'),
(81, 25, 'Gorst'),

(82, 26, 'Homer'),
(83, 26, 'Sheinwood'),

(84, 27, 'Telych'),
(85, 27, 'Aeron'),
(86, 27,'Rhuddan'),

(87, 28, 'Hirnant'),
(88, 28, 'Kat'),
(89, 28, 'Sandb'),

(90, 29, 'Darriwil'),
(91, 29, 'Daping'),

(92, 30, 'Flo'),
(93, 30, 'Tremadok'),

(94, 31, 'Pietro 10'),
(95, 31, 'Jiangshan'),
(96, 31, 'Paib'),

(97, 32, 'Guzang'),
(98, 32, 'Drum'),
(99, 32, 'Pietro 5'),

(100, 33, 'Pietro 4'),
(101, 33, 'Pietro 3'),

(102, 34, 'Pietro 2'),
(103, 34, 'Fortun');

-- 5. Wyswietlenie wprowadzonych danych
SELECT  geo.GeoEon.NazwaEon, geo.GeoEra.NazwaEra, geo.GeoOkres.NazwaOkres, 
geo.GeoEpoka.NazwaEpoka, geo.GeoPietro.NazwaPietro, geo.GeoPietro.IdPietro
FROM geo.GeoPietro
JOIN geo.GeoEpoka ON geo.GeoEpoka.IdEpoka = geo.GeoPietro.IdEpoka
JOIN geo.GeoOkres ON geo.GeoOkres.IdOkres = geo.GeoEpoka.IdOkres
JOIN geo.GeoEra ON geo.GeoEra.IdEra = geo.GeoOkres.IdEra
JOIN geo.GeoEon ON geo.GeoEon.IdEon = geo.GeoEra.IdEon
ORDER BY IdPietro;


-- 6. Utworzenie geo-tabeli
CREATE TABLE geo.GeoTabela 
AS (SELECT * FROM geo.GeoPietro 
	NATURAL JOIN geo.GeoEpoka 
	NATURAL JOIN geo.GeoOkres 
	NATURAL JOIN geo.GeoEra 
	NATURAL JOIN geo.GeoEon );


ALTER TABLE geo.GeoTabela ADD PRIMARY KEY (IdPietro);

SELECT * FROM geo.GeoTabela;




--7. Utworzenie tabeli milion wykorzystujac tabele dziesiec
CREATE TABLE geo.Dziesiec (
	Cyfra INTEGER,
	Bit INTEGER 
);


INSERT INTO geo.Dziesiec VALUES
(0, 0),
(1, 1),
(2, 10),
(3, 11),
(4, 100),
(5, 101),
(6, 110),
(7, 111),
(8, 1000),
(9, 1001);

SELECT * FROM geo.Dziesiec;


CREATE TABLE geo.Milion(Liczba int, Cyfra int, Bit int);

INSERT INTO geo.Milion SELECT a1.Cyfra +10* a2.Cyfra +100*a3.Cyfra + 
1000*a4.Cyfra + 10000*a5.Cyfra + 10000*a6.Cyfra 
AS Liczba , a1.Cyfra AS Cyfra, a1.bit AS Bit
FROM geo.Dziesiec a1, geo.Dziesiec a2, geo.Dziesiec a3, 
geo.Dziesiec a4, geo.Dziesiec a5, geo.Dziesiec a6;


SELECT COUNT(*) FROM geo.Milion;

SELECT * FROM geo.Milion
ORDER BY Liczba;




-- 8. Testy zapytan
-- zlaczenie syntetycznej tablicy miliona wynikow tabela geochronologiczną w postaci zdenormalizowanej,
-- do warunku zlaczenia dodano operacje modulo (1 ZL)
SELECT COUNT(*) FROM geo.Milion 
INNER JOIN geo.GeoTabela ON (mod(geo.Milion.Liczba,68) = (geo.GeoTabela.IdPietro));


-- zlaczenie syntetycznej tablicy miliona wynikow
-- z tabela geochronologiczna w postaci znormalizowanej, reprezentowana przez zlaczenia pieciu tabel (2 ZL)
SELECT COUNT(*) FROM geo.Milion 
INNER JOIN geo.GeoPietro ON (mod(Milion.liczba,68) = GeoPietro.IdPietro) 
NATURAL JOIN geo.GeoEpoka
NATURAL JOIN geo.GeoOkres 
NATURAL JOIN geo.GeoEra 
NATURAL JOIN geo.GeoEon;


-- zlaczenie syntetycznej tablicy miliona wynikow z tabela geochronologiczna w postaci zdenormalizowanej, 
-- przy czym zlaczenie jest wykonywane poprzez zagniezdzenie skorelowane (3 ZL)
SELECT COUNT(*) FROM geo.Milion 
WHERE mod(geo.Milion.liczba,68) IN (SELECT IdPietro FROM geo.GeoTabela 
	WHERE mod(geo.Milion.liczba,68)=(IdPietro));


-- zlaczenie syntetycznej tablicy miliona wynikow z tabela geochronologiczna w postaci znormalizowanej, 
-- przy czym zlaczenie jest wykonywane poprzez zagniezdzenie skorelowane, 
-- a zapytanie wewnętrzne jest zlaczeniem tabel poszczegolnych jednostek geochronologicznych (4 ZL)
SELECT COUNT(*) FROM geo.Milion 
WHERE mod(Milion.Liczba,68) IN 
(SELECT geo.GeoPietro.IdPietro FROM geo.GeoPietro 
	NATURAL JOIN geo.GeoEpoka 
	NATURAL JOIN geo.GeoOkres 
	NATURAL JOIN geo.GeoEra 
	NATURAL JOIN geo.GeoEon);

-- 9. Utworzenie indeksow
Select * From geo.GeoTabela

CREATE INDEX IdxMilionLiczba ON geo.Milion(Liczba);
CREATE INDEX IdxGeoEonIdEon ON geo.GeoEon(IdEon);
CREATE INDEX IdxGeoEraIdEra ON geo.GeoEra(IdEra);
CREATE INDEX IdxGeoOkresIdOkres ON geo.GeoOkres(IdOkres);
CREATE INDEX IdxGeoEpokaIdEpoka ON geo.GeoEpoka(IdEpoka);
CREATE INDEX IdxGeoPietroIdPietro ON geo.GeoPietro(IdPietro);
CREATE INDEX IdxGeoEonNazwaEon ON geo.GeoEon(NazwaEon);
CREATE INDEX IdxGeoEraNazwaEra ON geo.GeoEra(NazwaEra);
CREATE INDEX IdxGeoOkresNazwaOkres ON geo.GeoOkres(NazwaOkres);
CREATE INDEX IdxGeoEpokaNazwaEpoka ON geo.GeoEpoka(NazwaEpoka);
CREATE INDEX IdxGeoPietroNazwaPietro ON geo.GeoPietro(NazwaPietro);

CREATE INDEX IdxGeoTabelaIdPietro ON geo.GeoTabela(IdPietro);
CREATE INDEX IdxGeoTabelaIdEon ON geo.GeoTabela(IdEon);
CREATE INDEX IdxGeoTabelaIdEra ON geo.GeoTabela(IdEra);
CREATE INDEX IdxGeoTabelaIdOkres ON geo.GeoTabela(IdOkres);
CREATE INDEX IdxGeoTabelaIdEpoka ON geo.GeoTabela(IdEpoka);

CREATE INDEX IdxGeoTabelaNazwaPietro ON geo.GeoTabela(NazwaPietro);
CREATE INDEX IdxGeoTabelaNazwaEon ON geo.GeoTabela(NazwaEon);
CREATE INDEX IdxGeoTabelaNazwaEra ON geo.GeoTabela(NazwaEra);
CREATE INDEX IdxGeoTabelaNazwaOkres ON geo.GeoTabela(NazwaOkres);
CREATE INDEX IdxGeoTabelaNazwaEpoka ON geo.GeoTabela(NazwaEpoka);








