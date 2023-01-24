
--CUBE Nr.1 Wyswietlenie Id pacjenta, Imie pacjenta, Nazwisko pacjenta, Date tylko z rokiem kiedy pacjent byl na wizycie, Nazwe wyniku, zliczenie ilosci wynikow jakie byly pomiedzy rokiem 2017 a 2019 kiedy pacjent byl na wizycie
SELECT NVL(TO_CHAR(PACJENCI.Id_pacjenci),'RAZEM -->') "Id_pacjenta", NVL(TO_CHAR(PACJENCI.Imie),'RAZEM -->') "Imie_pacjenta", NVL(TO_CHAR(PACJENCI.Nazwisko),'RAZEM -->') "Nazwisko_pacjenta",
NVL(TO_CHAR(EXTRACT(YEAR FROM WIZYTY.Data)), 'RAZEM -->') "Data_wizyty", 
NVL(TO_CHAR(WYNIKI_BADAN.Wynik), 'RAZEM -->') "Wynik_badania", COUNT(WYNIKI_BADAN.Id_wyniki_badan) AS Ilosc_wynikow
FROM WIZYTY
JOIN SKIEROWANIA ON WIZYTY.Id_skierowania = SKIEROWANIA.Id_skierowania
JOIN PACJENCI ON SKIEROWANIA.Id_pacjenci = PACJENCI.Id_pacjenci
JOIN WYNIKI_BADAN ON WIZYTY.Id_wyniki_badan = WYNIKI_BADAN.Id_wyniki_badan
WHERE (EXTRACT(YEAR FROM WIZYTY.Data)) BETWEEN 2017 AND 2019
GROUP BY CUBE(PACJENCI.Id_pacjenci, PACJENCI.Imie, PACJENCI.Nazwisko,(EXTRACT(YEAR FROM WIZYTY.Data)), WYNIKI_BADAN.Id_wyniki_badan ,WYNIKI_BADAN.Wynik);


--CUBE Nr.2 Wyswietlenie Id pacjenta, Imienia pacjenta, Nazwisko pacjenta, Nazwe leku oraz zliczenie ilosci dawek danego leku ktore musial przyjac pacjent
SELECT NVL(TO_CHAR(PACJENCI.Id_pacjenci),'RAZEM -->') "Id_pacjenta", NVL(TO_CHAR(PACJENCI.Imie),'RAZEM -->') "Imie_pacjenta",  NVL(TO_CHAR(PACJENCI.Nazwisko),'RAZEM -->') "Nazwisko_pacjenta",
NVL(TO_CHAR(LEKI.Nazwa),'RAZEM -->') "Nazwa_leku",COUNT(RECEPTY.Id_recepty) AS Ilosc_dawek_leku
FROM WIZYTY
JOIN SKIEROWANIA ON WIZYTY.Id_skierowania = SKIEROWANIA.Id_skierowania
JOIN PACJENCI ON SKIEROWANIA.Id_pacjenci = PACJENCI.Id_pacjenci
JOIN RECEPTY ON WIZYTY.Id_recepty = RECEPTY.Id_recepty
JOIN LEKI ON RECEPTY.Id_leki = LEKI.Id_leki
GROUP BY CUBE(PACJENCI.Id_pacjenci, PACJENCI.Imie, PACJENCI.Nazwisko, LEKI.Nazwa);

--CUBE Nr.3 Wyswietlenie Id lekarza, Imie lekarza, Nazwisko lekarza, Nazwe gabinetu gdzie pełnił dyżur lekarz, Date dyzuru oraz ilosc dyzurow danego lekarza w gabinecie w roku od 2008 do 2013
SELECT NVL(TO_CHAR(LEKARZE.Id_lekarze),'RAZEM -->') "Id_lekarza", NVL(TO_CHAR(LEKARZE.Imie),'RAZEM -->') "Imie_lekarza",  NVL(TO_CHAR(LEKARZE.Nazwisko),'RAZEM -->') "Nazwisko_lekarza",
NVL(TO_CHAR(GABINETY.Nazwa),'RAZEM -->') "Nazwa_gabinetu", NVL(TO_CHAR(EXTRACT(YEAR FROM DYZURY.Data)), 'RAZEM -->') "Data_dyzuru",COUNT(LEKARZE.Id_dyzury) AS Ilosc_dyzurow_lekarzy
FROM WIZYTY
JOIN LEKARZE ON WIZYTY.Id_lekarze = LEKARZE.Id_lekarze
JOIN DYZURY ON LEKARZE.Id_dyzury = DYZURY.Id_dyzury
JOIN GABINETY ON WIZYTY.Id_gabinety = GABINETY.Id_gabinety
WHERE EXTRACT(YEAR FROM DYZURY.Data) BETWEEN 2008 AND 2013
GROUP BY CUBE(LEKARZE.Id_lekarze, LEKARZE.Imie, LEKARZE.Nazwisko, GABINETY.Nazwa, EXTRACT(YEAR FROM DYZURY.Data));