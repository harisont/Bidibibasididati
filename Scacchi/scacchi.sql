DROP SCHEMA IF EXISTS scacchi CASCADE;
CREATE SCHEMA scacchi;
SET SEARCH_PATH TO scacchi;

--CREAZIONE TABELLE

CREATE TABLE giocatore(
   nome varchar(10) primary key,    --è un nickname, pertanto è unico
   nazionalità varchar(25)
);

CREATE TABLE apertura(
   eco varchar(3) primary key,   --manca check formato stringa
   nome varchar(15) NOT NULL,
   variante varchar(15) UNIQUE   --l'univocità qui non ha senso, ma era richiesta
);

CREATE TABLE partita(
   bianco varchar(10) REFERENCES giocatore(nome),
   nero varchar(10) REFERENCES giocatore(nome),
   luogo varchar(30),
   anno integer CHECK (anno>=0),
   round integer CHECK (round>0),
   eco varchar(3) REFERENCES apertura(eco),
   risultato varchar(3) CHECK (risultato LIKE '[0-1]-[0-1]' OR '1/2'),
   num_mosse integer CHECK (num_mosse>2),
   PRIMARY KEY(bianco, nero, luogo, anno, round)
);
