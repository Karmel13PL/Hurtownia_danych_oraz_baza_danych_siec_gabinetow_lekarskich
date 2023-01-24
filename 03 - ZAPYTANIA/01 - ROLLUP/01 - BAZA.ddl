
--ROLLUP Nr.1 Wyświetlenie Id_pacjenta, Imienia, Nazwisko, zliczenie ilości recept danego pacjenta oraz suma wydanych pieniędzy na leki
SELECT NVL(TO_CHAR(PACJENCI.Id_pacjenci), 'RAZEM--->') "Id_pacjenta", NVL(PACJENCI.Imie, 'RAZEM--->') "Imie_pacjenta", 
NVL(PACJENCI.Nazwisko, 'RAZEM--->') "Nazwisko_pacjenta",
COUNT(RECEPTY.Id_recepty) AS ILOSC_RECEPT, SUM(LEKI.Cena) AS Cena_za_wszystkie_leki
FROM WIZYTY
JOIN SKIEROWANIA ON WIZYTY.Id_skierowania = SKIEROWANIA.Id_skierowania
JOIN PACJENCI ON SKIEROWANIA.Id_pacjenci = PACJENCI.Id_pacjenci
JOIN RECEPTY ON WIZYTY.Id_recepty = RECEPTY.Id_recepty
JOIN LEKI ON RECEPTY.Id_leki = LEKI.Id_leki
GROUP BY ROLLUP (PACJENCI.Id_pacjenci, PACJENCI.Imie, PACJENCI.Nazwisko);


--ROLLUP Nr.2 Wyswietlenie Id pacjenci, Imie pacjenta, Nazwisko pacjenta, Srednia cena lekow pacjenta, Suma ceny lekow pacjenta, Srednia cena badan pacjenta oraz suma ceny badan pacjenta
SELECT NVL(TO_CHAR(PACJENCI.Id_pacjenci),'RAZEM--->') "Id_pacjenta", NVL(TO_CHAR(PACJENCI.Imie),'RAZEM--->') "Imie_pacjenta", NVL(TO_CHAR(PACJENCI.Nazwisko),'RAZEM--->') "Nazwisko_pacjenta", 
ROUND(AVG(LEKI.Cena),2) AS Srednia_cena_lekow, SUM(LEKI.Cena) AS Suma_ceny_lekow, ROUND(AVG(BADANIA.Cena),2) AS Srednia_cena_badan, SUM(BADANIA.Cena) AS Suma_ceny_badan
FROM WIZYTY
JOIN SKIEROWANIA ON SKIEROWANIA.Id_skierowania = WIZYTY.Id_wizyty
JOIN PACJENCI ON SKIEROWANIA.Id_pacjenci = PACJENCI.Id_pacjenci
JOIN RECEPTY ON WIZYTY.Id_recepty = RECEPTY.Id_recepty
JOIN LEKI ON RECEPTY.Id_leki = LEKI.Id_leki
JOIN WYNIKI_BADAN ON WIZYTY.Id_wyniki_badan = WYNIKI_BADAN.Id_wyniki_badan
JOIN BADANIA ON WYNIKI_BADAN.Id_badania = BADANIA.Id_badania
GROUP BY ROLLUP (PACJENCI.Id_pacjenci, PACJENCI.Imie, PACJENCI.Nazwisko);


--ROLLUP Nr.3 Wyswietlenie Id pacjenta, Imie pacjenta, Nazwisko pacjenta, zliczenie ilosci badania oraz podsumowanie ceny za wszystkie badania
SELECT NVL(TO_CHAR(PACJENCI.Id_pacjenci),'RAZEM -->') "Id_pacjenta", NVL(TO_CHAR(PACJENCI.Imie), 'RAZEM -->') "Imie_pacjenta", NVL(TO_CHAR(PACJENCI.Nazwisko), 'RAZEM -->') "Nazwisko_pacjenta" , 
COUNT(WYNIKI_BADAN.Id_badania) AS Ilosc_badan, SUM(BADANIA.Cena) AS Cena_za_wszystkie_badania
FROM WIZYTY
JOIN SKIEROWANIA ON WIZYTY.Id_skierowania = SKIEROWANIA.Id_skierowania
JOIN PACJENCI ON SKIEROWANIA.Id_pacjenci = PACJENCI.Id_pacjenci
JOIN WYNIKI_BADAN ON WIZYTY.Id_wyniki_badan = WYNIKI_BADAN.Id_wyniki_badan
JOIN BADANIA ON WYNIKI_BADAN.Id_badania = BADANIA.Id_badania
GROUP BY ROLLUP (PACJENCI.Id_pacjenci,PACJENCI.Imie, PACJENCI.Nazwisko, BADANIA.Nazwa);