CREATE TABLE Specjalizacje (
    Id_specjalizacje NUMBER(6) NOT NULL,
    Nazwa VARCHAR2(70) NOT NULL,

    CONSTRAINT Specjalizacje_PK PRIMARY KEY (Id_specjalizacje)
);

CREATE TABLE Dyzury (
    Id_dyzury NUMBER(6) NOT NULL,
    Data DATE NOT NULL,

    CONSTRAINT Dyzury_PK PRIMARY KEY (Id_dyzury)
);

CREATE TABLE Lekarze (
    Id_lekarze NUMBER(6) NOT NULL,
	Id_specjalizacje NUMBER(6) NOT NULL,
	Id_dyzury NUMBER(6) NOT NULL,
    Imie VARCHAR2(70) NOT NULL,
    Nazwisko VARCHAR2(70) NOT NULL,
	Data_zatrudnienia DATE NOT NULL,
	Pensja NUMBER(6) NOT NULL,

    CONSTRAINT Lekarze_PK PRIMARY KEY (Id_lekarze),
	CONSTRAINT Lekarze_Specjalizacje_FK FOREIGN KEY (Id_specjalizacje) REFERENCES Specjalizacje(Id_specjalizacje),
	CONSTRAINT Lekarze_Dyzury_FK FOREIGN KEY (Id_dyzury) REFERENCES Dyzury(Id_dyzury)
);



CREATE TABLE Uprawnienia (
    Id_uprawnienia NUMBER(6) NOT NULL,
    Nazwa VARCHAR2(70) NOT NULL,

    CONSTRAINT Uprawnienia_PK PRIMARY KEY (Id_uprawnienia)
);

CREATE TABLE Pracownicy (
    Id_pracownicy NUMBER(6) NOT NULL,
    Id_uprawnienia NUMBER(6) NOT NULL,
    Imie VARCHAR2(70) NOT NULL,
    Nazwisko VARCHAR2(70) NOT NULL,
    Data_zatrudnienia DATE NOT NULL,
	Pensja FLOAT NOT NULL,

    CONSTRAINT Pracownicy_PK PRIMARY KEY (Id_pracownicy),
    CONSTRAINT Pracownicy_Uprawnienia_FK FOREIGN KEY (Id_uprawnienia) REFERENCES Uprawnienia(Id_uprawnienia)
);


CREATE TABLE Gabinety (
    Id_gabinety NUMBER(6) NOT NULL,
	Id_pracownicy NUMBER(6) NOT NULL,
    Nazwa VARCHAR2(70) NOT NULL,
    Adres VARCHAR2(70) NOT NULL,
	Numer_pokoju NUMBER(6) NOT NULL,

    CONSTRAINT Gabinety_PK PRIMARY KEY (Id_gabinety),
	CONSTRAINT Gabinety_Pracownicy_FK FOREIGN KEY (Id_pracownicy) REFERENCES Pracownicy(Id_pracownicy)
);


CREATE TABLE Pacjenci (
    Id_pacjenci NUMBER(6) NOT NULL,
    Imie VARCHAR2(70) NOT NULL,
    Nazwisko VARCHAR2(70) NOT NULL,
    Data_urodzenia DATE NOT NULL,
	Pesel NUMBER(11) NOT NULL,

    CONSTRAINT Pacjenci_PK PRIMARY KEY (Id_pacjenci)
);


CREATE TABLE Skierowania (
    Id_skierowania NUMBER(6) NOT NULL,
    Id_pacjenci NUMBER(6) NOT NULL,
    Data DATE NOT NULL,
    Opis VARCHAR2(255),

    CONSTRAINT Skierowania_PK PRIMARY KEY (Id_skierowania),
    CONSTRAINT Skierowania_Pacjenci_FK FOREIGN KEY (Id_pacjenci) REFERENCES Pacjenci(Id_pacjenci)
);

CREATE TABLE Badania (
    Id_badania NUMBER(6) NOT NULL,
    Nazwa VARCHAR2(255) NOT NULL,
    Cena FLOAT NOT NULL,

    CONSTRAINT Badania_PK PRIMARY KEY (Id_badania)
);

CREATE TABLE Wyniki_badan (
    Id_wyniki_badan NUMBER(6) NOT NULL,
    Id_badania NUMBER(6) NOT NULL,
    Data DATE NOT NULL,
    Wynik VARCHAR2(255),

    CONSTRAINT Wyniki_badan_PK PRIMARY KEY (Id_wyniki_badan),
    CONSTRAINT Wyniki_badan_Badania_FK FOREIGN KEY (Id_badania) REFERENCES Badania(Id_badania)
);

CREATE TABLE Producenci (
    Id_producenci NUMBER(6) NOT NULL,
    Nazwa VARCHAR2(255) NOT NULL,

    CONSTRAINT Producenci_PK PRIMARY KEY (Id_producenci)
);

CREATE TABLE Leki (
    Id_leki NUMBER(6) NOT NULL,
	Id_producenci NUMBER(6) NOT NULL,
    Nazwa VARCHAR(200) NOT NULL,
    Cena FLOAT NOT NULL,

    CONSTRAINT Leki_PK PRIMARY KEY (Id_leki),
	CONSTRAINT Leki_Producenci_FK FOREIGN KEY (Id_producenci) REFERENCES Producenci(Id_producenci)
);

CREATE TABLE Recepty (
    Id_recepty NUMBER(6) NOT NULL,
	Id_leki NUMBER(6) NOT NULL,
    Data DATE NOT NULL,
	Dawka VARCHAR2(70) NOT NULL,

    CONSTRAINT Recepty_PK PRIMARY KEY (Id_recepty),
    CONSTRAINT Recepty_Leki_FK FOREIGN KEY (Id_leki) REFERENCES Leki(Id_leki)
);



CREATE TABLE Wizyty (
    Id_wizyty NUMBER(6) NOT NULL ,
    Id_lekarze NUMBER(6) NOT NULL,
    Id_gabinety NUMBER(6) NOT NULL,
	Id_skierowania NUMBER(6) NOT NULL,
	Id_wyniki_badan NUMBER(6) NOT NULL,
	Id_recepty NUMBER(6) NOT NULL,
    Data DATE NOT NULL,
    Opis VARCHAR2(255),

    CONSTRAINT Wizyty_PK PRIMARY KEY (Id_wizyty),
    CONSTRAINT Wizyty_Lekarze_FK FOREIGN KEY (Id_lekarze) REFERENCES Lekarze(Id_lekarze),
    CONSTRAINT Wizyty_Gabinety_FK FOREIGN KEY (Id_gabinety) REFERENCES Gabinety(Id_gabinety),
	CONSTRAINT Wizyty_Skierowania_FK FOREIGN KEY (Id_skierowania) REFERENCES Skierowania(Id_skierowania),
	CONSTRAINT Wizyty_Wyniki_badan_FK FOREIGN KEY (Id_wyniki_badan) REFERENCES Wyniki_badan(Id_wyniki_badan),
	CONSTRAINT Wizyty_recepty_FK FOREIGN KEY (Id_recepty) REFERENCES Recepty(Id_recepty)
);
