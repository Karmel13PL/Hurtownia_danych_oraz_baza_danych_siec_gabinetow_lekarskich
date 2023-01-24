cd */Dane
SET login=BAZA_DANYCH
SET haslo=123456789
sqlldr userid=%login%/%haslo% control='1Hurtownia_pacjenci.txt' skip=1 
sqlldr userid=%login%/%haslo% control='2Hurtownia_lekarze.txt' skip=1
sqlldr userid=%login%/%haslo% control='3Hurtownia_badania.txt' skip=1
sqlldr userid=%login%/%haslo% control='4Hurtownia_wyniki_badan.txt' skip=1
sqlldr userid=%login%/%haslo% control='5Hurtownia_leki.txt' skip=1
sqlldr userid=%login%/%haslo% control='6Hurtownia_gabinety.txt' skip=1
sqlldr userid=%login%/%haslo% control='7Hurtownia_wizyty.txt' skip=1
del *.log
del *.bad
pause