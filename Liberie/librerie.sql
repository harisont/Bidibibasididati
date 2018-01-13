--Cancellazioni a cascata
DROP SCHEMA IF EXISTS librerie CASCADE;
CREATE SCHEMA librerie;
SET search_path TO librerie;

--Creazione tabelle
CREATE TABLE autori (
	codice int PRIMARY KEY,
	cognome varchar(30),
	nome varchar(30)
);
CREATE TABLE editori (
	codice int PRIMARY KEY,
	nome varchar(30),
	citta varchar(40)
);
CREATE TABLE libri (
	codice int PRIMARY KEY,
	titolo varchar(50),
	genere varchar(20),
	editore integer REFERENCES editori(codice)
		ON DELETE RESTRICT ON UPDATE RESTRICT,
	prezzo numeric(5, 2)	--i libri costano, ma fino a un certo punto
);
CREATE TABLE ha_scritto (
	libro int REFERENCES libri(codice)
		ON DELETE CASCADE ON UPDATE CASCADE,
	autore int REFERENCES autori(codice)
		ON DELETE CASCADE ON UPDATE CASCADE,
	progr_autore int CHECK(progr_autore>0),
	PRIMARY KEY(libro, autore)
);
CREATE TABLE librerie (
	codice int PRIMARY KEY,
	nome varchar(30),
	sede varchar(50)
);
CREATE TABLE scorte (
	libro int REFERENCES libri(codice)
		ON DELETE CASCADE ON UPDATE CASCADE,
	libreria int REFERENCES librerie(codice)
		ON DELETE CASCADE ON UPDATE CASCADE,
	copie int CHECK (copie>=0 AND copie IS NOT NULL),
	PRIMARY KEY(libro, libreria)
);

\copy autori from autori.txt
\copy editori from editori.txt
\copy libri from libri.txt
\copy ha_scritto from ha_scritto.txt
\copy librerie from librerie.txt
\copy scorte from scorte.txt

--Modifiche
UPDATE scorte SET copie=0 WHERE copie=1000;

--Query
SELECT DISTINCT * FROM libri WHERE prezzo>10;
SELECT DISTINCT copie, titolo, cognome FROM libri JOIN scorte ON libri.codice=scorte.libro JOIN librerie ON librerie.codice=scorte.libreria JOIN ha_scritto ON ha_scritto.libro=libri.codice JOIN autori ON autori.codice=ha_scritto.autore WHERE progr_autore=1 AND librerie.nome='La libreria';
SELECT DISTINCT autore FROM ha_scritto WHERE autore NOT IN (SELECT autore FROM ha_scritto JOIN libri ON ha_scritto.libro=libri.codice WHERE genere='Fantasy');
SELECT libri.titolo, editori.codice FROM libri JOIN editori ON libri.editore=editori.codice WHERE libri.prezzo>(SELECT MAX(prezzo) FROM libri WHERE genere='Fantasy' GROUP BY codice);
SELECT libro, libreria FROM scorte WHERE copie=0;
