cd */Dane
SET login=BAZA_DANYCH
SET haslo=123456789
sqlldr userid=%login%/%haslo% control='1Specjalizacje.txt' skip=1 
sqlldr userid=%login%/%haslo% control='2Dyzury.txt' skip=1
sqlldr userid=%login%/%haslo% control='3Lekarze.txt' skip=1
sqlldr userid=%login%/%haslo% control='4Uprawnienia.txt' skip=1
sqlldr userid=%login%/%haslo% control='5Pracownicy.txt' skip=1
sqlldr userid=%login%/%haslo% control='6Gabinety.txt' skip=1
sqlldr userid=%login%/%haslo% control='7Pacjenci.txt' skip=1
sqlldr userid=%login%/%haslo% control='8Skierowania.txt' skip=1
sqlldr userid=%login%/%haslo% control='9Badania.txt' skip=1
sqlldr userid=%login%/%haslo% control='10Wyniki_badan.txt' skip=1
sqlldr userid=%login%/%haslo% control='11Producenci.txt' skip=1
sqlldr userid=%login%/%haslo% control='12Leki.txt' skip=1
sqlldr userid=%login%/%haslo% control='13Recepty.txt' skip=1
sqlldr userid=%login%/%haslo% control='14Wizyty.txt' skip=1
del *.log
del *.bad
pause