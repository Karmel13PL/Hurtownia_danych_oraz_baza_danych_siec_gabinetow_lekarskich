
--PARTITION Nr.1 Wyswietlenie Nazwy gabinetu, Adres gabinetu, ilosci spcecjalistow w danym gabinecie oraz udzial procentowy
SELECT DISTINCT NVL(TO_CHAR(GABINETY.Nazwa),'RAZEM -->') "Nazwa_gabinetu", NVL(TO_CHAR(GABINETY.Adres),'RAZEM -->') "Adres_gabinetu",
COUNT(LEKARZE.Id_specjalizacje) OVER (PARTITION BY GABINETY.Id_gabinety) AS Ilosc_specjalistow,
ROUND(100 * COUNT(LEKARZE.Id_specjalizacje) OVER (PARTITION BY GABINETY.Id_gabinety)/(SELECT COUNT(*) FROM LEKARZE),2) AS Udzial_procentowy
FROM WIZYTY
JOIN LEKARZE ON WIZYTY.Id_lekarze = LEKARZE.Id_lekarze
JOIN SPECJALIZACJE ON LEKARZE.Id_specjalizacje = SPECJALIZACJE.Id_specjalizacje
JOIN GABINETY ON WIZYTY.Id_gabinety = GABINETY.Id_gabinety;

--PARTITION Nr.2 Wyswietlenie Imienia pacjenta, Nazwisko pacjenta, Wyniku badania, ilosc badan oraz zliczenie ilosci wnikow procentowo
SELECT DISTINCT NVL(TO_CHAR(PACJENCI.Imie),'RAZEM -->') "Imie_pacjenta", NVL(TO_CHAR(PACJENCI.Nazwisko),'RAZEM -->') "Nazwisko_pacjenta",
NVL(TO_CHAR(WYNIKI_BADAN.Wynik),'RAZEM -->') "Wynik_wyniki_badan",
COUNT(WYNIKI_BADAN.Id_wyniki_badan) OVER (PARTITION BY WYNIKI_BADAN.Id_wyniki_badan) AS Ilosc_badan,
ROUND(100 * COUNT(PACJENCI.Id_pacjenci) OVER (PARTITION BY WYNIKI_BADAN.Id_wyniki_badan)/(SELECT COUNT(WIZYTY.Id_wyniki_badan) FROM WIZYTY),2) AS Ilosc_wynikow_procentowy
FROM WIZYTY
JOIN SKIEROWANIA ON WIZYTY.Id_skierowania = SKIEROWANIA.Id_skierowania
JOIN PACJENCI ON SKIEROWANIA.Id_pacjenci = PACJENCI.Id_pacjenci
JOIN WYNIKI_BADAN ON WIZYTY.Id_wyniki_badan = WYNIKI_BADAN.Id_wyniki_badan;


--PARTITION Nr.3 Wyswietlenie  Imie lekarza, Nazwisko lekarza, ilosci przyjętych przez lekarza pacjentow oraz udzial procentowy
SELECT DISTINCT  NVL(TO_CHAR(LEKARZE.Imie),'RAZEM -->') "Imie_lekarza", NVL(TO_CHAR(LEKARZE.Nazwisko),'RAZEM -->') "Nazwisko_lekarza",
COUNT(PACJENCI.Id_pacjenci) OVER (PARTITION BY LEKARZE.Imie, LEKARZE.Nazwisko) AS Ilosc_przyjetych_pacjentow_przez_lekarza, 
ROUND(100 * COUNT(PACJENCI.Id_pacjenci) OVER (PARTITION BY LEKARZE.Imie, LEKARZE.Nazwisko)/(SELECT COUNT(*) FROM LEKARZE),2) AS Udzial_procentowy
FROM WIZYTY
JOIN SKIEROWANIA ON WIZYTY.Id_skierowania = SKIEROWANIA.Id_skierowania
JOIN PACJENCI ON SKIEROWANIA.Id_pacjenci = PACJENCI.Id_pacjenci
JOIN LEKARZE ON WIZYTY.Id_lekarze = LEKARZE.Id_lekarze;


