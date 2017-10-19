SELECT * FROM persona;
SELECT cognome FROM persona;
SELECT cognome FROM persona ORDER BY cognome;
SELECT DISTINCT cognome FROM persona;
SELECT cognome FROM persona WHERE nome='John';
SELECT DISTINCT * FROM persona WHERE id_attore=id_persona;
SELECT cognome, nome, ruolo FROM persona, partecipazione, film WHERE film.id_film=partecipazione.id_film AND id_persona= id_attore;
SELECT DISTINCT titolo from film WHERE genere='Drammatico';
SELECT titolo FROM film, proiezione WHERE film.id_film=proiezione.id_film AND giorno>='2002-1-1' AND giorno<='2002-12-1';

