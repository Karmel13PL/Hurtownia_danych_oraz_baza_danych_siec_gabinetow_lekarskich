
--FUNKCJE RANKINGOWE Nr.1 Wyswietlenie Id pacjenta , Imienia pacjenta, Nazwisko pacjenta, Zliczenie ilosci badan pacjenta oraz ustawienie rankingu po id wizyty
SELECT PACJENCI.Id_pacjenci, PACJENCI.Imie, PACJENCI.Nazwisko, COUNT(BADANIA.Id_badania) AS Liczba_badan, RANK() OVER (ORDER BY COUNT(WIZYTY.Id_wizyty) DESC) AS "RANKING"
FROM WIZYTY
JOIN SKIEROWANIA ON WIZYTY.Id_skierowania = SKIEROWANIA.Id_skierowania
JOIN PACJENCI ON SKIEROWANIA.Id_pacjenci = PACJENCI.Id_pacjenci
JOIN WYNIKI_BADAN ON WIZYTY.Id_wyniki_badan = WYNIKI_BADAN.Id_wyniki_badan
JOIN BADANIA ON WYNIKI_BADAN.Id_badania = BADANIA.Id_badania
GROUP BY PACJENCI.Id_pacjenci, PACJENCI.Imie, PACJENCI.Nazwisko
ORDER BY "RANKING";

--FUNKCJE RANKINGOWE Nr.2 Wyswietlenie Id lekarza , Imienia lekarza, Nazwisko lekarza, Zliczenie ilosci skierowan wystawionych przez lekarza oraz ustawienie rankingu po id wizyty
SELECT LEKARZE.Id_lekarze, LEKARZE.Imie, LEKARZE.Nazwisko, COUNT(SKIEROWANIA.Id_skierowania) AS Liczba_skierowan_wystawionych_przez_lekarza, 
RANK() OVER (ORDER BY COUNT(WIZYTY.Id_wizyty) DESC) AS "RANKING"
FROM WIZYTY
JOIN SKIEROWANIA ON WIZYTY.Id_skierowania = SKIEROWANIA.Id_skierowania
JOIN LEKARZE ON WIZYTY.Id_lekarze = LEKARZE.Id_lekarze
GROUP BY LEKARZE.Id_lekarze, LEKARZE.Imie, LEKARZE.Nazwisko
ORDER BY "RANKING";

--FUNKCJE RANKINGOWE Nr.3 Wyswietlenie Id pacjenta , Imienia pacjenta, Nazwisko pacjenta, Nazwa leku, Zliczenie sredniej ceny leku ktory jest zaokraglany do 2 miejsc po przecinku oraz ustawienie rakingu po cenie lekow
SELECT PACJENCI.Id_pacjenci, PACJENCI.Imie, PACJENCI.Nazwisko, LEKI.Nazwa, ROUND(AVG(LEKI.Cena), 2) AS "Srednia_cena_lekow", 
RANK() OVER (ORDER BY ROUND(AVG(LEKI.Cena), 2) DESC) AS "RANKING"
FROM WIZYTY
JOIN SKIEROWANIA ON WIZYTY.Id_skierowania = SKIEROWANIA.Id_skierowania
JOIN PACJENCI ON SKIEROWANIA.Id_pacjenci = PACJENCI.Id_pacjenci
JOIN RECEPTY ON WIZYTY.Id_recepty = RECEPTY.Id_recepty
JOIN LEKI ON RECEPTY.Id_leki = LEKI.Id_leki
GROUP BY PACJENCI.Id_pacjenci, PACJENCI.Imie, PACJENCI.Nazwisko, LEKI.Nazwa
ORDER BY "RANKING";

