
--FUNKCJE RANKINGOWE Nr.1 Wyswietlenie Id pacjenta , Imienia pacjenta, Nazwisko pacjenta, Zliczenie ilosci badan pacjenta oraz ustawienie rankingu po id wizyty
SELECT HURTOWNIA_PACJENCI.Id_pacjenci, HURTOWNIA_PACJENCI.Imie, HURTOWNIA_PACJENCI.Nazwisko, COUNT(HURTOWNIA_WIZYTY.Id_badania) AS Liczba_badan, 
RANK() OVER (ORDER BY COUNT(HURTOWNIA_WIZYTY.Id_wizyty) DESC) AS "RANKING"
FROM HURTOWNIA_WIZYTY
JOIN HURTOWNIA_PACJENCI ON HURTOWNIA_WIZYTY.Id_pacjenci = HURTOWNIA_PACJENCI.Id_pacjenci
GROUP BY HURTOWNIA_PACJENCI.Id_pacjenci, HURTOWNIA_PACJENCI.Imie, HURTOWNIA_PACJENCI.Nazwisko
ORDER BY "RANKING";


--FUNKCJE RANKINGOWE Nr.2 Wyswietlenie Id lekarza , Imienia lekarza, Nazwisko lekarza, Zliczenie ilosci skierowan wystawionych przez lekarza oraz ustawienie rankingu po id wizyty
SELECT HURTOWNIA_LEKARZE.Id_lekarze, HURTOWNIA_LEKARZE.Imie, HURTOWNIA_LEKARZE.Nazwisko, COUNT(HURTOWNIA_WIZYTY.Id_skierowania) AS Liczba_skierowan_wystawionych_przez_lekarza, 
RANK() OVER (ORDER BY COUNT(HURTOWNIA_WIZYTY.Id_wizyty) DESC) AS "RANKING"
FROM HURTOWNIA_WIZYTY
JOIN HURTOWNIA_LEKARZE ON HURTOWNIA_WIZYTY.Id_lekarze = HURTOWNIA_LEKARZE.Id_lekarze
GROUP BY HURTOWNIA_LEKARZE.Id_lekarze, HURTOWNIA_LEKARZE.Imie, HURTOWNIA_LEKARZE.Nazwisko
ORDER BY "RANKING";



--FUNKCJE RANKINGOWE Nr.3 Wyswietlenie Id pacjenta , Imienia pacjenta, Nazwisko pacjenta, Nazwa leku, Zliczenie sredniej ceny leku ktory jest zaokraglany do 2 miejsc po przecinku oraz ustawienie rakingu po cenie lekow
SELECT HURTOWNIA_PACJENCI.Id_pacjenci, HURTOWNIA_PACJENCI.Imie, HURTOWNIA_PACJENCI.Nazwisko, HURTOWNIA_LEKI.Nazwa, 
ROUND(AVG(HURTOWNIA_WIZYTY.Cena_leki), 2) AS "Srednia_cena_lekow", RANK() OVER (ORDER BY ROUND(AVG(HURTOWNIA_WIZYTY.Cena_leki), 2) DESC) AS "RANKING"
FROM HURTOWNIA_WIZYTY
JOIN HURTOWNIA_PACJENCI ON HURTOWNIA_WIZYTY.Id_pacjenci = HURTOWNIA_PACJENCI.Id_pacjenci
JOIN HURTOWNIA_LEKI ON HURTOWNIA_WIZYTY.Id_leki = HURTOWNIA_LEKI.Id_leki
GROUP BY HURTOWNIA_PACJENCI.Id_pacjenci, HURTOWNIA_PACJENCI.Imie, HURTOWNIA_PACJENCI.Nazwisko, HURTOWNIA_LEKI.Nazwa
ORDER BY "RANKING";