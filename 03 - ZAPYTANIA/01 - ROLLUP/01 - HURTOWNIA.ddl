
--ROLLUP Nr.1 Wyświetlenie Id_pacjenta, Imienia, Nazwisko, zliczenie ilości recept danego pacjenta oraz suma wydanych pieniędzy na leki
SELECT NVL(TO_CHAR(HURTOWNIA_PACJENCI.Id_pacjenci), 'RAZEM--->') "Id_pacjenta", NVL(HURTOWNIA_PACJENCI.Imie, '---RAZEM--->') "Imie_pacjenta", 
NVL(HURTOWNIA_PACJENCI.Nazwisko, '---RAZEM--->') "Nazwisko_pacjenta", HURTOWNIA_WIZYTY.ILOSC_RECEPT, HURTOWNIA_WIZYTY.Cena_za_wszytkie_leki
FROM (SELECT HURTOWNIA_WIZYTY.Id_pacjenci, COUNT(HURTOWNIA_WIZYTY.Id_recepty) AS ILOSC_RECEPT,SUM(HURTOWNIA_WIZYTY.Cena_leki) AS Cena_za_wszytkie_leki
FROM HURTOWNIA_WIZYTY
GROUP BY ROLLUP(HURTOWNIA_WIZYTY.Id_pacjenci)
)HURTOWNIA_WIZYTY
JOIN HURTOWNIA_PACJENCI ON HURTOWNIA_WIZYTY.Id_pacjenci = HURTOWNIA_PACJENCI.Id_pacjenci;

--ROLLUP Nr.2 Wyswietlenie Id pacjenci, Imie pacjenta, Nazwisko pacjenta, Srednia cena lekow pacjenta, Suma ceny lekow pacjenta, Srednia cena badan pacjenta oraz suma ceny badan pacjenta
SELECT NVL(TO_CHAR(HURTOWNIA_PACJENCI.Id_pacjenci),'RAZEM--->') "Id_pacjenta", NVL(TO_CHAR(HURTOWNIA_PACJENCI.Imie),'RAZEM--->') "Imie_pacjenta", NVL(TO_CHAR(HURTOWNIA_PACJENCI.Nazwisko),'RAZEM--->') "Nazwisko_pacjenta", 
HURTOWNIA_WIZYTY.Srednia_cena_lekow, HURTOWNIA_WIZYTY.Suma_ceny_lekow, HURTOWNIA_WIZYTY.Srednia_cena_badan, HURTOWNIA_WIZYTY.Suma_ceny_badan
FROM (SELECT HURTOWNIA_WIZYTY.Id_pacjenci, ROUND(AVG(HURTOWNIA_WIZYTY.Cena_leki),2) AS Srednia_cena_lekow, SUM(HURTOWNIA_WIZYTY.Cena_leki) AS Suma_ceny_lekow, 
ROUND(AVG(HURTOWNIA_WIZYTY.Cena_badania),2) AS Srednia_cena_badan,SUM(HURTOWNIA_WIZYTY.Cena_badania) AS Suma_ceny_badan
FROM HURTOWNIA_WIZYTY
GROUP BY ROLLUP (HURTOWNIA_WIZYTY.Id_pacjenci)
)HURTOWNIA_WIZYTY
JOIN HURTOWNIA_PACJENCI ON HURTOWNIA_WIZYTY.Id_pacjenci = HURTOWNIA_PACJENCI.Id_pacjenci;

--ROLLUP Nr.3 Wyswietlenie Id pacjenta, Imie pacjenta, Nazwisko pacjenta, zliczenie ilosci badania oraz podsumowanie ceny za wszystkie badania
SELECT NVL(TO_CHAR(HURTOWNIA_PACJENCI.Id_pacjenci),'RAZEM -->') "Id_pacjenta",NVL(TO_CHAR(HURTOWNIA_PACJENCI.Imie), 'RAZEM -->') "Imie_pacjenta", 
NVL(TO_CHAR(HURTOWNIA_PACJENCI.Nazwisko), 'RAZEM -->') "Nazwisko_pacjenta", HURTOWNIA_WIZYTY.Ilosc_badan, HURTOWNIA_WIZYTY.Cena_za_wszystkie_badania
FROM (SELECT HURTOWNIA_WIZYTY.Id_pacjenci, COUNT(HURTOWNIA_WIZYTY.Id_badania) AS Ilosc_badan, 
SUM(HURTOWNIA_WIZYTY.Cena_badania) AS Cena_za_wszystkie_badania
FROM HURTOWNIA_WIZYTY
GROUP BY ROLLUP (HURTOWNIA_WIZYTY.Id_pacjenci)
)HURTOWNIA_WIZYTY
JOIN HURTOWNIA_PACJENCI ON HURTOWNIA_WIZYTY.Id_pacjenci = HURTOWNIA_PACJENCI.Id_pacjenci
ORDER BY HURTOWNIA_PACJENCI.Id_pacjenci;