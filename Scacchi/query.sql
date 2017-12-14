--Nomi dei giocatori della nazionalita' di Kramnik
SELECT nome FROM giocatore WHERE nazionalita IN (SELECT nazionalita FROM giocatore WHERE nome='Kramnik');

--Nomi e varianti delle aperture successive E86 nell'ordine lessicografico
SELECT nome, variante FROM apertura WHERE eco>'E86';

--Partite aperte con variante '1 e4 c5; 2 c3'
SELECT * FROM partita NATURAL JOIN apertura WHERE risultato IS NULL AND variante='1 e4 c5; 2 c3';

--Risultati partite con aperture diverse da quelle usate da Kasparov col bianco (valori NULL?)
SELECT risultato FROM partita WHERE eco NOT IN (SELECT eco FROM partita WHERE bianco='Kasparov');

--Nomi delle aperture delle partite con numero di mosse inferiore al numero di mosse di almeno una partita giocata da Deep Blue
SELECT nome FROM apertura JOIN partita ON apertura.eco=partita.eco WHERE num_mosse < ANY (SELECT num_mosse FROM partita WHERE bianco='Deep Blue' OR nero='Deep Blue');

--Nazionalità dei giocatori che hanno vinto almeno una partita col bianco (valori NULL?)
SELECT nazionalita FROM giocatore WHERE nome IN (SELECT bianco FROM partita WHERE risultato='1-0');

--Nomi dei giocatori che, con il nero, hanno vinto tutte le partite
SELECT DISTINCT nome FROM giocatore WHERE NOT EXISTS (SELECT * FROM partita WHERE nome=nero AND (risultato!='0-1' OR risultato IS null)) AND nome IN (SELECT nero FROM partita);
