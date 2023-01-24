CREATE TABLE Hurtownia_pacjenci (
   Id_pacjenci NUMBER(6) NOT NULL,
   Imie VARCHAR2(70) NOT NULL,
   Nazwisko VARCHAR2(70) NOT NULL,

  CONSTRAINT Hurtownia_pacjenci_PK PRIMARY KEY (Id_pacjenci)
);


CREATE TABLE Hurtownia_lekarze (
   Id_lekarze NUMBER(6) NOT NULL,
   Imie VARCHAR2(70) NOT NULL,
   Nazwisko VARCHAR2(70) NOT NULL,

   CONSTRAINT Hurtownia_lekarze PRIMARY KEY (Id_lekarze)
);

CREATE TABLE Hurtownia_badania (
   Id_badania NUMBER(6) NOT NULL,
   Nazwa VARCHAR2(255) NOT NULL,

  CONSTRAINT Hurtownia_badania_PK PRIMARY KEY (Id_badania)
);


CREATE TABLE Hurtownia_wyniki_badan (
   Id_wyniki_badan NUMBER(6) NOT NULL,
   Wynik VARCHAR2(255),

  CONSTRAINT Hurtownia_wyniki_badan_PK PRIMARY KEY (Id_wyniki_badan)
);

CREATE TABLE Hurtownia_leki (
   Id_leki NUMBER(6) NOT NULL,
   Nazwa VARCHAR(200) NOT NULL,

  CONSTRAINT Hurtownia_leki_PK PRIMARY KEY (Id_leki)
);

CREATE TABLE Hurtownia_gabinety (
   Id_gabinety NUMBER(6) NOT NULL,
   Nazwa VARCHAR2(70) NOT NULL,
   Adres VARCHAR2(70) NOT NULL,

  CONSTRAINT Hurtownia_gabinety_PK PRIMARY KEY (Id_gabinety)
);


CREATE TABLE Hurtownia_wizyty (
   Id_wizyty NUMBER(6) NOT NULL,
   Id_pacjenci NUMBER(6) NOT NULL,
   Id_lekarze NUMBER(6) NOT NULL,
   Id_badania NUMBER(6) NOT NULL,
   Id_wyniki_badan NUMBER(6) NOT NULL,
   Id_leki NUMBER(6) NOT NULL,
   Id_gabinety NUMBER(6) NOT NULL,
   Data DATE NOT NULL,
   Data_wyniki_badan DATE NOT NULL,
   Id_recepty NUMBER(6) NOT NULL,
   Data_recepty DATE NOT NULL,
   Cena_leki FLOAT NOT NULL,
   Cena_badania FLOAT NOT NULL,
   Id_dyzury NUMBER(6) NOT NULL,
   Data_dyzury DATE NOT NULL,
   Id_specjalizacje NUMBER(6) NOT NULL,
   Id_skierowania NUMBER(6) NOT NULL,

   CONSTRAINT Hurtownia_wizyty_PK PRIMARY KEY (Id_wizyty),
   CONSTRAINT Hurtownia_pacjenci_FK FOREIGN KEY (Id_pacjenci) REFERENCES Hurtownia_pacjenci(Id_pacjenci),
   CONSTRAINT Hurtownia_lekarze_FK FOREIGN KEY (Id_lekarze) REFERENCES Hurtownia_lekarze(Id_lekarze),
   CONSTRAINT Hurtownia_badania_FK FOREIGN KEY (Id_badania) REFERENCES Hurtownia_badania(Id_badania),
   CONSTRAINT Hurtownia_wyniki_badan_FK FOREIGN KEY (Id_wyniki_badan) REFERENCES Hurtownia_wyniki_badan(Id_wyniki_badan),
   CONSTRAINT Hurtownia_leki_FK FOREIGN KEY (Id_leki) REFERENCES Hurtownia_leki(Id_leki),
   CONSTRAINT Hurtownia_gabinety_FK FOREIGN KEY (Id_gabinety) REFERENCES Hurtownia_gabinety(Id_gabinety)
);

