--SIMULAZIONE D'ESAME (2010)

DROP SCHEMA IF EXISTS mondiali CASCADE;   --Da ricordare!
CREATE SCHEMA mondiali;
SET SEARCH_PATH TO mondiali;

--CREAZIONE TABELLE
CREATE TABLE stadio (
   nome varchar(50) PRIMARY KEY,
   citta varchar(30),
   capienza integer CHECK (capienza>0)
);
CREATE TABLE squadra (
   nazione varchar(30) PRIMARY KEY,
   confederazione varchar(30),
   data_qualifica date,
   sponsor varchar(40)
);
CREATE TABLE partita (
   stadio varchar(50) REFERENCES stadio ON DELETE RESTRICT,
   data date,
   squadra1 varchar(30) REFERENCES squadra ON DELETE RESTRICT ON UPDATE CASCADE NOT NULL,
   squadra2 varchar(30) REFERENCES squadra ON DELETE RESTRICT ON UPDATE CASCADE NOT NULL,
   goal1 integer CHECK (goal1>=0),
   goal2 integer CHECK (goal2>=0),
   spettatori integer CHECK (spettatori>=0),
   PRIMARY KEY(stadio, data)
);
