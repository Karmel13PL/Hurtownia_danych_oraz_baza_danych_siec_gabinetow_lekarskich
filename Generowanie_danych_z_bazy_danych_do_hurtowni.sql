define sciezka = 'F:\Dane'
set sqlformat csv

--Hurtownia Pacjenci
spool &&sciezka\1Hurtownia_pacjenci.csv;
SELECT PACJENCI.Id_pacjenci, PACJENCI.Imie, PACJENCI.Nazwisko
FROM PACJENCI;
spool off;

--Hurtownia Lekarze
spool &&sciezka\2Hurtownia_lekarze.csv;
SELECT LEKARZE.Id_lekarze, LEKARZE.Imie, LEKARZE.Nazwisko
FROM LEKARZE;
spool off;

--Hurtownia Badania
spool &&sciezka\3Hurtownia_badania.csv;
SELECT BADANIA.Id_badania, BADANIA.Nazwa
FROM BADANIA;
spool off;

--Hurtownia Wyniki Badan
spool &&sciezka\4Hurtownia_wyniki_badan.csv;
SELECT WYNIKI_BADAN.Id_wyniki_badan, WYNIKI_BADAN.Wynik
FROM WYNIKI_BADAN;
spool off;

--Hurtownia Leki
spool &&sciezka\5Hurtownia_leki.csv;
SELECT LEKI.Id_leki, LEKI.Nazwa
FROM LEKI;
spool off;

--Hurtownia Gabinety
spool &&sciezka\6Hurtownia_gabinety.csv;
SELECT GABINETY.Id_gabinety, GABINETY.Nazwa, GABINETY.Adres
FROM GABINETY;
spool off;


--Hurtownia Wizyty
spool &&sciezka\7Hurtownia_wizyty.csv;
SELECT WIZYTY.Id_wizyty, PACJENCI.Id_pacjenci, LEKARZE.Id_lekarze, BADANIA.Id_badania, WYNIKI_BADAN.Id_wyniki_badan, LEKI.Id_leki, GABINETY.Id_gabinety, WIZYTY.Data, 
WYNIKI_BADAN.Data AS Data_wyniki_badan, RECEPTY.Id_recepty, RECEPTY.Data AS Data_recepty, LEKI.Cena AS Cena_leki, BADANIA.Cena AS Cena_badania, DYZURY.Id_dyzury, 
DYZURY.Data AS Data_dyzury, SPECJALIZACJE.Id_specjalizacje, SKIEROWANIA.Id_skierowania
FROM WIZYTY
JOIN LEKARZE ON WIZYTY.Id_lekarze = LEKARZE.Id_lekarze
JOIN DYZURY ON LEKARZE.Id_dyzury = DYZURY.Id_dyzury
JOIN SPECJALIZACJE ON LEKARZE.Id_specjalizacje = SPECJALIZACJE.Id_specjalizacje
JOIN SKIEROWANIA ON WIZYTY.Id_skierowania = SKIEROWANIA.Id_skierowania
JOIN PACJENCI ON SKIEROWANIA.Id_pacjenci = PACJENCI.Id_pacjenci
JOIN WYNIKI_BADAN ON WIZYTY.Id_wyniki_badan = WYNIKI_BADAN.Id_wyniki_badan
JOIN BADANIA ON WYNIKI_BADAN.Id_badania = BADANIA.Id_badania
JOIN RECEPTY ON WIZYTY.Id_recepty = RECEPTY.Id_recepty
JOIN LEKI ON RECEPTY.Id_leki = LEKI.Id_leki
JOIN GABINETY ON WIZYTY.Id_gabinety = GABINETY.Id_gabinety;
spool off;