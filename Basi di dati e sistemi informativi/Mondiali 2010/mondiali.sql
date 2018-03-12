--SIMULAZIONE D'ESAME (2010)

DROP SCHEMA IF EXISTS mondiali CASCADE;   --Da ricordare!
CREATE SCHEMA mondiali;
SET SEARCH_PATH TO mondiali;

--CREAZIONE TABELLE
CREATE TABLE stadio (
   nome varchar(50) PRIMARY KEY,
   citta varchar(30),
   capienza integer CHECK (capienza>0)
);
CREATE TABLE squadra (
   nazione varchar(30) PRIMARY KEY,
   confederazione varchar(30),
   data_qualifica date CHECK (data_qualifica<'31/12/09'),
   sponsor varchar(40)
);
CREATE TABLE partita (
   stadio varchar(50) REFERENCES stadio ON DELETE RESTRICT,
   data date,
   squadra1 varchar(30) REFERENCES squadra ON DELETE RESTRICT ON UPDATE CASCADE NOT NULL,
   squadra2 varchar(30) REFERENCES squadra ON DELETE RESTRICT ON UPDATE CASCADE NOT NULL,
   goal1 integer CHECK (goal1>=0),
   goal2 integer CHECK (goal2>=0),
   spettatori integer CHECK (spettatori>=0),
   PRIMARY KEY(stadio, data)
);

--POPOLAMENTO
INSERT INTO stadio VALUES (
   'Stadio Giovanborgo',
   'Johannesburg',
   10000);
INSERT INTO stadio VALUES (
   'Stadio La Citta Del Capo ha un pss nella rrr',
   'Citta del Capo',
   500000
);
INSERT INTO stadio VALUES (
   'Stadio dei Pirati',
   'Port Elizabeth',
   500000
);
INSERT INTO squadra VALUES (
   'Sudafrica',
   'CAF',
   NULL,
   'Colussi'
);
INSERT INTO squadra VALUES (
   'Messico',
   'UEFA',
   NULL,
   'Nuvole SPA'
);
INSERT INTO squadra VALUES (
   'Uruguay',
   'UEFA',
   '09/09/09',
   NULL
);
INSERT INTO squadra VALUES (
   'Francia',
   'CAF',
   NULL,
   'Mirka'
);
INSERT INTO squadra VALUES (
   'Argentina',
   'UEFA',
   NULL,
   'Asia'
);
INSERT INTO squadra VALUES (
   'Nigeria',
   NULL,
   NULL,
   NULL
);
INSERT INTO squadra VALUES (
   'Corea del Sud',
   NULL,
   NULL,
   'Di certo non la Corea del Nord'
);
INSERT INTO squadra VALUES (
   'Grecia',
   'CAF',
   '11/11/09',
   'Eschilo (che qui si Sofocle)'
);
INSERT INTO partita VALUES (
   'Stadio Giovanborgo',
   '11/06/10',
   'Sudafrica',
   'Messico',
   0,
   3,
   10000
);
INSERT INTO partita VALUES (
   'Stadio La Citta Del Capo ha un pss nella rrr',
   '11/06/10',
   'Uruguay',
   'Francia',
   1,
   2,
   NULL
);
INSERT INTO partita VALUES (
   'Stadio Giovanborgo',
   '12/06/10',
   'Argentina',
   'Nigeria',
   0,
   2,
   1000
);
INSERT INTO partita VALUES (
   'Stadio dei Pirati',
   '12/06/10',
   'Corea del Sud',
   'Grecia',
   0,
   1,
   NULL
);

--QUERY
SELECT DISTINCT nome FROM stadio JOIN partita ON nome=stadio JOIN squadra ON nazione=squadra1 OR nazione=squadra2 WHERE squadra.confederazione='CAF';
SELECT COUNT(*) FROM partita JOIN stadio ON nome=stadio WHERE citta='Johannesburg' AND goal1=goal2 GROUP BY (stadio, data);
