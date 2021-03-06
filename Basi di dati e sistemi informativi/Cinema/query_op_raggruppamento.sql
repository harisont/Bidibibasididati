--Lista degli attori con numero film interpretati, ordianta per cognome
SELECT nome, cognome, COUNT (id_film) AS n_film FROM persona JOIN partecipazione ON id_attore=id_persona GROUP BY nome, cognome ORDER BY cognome;

--idem con anno produzione primo e ultimo film interpretato
SELECT nome, cognome, COUNT (id_film) AS n_film, MIN(anno) AS anno_primo_film, MAX(anno) as anno_secondo_film FROM persona JOIN partecipazione ON id_attore=id_persona NATURAL JOIN film GROUP BY nome, cognome ORDER BY cognome;

--idem solo per attori che hanno interpretato almeno due film
SELECT nome, cognome, COUNT (id_film) AS n_film, MIN(anno) AS anno_primo_film, MAX(anno) as anno_secondo_film FROM persona JOIN partecipazione ON id_attore=id_persona NATURAL JOIN film GROUP BY nome, cognome HAVING count (id_film)>1 ORDER BY cognome;

--attori che hanno interpretato film drammatici, con numero di film drammatici interpretati
SELECT nome, cognome, COUNT (id_film) AS n_film_drammatici FROM persona JOIN partecipazione ON id_attore=id_persona NATURAL JOIN film WHERE genere='Drammatico' GROUP BY nome, cognome;

--numero film diretti da cisacun regista
SELECT nome, cognome, COUNT (id_film) AS n_film FROM persona JOIN film ON id_persona=id_regista GROUP BY nome, cognome;
