
--PARTITION Nr.1 Wyswietlenie Nazwy gabinetu, Adres gabinetu, ilosci spcecjalistow w danym gabinecie oraz udzial procentowy
SELECT DISTINCT NVL(TO_CHAR(HURTOWNIA_GABINETY.Nazwa),'RAZEM -->') "Nazwa_gabinetu", NVL(TO_CHAR(HURTOWNIA_GABINETY.Adres),'RAZEM -->') "Adres_gabinetu",
COUNT(HURTOWNIA_WIZYTY.Id_specjalizacje) OVER (PARTITION BY HURTOWNIA_WIZYTY.Id_gabinety) AS Ilosc_specjalistow,
ROUND(100 * COUNT(HURTOWNIA_WIZYTY.Id_specjalizacje) OVER (PARTITION BY HURTOWNIA_WIZYTY.Id_gabinety)/(SELECT COUNT(*) FROM HURTOWNIA_LEKARZE),2) AS Udzial_procentowy
FROM HURTOWNIA_WIZYTY
JOIN HURTOWNIA_LEKARZE ON HURTOWNIA_WIZYTY.Id_lekarze = HURTOWNIA_LEKARZE.Id_lekarze
JOIN HURTOWNIA_GABINETY ON HURTOWNIA_WIZYTY.Id_gabinety = HURTOWNIA_GABINETY.Id_gabinety;


--PARTITION Nr.2 Wyswietlenie Imienia pacjenta, Nazwisko pacjenta, Wyniku badania, ilosc badan oraz zliczenie ilosci wnikow procentowo
SELECT DISTINCT NVL(TO_CHAR(HURTOWNIA_PACJENCI.Imie),'RAZEM -->') "Imie_pacjenta", NVL(TO_CHAR(HURTOWNIA_PACJENCI.Nazwisko),'RAZEM -->') "Nazwisko_pacjenta",
NVL(TO_CHAR(HURTOWNIA_WYNIKI_BADAN.Wynik),'RAZEM -->') "Wynik_wyniki_badan",
COUNT(HURTOWNIA_WIZYTY.Id_wyniki_badan) OVER (PARTITION BY HURTOWNIA_WIZYTY.Id_wyniki_badan) AS Ilosc_badan,
ROUND(100 * COUNT(HURTOWNIA_WIZYTY.Id_pacjenci) OVER 
(PARTITION BY HURTOWNIA_WIZYTY.Id_wyniki_badan)/(SELECT COUNT(HURTOWNIA_WIZYTY.Id_wyniki_badan) FROM HURTOWNIA_WIZYTY),2) 
AS Ilosc_wynikow_procentowy
FROM HURTOWNIA_WIZYTY
JOIN HURTOWNIA_PACJENCI ON HURTOWNIA_WIZYTY.Id_pacjenci = HURTOWNIA_PACJENCI.Id_pacjenci
JOIN HURTOWNIA_WYNIKI_BADAN ON HURTOWNIA_WIZYTY.Id_wyniki_badan = HURTOWNIA_WYNIKI_BADAN.Id_wyniki_badan;

--PARTITION Nr.3 Wyswietlenie  Imie lekarza, Nazwisko lekarza, ilosci przyjętych przez lekarza pacjentow oraz udzial procentowy
SELECT DISTINCT  NVL(TO_CHAR(HURTOWNIA_LEKARZE.Imie),'RAZEM -->') "Imie_lekarza", NVL(TO_CHAR(HURTOWNIA_LEKARZE.Nazwisko),'RAZEM -->') "Nazwisko_lekarza",
COUNT(HURTOWNIA_WIZYTY.Id_pacjenci) OVER (PARTITION BY HURTOWNIA_WIZYTY.Id_Lekarze) AS Ilosc_przyjetych_pacjentow_przez_lekarza, 
ROUND(100 * COUNT(HURTOWNIA_WIZYTY.Id_pacjenci) OVER (PARTITION BY HURTOWNIA_WIZYTY.Id_Lekarze)/(SELECT COUNT(*) FROM HURTOWNIA_LEKARZE),2) AS Udzial_procentowy
FROM HURTOWNIA_WIZYTY
JOIN HURTOWNIA_LEKARZE ON HURTOWNIA_WIZYTY.Id_lekarze = HURTOWNIA_LEKARZE.Id_lekarze;
