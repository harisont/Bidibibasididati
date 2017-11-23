--Lista degli attori che hanno interpretato film drammatici, con numero di film (di ogni genere) interpretati
SELECT id_attore, COUNT(partecipazione.id_film) AS n_film FROM partecipazione WHERE partecipazione.id_attore IN (SELECT id_attore FROM partecipazione JOIN film ON film.id_film=partecipazione.id_film WHERE genere='Drammatico') GROUP BY partecipazione.id_attore;

--Cinema che hanno proiettato tutti i film nel DB 
SELECT id_cinema FROM cinema AS ic WHERE NOT EXISTS (SELECT * FROM proiezione AS p1 WHERE NOT EXISTS (SELECT * FROM proiezione AS p2 WHERE ic.id_cinema=p2.id_cinema AND p1.id_film=p2.id_film));

--Attori che, per ogni cinema, hanno interpretato almeno un film proiettato (anche Luca concorda sull'output, ma ha fatto con count)
SELECT id_attore FROM partecipazione AS ia WHERE NOT EXISTS (SELECT * FROM cinema AS c WHERE NOT EXISTS (SELECT * FROM proiezione AS p WHERE ia.id_film=p.id_film AND c.id_cinema=p.id_cinema));

--Nome, cognome e film realizzati da registi che condividono un genere con David Cronenberg


--Attori che hanno interpretato film di Lars von Trier
