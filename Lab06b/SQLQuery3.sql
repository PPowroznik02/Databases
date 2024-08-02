--a) Zmodyfikuj numer telefonu w tabeli pracownicy, dodaj?c do niego kierunkowy dla Polskiw nawiasie (+48)
UPDATE ksiegowosc.pracownicy
SET telefon = REPLACE(telefon, '(', '(+')
WHERE pracownicy.telefon LIKE '(__)%';

SELECT * FROM ksiegowosc.pracownicy

--b) Zmodyfikuj atrybut telefon w tabeli pracownicy tak, aby numer oddzielony by? my?lnikami wgwzoru: ‘555-222-333’
UPDATE ksiegowosc.pracownicy
SET telefon = SUBSTRING(telefon, 1, 8) + SUBSTRING(telefon, 10, 3) + SUBSTRING(telefon, 14, 3) 

UPDATE ksiegowosc.pracownicy
SET telefon = SUBSTRING(telefon, 1, 8) + '-' + SUBSTRING(telefon, 9, 3) + '-' + SUBSTRING(telefon, 12, 3) 

SELECT * FROM ksiegowosc.pracownicy

--c) Wy?wietl dane pracownika, którego nazwisko jest najd?u?sze, u?ywaj?c du?ych liter
SELECT  id_pracownika, UPPER(Imie) , UPPER(Nazwisko) , UPPER(adres) , telefon 
FROM ksiegowosc.pracownicy
WHERE LEN(nazwisko) = (SELECT MAX(LEN(nazwisko)) FROM ksiegowosc.pracownicy);


--d) Wy?wietl dane pracowników i ich pensje zakodowane przy pomocy algorytmu md5
SELECT HashBytes( 'md5', Cast(pracownicy.id_pracownika AS VARCHAR)) AS id_pracownika, 
HashBytes( 'md5', imie) AS imie, HashBytes( 'md5', nazwisko) AS nazwisko, 
HashBytes( 'md5', adres) AS adres, HashBytes( 'md5', telefon) AS telefon, 
HashBytes( 'md5', Cast(pensja.kwota AS VARCHAR)) AS kwota
FROM ksiegowosc.wynagrodzenie
INNER JOIN ksiegowosc.pracownicy ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika
INNER JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji

--f) Wy?wietl pracowników, ich pensje oraz premie. Wykorzystaj z??czenie lewostronne.
SELECT pracownicy.id_pracownika, pracownicy.imie, pracownicy.nazwisko,
pracownicy.adres, pracownicy.telefon, pensja.kwota AS pensja, premia.kwota AS premia
FROM ksiegowosc.wynagrodzenie
LEFT JOIN ksiegowosc.pensja ON ksiegowosc.pensja.id_pensji = ksiegowosc.wynagrodzenie.id_pensji
LEFT JOIN ksiegowosc.pracownicy ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika
LEFT JOIN ksiegowosc.premia ON ksiegowosc.premia.id_premii = ksiegowosc.wynagrodzenie.id_premii

--g) wygeneruj raport (zapytanie), które zwróci w wyniki tre?? wg poni?szego szablonu:
--Pracownik Jan Nowak, w dniu 7.08.2017 otrzymał pensję całkowitą na kwotę 7540 zł, gdzie
--wynagrodzenie zasadnicze wynosiło: 5000 zł, premia: 2000 zł, nadgodziny: 540 zł

SELECT 'Pracownik ' + imie + ' ' + nazwisko + ' w dniu ' + CAST(w.data AS varchar) + ' otrzymal pensje calkowita na kwote ' 
+ Cast((pensja.kwota + ISNULL(premia.kwota, 0)) AS VARCHAR) + ' zł, gdzie wynagrodzenie zasadnicze wynosilo: ' + Cast(pensja.kwota AS VARCHAR)
+ ' zl, premia: ' + CAST(ISNULL(premia.kwota, 0) AS VARCHAR) + ' zl, nadgodziny: ' +
CASE WHEN(g.liczba_godzin <= 180) THEN '0.00' ELSE CAST(CAST(ROUND( pensja.kwota/g.liczba_godzin*(g.liczba_godzin-180), 2) AS NUMERIC(8,2)) AS VARCHAR) END 
+ ' zl' AS Raport
FROM ksiegowosc.wynagrodzenie w
LEFT JOIN ksiegowosc.pensja  ON pensja.id_pensji = w.id_pensji
LEFT JOIN ksiegowosc.pracownicy ON pracownicy.id_pracownika = w.id_pracownika
LEFT JOIN ksiegowosc.premia ON premia.id_premii = w.id_premii
Left JOIN ksiegowosc.godziny g ON g.id_godziny = w.id_godziny

