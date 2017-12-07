--Nomi dei giocatori della nazionalita' di Kramnik
SELECT nome FROM giocatore WHERE nazionalita IN (SELECT nazionalita FROM giocatore WHERE nome='Kramnik');

--Nomi e varianti delle aperture successive E86 nell'ordine lessicografico
SELECT nome, variante FROM apertura WHERE eco>'E86';

--Partite aperte con variante '1 e4 c5; 2 c3'
SELECT * FROM partita NATURAL JOIN apertura WHERE risultato IS NULL AND variante='1 e4 c5; 2 c3';

