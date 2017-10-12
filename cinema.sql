DROP SCHEMA IF EXISTS cinema CASCADE;
CREATE SCHEMA cinema;
SET SEARCH_PATH TO cinema;
CREATE TABLE persona(
	id_persona integer PRIMARY KEY, 
	nome varchar(20) NOT NULL, 
	cognome varchar(20) NOT NULL);

CREATE TABLE film(
	id_film integer PRIMARY KEY, 
	id_regista integer REFERENCES persona(id_persona) ON DELETE SET NULL, 
	titolo varchar(50), 
	genere varchar(10), 
	anno integer CHECK(anno>0));

CREATE TABLE partecipazione(
	id_attore integer REFERENCES persona(id_persona) ON DELETE CASCADE, 
	id_film integer REFERENCES film(id_film) ON DELETE CASCADE, 
	ruolo varchar(50), 
	PRIMARY KEY(id_attore, id_film));

CREATE TABLE cinema(
	id_cinema integer PRIMARY KEY, 
	nome varchar(40) NOT NULL, 
	indirizzo varchar(50));

CREATE TABLE proiezione(
	id_cinema integer REFERENCES cinema(id_cinema) ON DELETE CASCADE, 
	id_film integer REFERENCES film(id_film) ON DELETE CASCADE, 
	giorno timestamp, 
	PRIMARY KEY (id_cinema, id_film, giorno));

INSERT INTO cinema(id_cinema, nome, indirizzo) VALUES (02, 'S. Angelo', 'Via Lucida 6 Perugia');
INSERT INTO cinema(id_cinema, nome, indirizzo) VALUES (01, 'Zenith', 'Via Bonfigli 11 Perugia');
INSERT INTO cinema(id_cinema, nome, indirizzo) VALUES (03, 'Multisala Clarici', 'Corso Cavour 84 Foligno');
INSERT INTO cinema(id_cinema, nome, indirizzo) VALUES (04, 'Multiplex Giometti', 'Strada Centova Perugia');

\copy persona FROM persona.txt 
\copy film FROM film.txt 
\copy partecipazione FROM partecipazione.txt 
\copy proiezione FROM proiezione.txt

