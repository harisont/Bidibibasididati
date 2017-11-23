DROP SCHEMA IF EXISTS europei2012 CASCADE;
CREATE SCHEMA europei2012;
SET SEARCH_PATH TO europei2012;

--CREAZIONE TABELLE
CREATE TABLE stadio(
	nome varchar(50) PRIMARY KEY, 
	città varchar(20), 
	capienza integer);
CREATE TABLE squadra(
	nazione varchar(25) PRIMARY KEY,
	confederazione varchar(25),
	data_qualifica timestamp,
	sponsor varchar(30));
CREATE TABLE partita(
	stadio varchar(25) REFERENCES stadio(nome) ON DELETE RESTRICT ON UPDATE CASCADE, 
	data timestamp,
	squadra1 varchar(20) NOT NULL REFERENCES squadra(nazione) ON DELETE RESTRICT ON UPDATE CASCADE,
	squadra2 varchar(20) NOT NULL REFERENCES squadra(nazione) ON DELETE RESTRICT ON UPDATE CASCADE,
	goal1 integer CHECK(goal1>=0),
	goal2 integer CHECK(goal2>=0),
	n_spettatori integer CHECK(goal2>=0),
	PRIMARY KEY(stadio, data));

