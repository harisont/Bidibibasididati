--Qual è il contenuto della tabella 'persona'?
SELECT * FROM persona;

 --Selezionare i cognomi delle persone nel DB (senza eliminare i doppioni)
SELECT cognome FROM persona;

--Idem come sopra, con ordine lessicografico per cognome
SELECT cognome FROM persona ORDER BY cognome;

--Definire l'insieme dei cognomi (ossia idem come riga 2, eliminando i doppioni)
SELECT DISTINCT cognome FROM persona;

--Selezionare gli id delle persone di nome 'John'
SELECT id_persona FROM persona WHERE nome='John';

--Selezionare i cognomi delle persone di nome 'John'
SELECT cognome FROM persona WHERE nome='John'

--Selezionare gli id degli attori
SELECT id_persona FROM persona, partecipazione WHERE id_attore=id_persona;

--Definire la lista di tutte le interpretazioni, specificando cognome, nome, ruolo e titolo
SELECT cognome, nome, ruolo, titolo FROM persona, partecipazione, film WHERE film.id_film=partecipazione.id_film AND id_persona= id_attore;

--Idem come sopra, ma in modo discorsivo
SELECT nome || ' ' || cognome || ' ha interpretato il ruolo di '  || ruolo || ' nel film ' || titolo FROM persona, partecipazione, film WHERE film.id_film=partecipazione.id_film AND id_persona= id_attore;

--Quali film sono drammatici?
SELECT DISTINCT titolo FROM film WHERE genere='Drammatico';

--Quali titoli sono stati proiettati nel 2002?
SELECT DISTINCT titolo FROM film, proiezione WHERE film.id_film=proiezione.id_film AND giorno>='2002-1-1' AND giorno<='2002-12-1';

--Selezionare i film diretti da Lars von Trier
SELECT DISTINCT titolo FROM film, persona where id_regista=id_persona AND nome='Lars' AND cognome='von Trier';

--Elencare i titoli proiettati al cinema 'Le Fontanelle'
SELECT DISTINCT titolo FROM film, proiezione, cinema WHERE film.id_film=proiezione.id_film AND proiezione.id_cinema=cinema.id_cinema and cinema.nome='Le Fontanelle';

--Elencare nome e cognome di tutti i registi
SELECT DISTINCT nome, cognome FROM persona, film WHERE id_persona=id_regista;

--Elencare nome e cognome di tutti gli attori
SELECT DISTINCT nome, cognome FROM persona, partecipazione WHERE id_persona=id_attore;

--Elencare nome e cognome di tutti gli attori che sono anche registi
SELECT DISTINCT nome, cognome FROM persona, partecipazione, film WHERE id_persona=id_attore AND id_persona=id_regista;

 --Quali attori hanno preso parte a film proiettati al cinema 'Zenith' dopo il 2000?
SELECT DISTINCT nome, cognome FROM persona, partecipazione, proiezione WHERE id_persona=id_attore AND partecipazione.id_film=proiezione.id_film AND giorno>='2002-1-1';

--Quali sono i titoli dei film con Nicole Kidman che non sono stati proiettati al cinema "Le Fontanelle"
SELECT DISTINCT titolo FROM film, persona, partecipazione WHERE film.id_film=partecipazione.id_film AND persona.id_persona=partecipazione.id_attore AND persona.nome='Nicole' AND persona.cognome='Kidman' EXCEPT SELECT DISTINCT titolo FROM film, cinema, proiezione WHERE film.id_film=proiezione.id_film AND proiezione.id_cinema=cinema.id_cinema AND cinema.nome='Le Fontanelle';

--Quali cognomi contengono la lettera 's'?
SELECT DISTINCT cognome FROM persona WHERE cognome LIKE '%s%';

--Quali titoli contengono almeno tre 'e'
SELECT DISTINCT titolo FROM film WHERE titolo LIKE '%e%e%e%';
