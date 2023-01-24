
--CUBE Nr.1 Wyswietlenie Id pacjenta, Imie pacjenta, Nazwisko pacjenta, Date tylko z rokiem kiedy pacjent byl na wizycie, Nazwe wyniku, zliczenie ilosci wynikow jakie byly pomiedzy rokiem 2017 a 2019 kiedy pacjent byl na wizycie
SELECT NVL(TO_CHAR(HURTOWNIA_PACJENCI.Id_pacjenci),'RAZEM -->') "Id_pacjenta",NVL(TO_CHAR(HURTOWNIA_PACJENCI.Imie),'RAZEM -->') "Imie_pacjenta", 
NVL(TO_CHAR(HURTOWNIA_PACJENCI.Nazwisko),'RAZEM -->') "Nazwisko_pacjenta", NVL(TO_CHAR(EXTRACT(YEAR FROM HURTOWNIA_WIZYTY.Data)), 'RAZEM -->') "Data_wizyty", 
NVL(TO_CHAR(HURTOWNIA_WYNIKI_BADAN.Wynik), 'RAZEM -->') "Wynik_badania", HURTOWNIA_WIZYTY.Ilosc_wynikow
FROM (
SELECT HURTOWNIA_WIZYTY.Id_pacjenci, HURTOWNIA_WIZYTY.Data, HURTOWNIA_WIZYTY.Id_wyniki_badan,COUNT(HURTOWNIA_WIZYTY.Id_wyniki_badan) AS Ilosc_wynikow 
FROM HURTOWNIA_WIZYTY
GROUP BY CUBE(HURTOWNIA_WIZYTY.Id_pacjenci, HURTOWNIA_WIZYTY.Data, HURTOWNIA_WIZYTY.Id_wyniki_badan)
)HURTOWNIA_WIZYTY
JOIN HURTOWNIA_PACJENCI ON HURTOWNIA_WIZYTY.Id_pacjenci = HURTOWNIA_PACJENCI.Id_pacjenci
JOIN HURTOWNIA_WYNIKI_BADAN ON HURTOWNIA_WIZYTY.Id_wyniki_badan = HURTOWNIA_WYNIKI_BADAN.Id_wyniki_badan
WHERE (EXTRACT(YEAR FROM HURTOWNIA_WIZYTY.Data)) BETWEEN 2017 AND 2019
ORDER BY HURTOWNIA_WIZYTY.Id_pacjenci;

--CUBE Nr.2 Wyswietlenie Id pacjenta, Imienia pacjenta, Nazwisko pacjenta, Nazwe leku oraz zliczenie ilosci dawek danego leku ktore musial przyjac pacjent
SELECT NVL(TO_CHAR(HURTOWNIA_PACJENCI.Id_pacjenci),'RAZEM -->') "Id_pacjenta", NVL(TO_CHAR(HURTOWNIA_PACJENCI.Imie),'RAZEM -->') "Imie_pacjenta",  
NVL(TO_CHAR(HURTOWNIA_PACJENCI.Nazwisko),'RAZEM -->') "Nazwisko_pacjenta", NVL(TO_CHAR(HURTOWNIA_LEKI.Nazwa),'RAZEM -->') "Nazwa_leku", HURTOWNIA_WIZYTY.Ilosc_dawek_leku
FROM (SELECT HURTOWNIA_WIZYTY.Id_pacjenci, HURTOWNIA_WIZYTY.Id_leki ,HURTOWNIA_WIZYTY.Id_recepty, COUNT(HURTOWNIA_WIZYTY.Id_recepty) AS Ilosc_dawek_leku
FROM HURTOWNIA_WIZYTY
GROUP BY CUBE(HURTOWNIA_WIZYTY.Id_pacjenci, HURTOWNIA_WIZYTY.Id_leki, HURTOWNIA_WIZYTY.Id_recepty)
)HURTOWNIA_WIZYTY
JOIN HURTOWNIA_PACJENCI ON HURTOWNIA_WIZYTY.Id_pacjenci = HURTOWNIA_PACJENCI.Id_pacjenci
JOIN HURTOWNIA_LEKI ON HURTOWNIA_WIZYTY.Id_leki = HURTOWNIA_LEKI.Id_leki
ORDER BY HURTOWNIA_WIZYTY.Id_pacjenci;

--CUBE Nr.3 Wyswietlenie Id lekarza, Imie lekarza, Nazwisko lekarza, Nazwe gabinetu gdzie pełnił dyżur lekarz, Date dyzuru oraz ilosc dyzurow danego lekarza w gabinecie w roku od 2008 do 2013
SELECT NVL(TO_CHAR(HURTOWNIA_LEKARZE.Id_lekarze),'RAZEM -->') "Id_lekarza", NVL(TO_CHAR(HURTOWNIA_LEKARZE.Imie),'RAZEM -->') "Imie_lekarza",  
NVL(TO_CHAR(HURTOWNIA_LEKARZE.Nazwisko),'RAZEM -->') "Nazwisko_lekarza", NVL(TO_CHAR(HURTOWNIA_GABINETY.Nazwa),'RAZEM -->') "Nazwa_gabinetu", 
NVL(TO_CHAR(EXTRACT(YEAR FROM HURTOWNIA_WIZYTY.Data_dyzury)), 'RAZEM -->') "Data_dyzuru", HURTOWNIA_WIZYTY.Ilosc_dyzurow_lekarzy
FROM (SELECT HURTOWNIA_WIZYTY.Id_lekarze, HURTOWNIA_WIZYTY.Id_gabinety,HURTOWNIA_WIZYTY.Data_dyzury, COUNT(HURTOWNIA_WIZYTY.Id_dyzury) AS Ilosc_dyzurow_lekarzy
FROM HURTOWNIA_WIZYTY
GROUP BY CUBE(HURTOWNIA_WIZYTY.Id_lekarze, HURTOWNIA_WIZYTY.Id_gabinety,HURTOWNIA_WIZYTY.Data_dyzury)
)HURTOWNIA_WIZYTY
JOIN HURTOWNIA_LEKARZE ON HURTOWNIA_WIZYTY.Id_lekarze = HURTOWNIA_LEKARZE.Id_lekarze
JOIN HURTOWNIA_GABINETY ON HURTOWNIA_WIZYTY.Id_gabinety = HURTOWNIA_GABINETY.Id_gabinety
WHERE EXTRACT(YEAR FROM HURTOWNIA_WIZYTY.Data_dyzury) BETWEEN 2008 AND 2013
ORDER BY HURTOWNIA_WIZYTY.Id_lekarze;