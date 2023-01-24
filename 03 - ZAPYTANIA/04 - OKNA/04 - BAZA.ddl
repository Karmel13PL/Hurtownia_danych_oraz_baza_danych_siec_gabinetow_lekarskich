
--OKNA Nr.1 Wyswietlenie Daty z samym rokiem oraz ile lekarz przyjal pacjentow o imieniu Alexander od 2000 roku
SELECT EXTRACT(YEAR FROM WIZYTY.Data) AS Data_wizyt_pacjentow, COUNT(PACJENCI.Id_pacjenci) OVER (PARTITION BY LEKARZE.Id_lekarze
ORDER BY EXTRACT(YEAR FROM WIZYTY.Data)
RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) as "Ile_lekarz_przyjal_pacjentow"
FROM WIZYTY
JOIN LEKARZE ON WIZYTY.Id_lekarze = LEKARZE.Id_lekarze
JOIN SKIEROWANIA ON WIZYTY.Id_skierowania = SKIEROWANIA.Id_skierowania
JOIN PACJENCI ON SKIEROWANIA.Id_pacjenci = PACJENCI.Id_pacjenci
WHERE LEKARZE.Imie = 'Alexander' AND EXTRACT(YEAR FROM WIZYTY.Data) <= 2018;

--OKNA Nr.2 Wyswietlenie Daty z samy rokiem wizyty, Imienia pacjenta, Nazwisko pacjenta, Nazwa badania, Ilosc wykonanych badan dla pacjenta o podanym imieniu i nazwisku ktore zostaly wykonane pomiedzy 2005 a 2012
SELECT EXTRACT(YEAR FROM WIZYTY.Data) AS Data_wizyt_pacjenta, PACJENCI.Imie, PACJENCI.Nazwisko, BADANIA.Nazwa,COUNT(PACJENCI.Id_pacjenci) OVER (PARTITION BY BADANIA.Id_badania
ORDER BY EXTRACT(YEAR FROM WYNIKI_BADAN.Data)
RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) as "Ilosc_badan_wykonanych_dla_pacjenta"
FROM WIZYTY
JOIN WYNIKI_BADAN ON WIZYTY.Id_wyniki_badan = WYNIKI_BADAN.Id_wyniki_badan
JOIN BADANIA ON WYNIKI_BADAN.Id_badania = BADANIA.Id_badania
JOIN SKIEROWANIA ON WIZYTY.Id_skierowania = SKIEROWANIA.Id_skierowania
JOIN PACJENCI ON SKIEROWANIA.Id_pacjenci = PACJENCI.Id_pacjenci
WHERE PACJENCI.Imie = 'Rick' AND PACJENCI.Nazwisko = 'Liggens' AND EXTRACT(YEAR FROM WIZYTY.Data) BETWEEN 2005 AND 2012;

--PARTITION Nr.3 Wyswietlenie Daty z samy rokiem wizyty, Imienia pacjenta, Nazwisko pacjenta, sumy ceny lekow ktore pacjent kupil
SELECT EXTRACT(YEAR FROM WIZYTY.Data) AS Data_wizyt_pacjenta, PACJENCI.Imie, PACJENCI.Nazwisko, SUM(LEKI.Cena) OVER (PARTITION BY LEKI.Id_leki
ORDER BY EXTRACT(YEAR FROM RECEPTY.Data)
RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) as "Sumy_ceny_lekow_danego_pacjenta"
FROM WIZYTY
JOIN RECEPTY ON WIZYTY.Id_recepty = RECEPTY.Id_recepty
JOIN LEKI ON RECEPTY.Id_leki = LEKI.Id_leki
JOIN SKIEROWANIA ON WIZYTY.Id_skierowania = SKIEROWANIA.Id_skierowania
JOIN PACJENCI ON SKIEROWANIA.Id_pacjenci = PACJENCI.Id_pacjenci;