DROP SCHEMA IF EXISTS altro_cinema CASCADE;
CREATE SCHEMA altro_cinema;
SET SEARCH_PATH TO altro_cinema;

--Creazione dominio
CREATE DOMAIN tel AS char(8)
CONSTRAINT numbers_only
CHECK (VALUE NOT LIKE '%[^0-9]%');

--Creazione tabelle
CREATE TABLE cinema (
   nome varchar(25) PRIMARY KEY,
   numero_tel tel,
   indirizzo varchar(50)
);
CREATE TABLE sala (
   cinema varchar(25) REFERENCES cinema(nome),
   codice integer,
   n_posti integer CHECK(n_posti>0),
   PRIMARY KEY (cinema, codice)
);
CREATE TABLE genere (
   codice integer PRIMARY KEY,
   nome varchar(25)
);
CREATE TABLE regista (
   id integer PRIMARY KEY,
   nome varchar(50),
   cognome varchar(50),
   anno_nascita integer CHECK(anno_nascita>1900)
);
CREATE TABLE film (
   titolo varchar(50) PRIMARY KEY,
   genere integer REFERENCES genere(codice),
   nazione varchar(25),
   regista integer REFERENCES regista(id)
);
CREATE TABLE proiezione (
   cinema varchar(25),
   sala integer,
   film varchar(50),
   ora_inizio time,
   FOREIGN KEY (cinema, sala) REFERENCES sala(cinema, codice),
   PRIMARY KEY (cinema, sala, ora_inizio)
);

\copy cinema FROM cinema.txt
\copy film FROM genere.txt
\copy genere FROM genere.txt
\copy proiezione FROM proiezione.txt
\copy regista FROM regista.txt
\copy sala FROM sala.txt
