DROP SCHEMA IF EXISTS biblioteca CASCADE;
CREATE SCHEMA biblioteca;
SET SEARCH_PATH TO biblioteca;

--CREAZIONE TABELLE

CREATE TABLE scrittore(
	nome varchar(50) PRIMARY KEY,
	sesso char CHECK(sesso='F' OR sesso='M'),
	nazione varchar(5));

CREATE TABLE genere(
	nome varchar(20) PRIMARY KEY,
	sala char);

CREATE TABLE libro(
	ISBN varchar(13) PRIMARY KEY,
	titolo varchar(50),
	autore varchar(50) references scrittore(nome) ON DELETE RESTRICT,
	genere varchar(20) references genere(nome));

CREATE TABLE socio(
	id varchar(9) PRIMARY KEY,
	nome varchar(50),
	sesso char CHECK(sesso='F' OR sesso='M'),
	eta integer CHECK(eta>0));

CREATE TABLE ha_letto(
	socio varchar(9) references socio(id) ON DELETE CASCADE ON UPDATE CASCADE,
	ISBN varchar(13) references libro(ISBN) ON DELETE CASCADE ON UPDATE CASCADE);

--POPOLAMENTO
--manuale
INSERT INTO scrittore(nome, sesso, nazione) VALUES ('A. C. Doyle', 'M', 'UK');
INSERT INTO scrittore(nome, sesso, nazione) VALUES ('E. A. Poe', 'M', 'UK');
INSERT INTO scrittore(nome, sesso, nazione) VALUES ('E. Montale', 'M', 'IT');
INSERT INTO scrittore(nome, sesso, nazione) VALUES ('L. Sciascia', 'M', 'IT');
INSERT INTO scrittore(nome, sesso, nazione) VALUES ('L. Borges', 'M', 'AR');
INSERT INTO scrittore(nome, sesso, nazione) VALUES ('G. Leopardi', 'M', 'IT');
--da file
\copy genere FROM Genere.txt
\copy libro FROM Libro.txt
\copy socio FROM Socio.txt
\copy ha_letto FROM Ha_letto.txt

--QUERY
--socie che hanno letto qualche libro
SELECT DISTINCT nome FROM socio JOIN ha_letto ON id=socio INTERSECT SELECT DISTINCT nome FROM socio WHERE sesso='F';
--titoli dei libri in sala A
SELECT DISTINCT titolo FROM libro JOIN genere ON genere=nome WHERE sala='A';
--lista dei titoli e rispettiva sala di collocazione
SELECT titolo, sala FROM libro JOIN genere ON genere=nome;
--lista dei titoli e rispettiva sala di collocazione (inclusi libri privi di collocazione)
SELECT titolo, sala FROM libro LEFT JOIN genere ON genere=nome;
--id dei soci che hanno letto un libro della sala A
SELECT DISTINCT socio FROM ha_letto NATURAL JOIN libro JOIN genere ON libro.genere=genere.nome WHERE sala='A';
--nomi delle coppie di soci che hanno letto uno stesso libro (che parto!)
SELECT DISTINCT socio1.nome, socio2.nome FROM ha_letto JOIN socio AS socio1 ON id=socio, ha_letto AS ha_letto_bis JOIN socio AS socio2 ON id=socio WHERE ha_letto.socio<>ha_letto_bis.socio AND ha_letto.isbn=ha_letto_bis.isbn;
--nomi dei soci che hanno letto un libro della sala A
SELECT DISTINCT socio.nome FROM socio JOIN ha_letto ON socio.id=ha_letto.socio NATURAL JOIN libro JOIN genere ON libro.genere=genere.nome WHERE sala='A';
--nomi di autori letti da almeno una donna
SELECT autore FROM scrittore JOIN libro ON autore=nome NATURAL JOIN ha_letto JOIN socio ON socio=socio.id WHERE socio.sesso='F';
--soci che NON hanno mai letto libri della sala B
SELECT socio FROM ha_letto EXCEPT SELECT DISTINCT socio FROM ha_letto NATURAL JOIN libro JOIN genere ON libro.genere=genere.nome WHERE sala='B';
