--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.2
-- Dumped by pg_dump version 9.5.2

-- Started on 2017-03-23 10:38:02

SET statement_timeout = 0;
--SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
--SET row_security = off;

--DROP DATABASE "Vendite";
--
-- TOC entry 2112 (class 1262 OID 16556)
-- Name: Vendite; Type: DATABASE; Schema: -; Owner: postgres
--

--CREATE DATABASE "Vendite" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Italian_Italy.1252' LC_CTYPE = 'Italian_Italy.1252';


ALTER DATABASE "Vendite" OWNER TO postgres;

--\connect "Vendite"

SET statement_timeout = 0;
--SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
--SET row_security = off;

--
-- TOC entry 6 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

--CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 2113 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 1 (class 3079 OID 12355)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner:
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2115 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 183 (class 1259 OID 16568)
-- Name: fatti; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE fatti (
    id integer NOT NULL,
    data date NOT NULL,
    prodottoid integer NOT NULL,
    clienteid integer,
    promoid integer,
    prezzouscontato real NOT NULL,
    quantita real NOT NULL
);


ALTER TABLE fatti OWNER TO postgres;

--
-- TOC entry 182 (class 1259 OID 16563)
-- Name: promozioni; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE promozioni (
    idpromo integer NOT NULL,
    datai date NOT NULL,
    dataf date NOT NULL
);


ALTER TABLE promozioni OWNER TO postgres;

--
-- TOC entry 181 (class 1259 OID 16560)
-- Name: tempo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tempo (
    data date NOT NULL,
    mese character(20),
    anno integer,
    gsett character(10),
    festivo boolean
);


ALTER TABLE tempo OWNER TO postgres;

--
-- TOC entry 2107 (class 0 OID 16568)
-- Dependencies: 183
-- Data for Name: fatti; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO fatti (id, data, prodottoid, clienteid, promoid, prezzouscontato, quantita) VALUES (1, '2012-04-18', 1000, 456, 1, 1.32000005, 2);
INSERT INTO fatti (id, data, prodottoid, clienteid, promoid, prezzouscontato, quantita) VALUES (2, '2012-04-18', 1100, 456, 1, 2.44000006, 3);
INSERT INTO fatti (id, data, prodottoid, clienteid, promoid, prezzouscontato, quantita) VALUES (3, '2012-04-18', 1200, 456, 1, 0.99000001, 3);
INSERT INTO fatti (id, data, prodottoid, clienteid, promoid, prezzouscontato, quantita) VALUES (4, '2012-04-18', 1300, 456, NULL, 1.66999996, 1);
INSERT INTO fatti (id, data, prodottoid, clienteid, promoid, prezzouscontato, quantita) VALUES (5, '2012-04-18', 1000, 789, 1, 1.32000005, 4);
INSERT INTO fatti (id, data, prodottoid, clienteid, promoid, prezzouscontato, quantita) VALUES (6, '2012-04-18', 1100, 789, 1, 2.44000006, 1);
INSERT INTO fatti (id, data, prodottoid, clienteid, promoid, prezzouscontato, quantita) VALUES (7, '2012-04-18', 1300, 789, NULL, 1.66999996, 3);
INSERT INTO fatti (id, data, prodottoid, clienteid, promoid, prezzouscontato, quantita) VALUES (8, '2012-04-18', 1400, 789, 4, 8.31999969, 2);
INSERT INTO fatti (id, data, prodottoid, clienteid, promoid, prezzouscontato, quantita) VALUES (9, '2012-04-18', 1500, 789, 4, 4.98999977, 2);
INSERT INTO fatti (id, data, prodottoid, clienteid, promoid, prezzouscontato, quantita) VALUES (10, '2012-04-18', 1000, 123, 1, 1.32000005, 2);
INSERT INTO fatti (id, data, prodottoid, clienteid, promoid, prezzouscontato, quantita) VALUES (11, '2012-04-18', 1100, 123, 1, 2.44000006, 2);
INSERT INTO fatti (id, data, prodottoid, clienteid, promoid, prezzouscontato, quantita) VALUES (12, '2012-04-18', 1400, 123, 4, 8.31999969, 2);
INSERT INTO fatti (id, data, prodottoid, clienteid, promoid, prezzouscontato, quantita) VALUES (13, '2012-04-18', 1500, 123, 4, 4.98999977, 2);
INSERT INTO fatti (id, data, prodottoid, clienteid, promoid, prezzouscontato, quantita) VALUES (14, '2012-04-18', 1600, 123, NULL, 0.889999986, 1);
INSERT INTO fatti (id, data, prodottoid, clienteid, promoid, prezzouscontato, quantita) VALUES (15, '2012-04-20', 1000, 456, 1, 1.32000005, 1);
INSERT INTO fatti (id, data, prodottoid, clienteid, promoid, prezzouscontato, quantita) VALUES (16, '2012-04-20', 1600, 456, 2, 0.589999974, 5);
INSERT INTO fatti (id, data, prodottoid, clienteid, promoid, prezzouscontato, quantita) VALUES (17, '2012-04-20', 1600, 789, 2, 0.589999974, 3);
INSERT INTO fatti (id, data, prodottoid, clienteid, promoid, prezzouscontato, quantita) VALUES (18, '2012-04-20', 1600, 123, 2, 0.589999974, 6);
INSERT INTO fatti (id, data, prodottoid, clienteid, promoid, prezzouscontato, quantita) VALUES (19, '2012-04-20', 1500, 456, 4, 4.98999977, 4);
INSERT INTO fatti (id, data, prodottoid, clienteid, promoid, prezzouscontato, quantita) VALUES (20, '2012-04-20', 1500, 789, 4, 4.98999977, 2);
INSERT INTO fatti (id, data, prodottoid, clienteid, promoid, prezzouscontato, quantita) VALUES (21, '2012-04-18', 1600, 456, NULL, 0.889999986, 1);
INSERT INTO fatti (id, data, prodottoid, clienteid, promoid, prezzouscontato, quantita) VALUES (22, '2012-05-18', 1500, 456, NULL, 5.98999977, 1);
INSERT INTO fatti (id, data, prodottoid, clienteid, promoid, prezzouscontato, quantita) VALUES (23, '2012-05-18', 1500, 789, NULL, 5.98999977, 1);


--
-- TOC entry 2106 (class 0 OID 16563)
-- Dependencies: 182
-- Data for Name: promozioni; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO promozioni (idpromo, datai, dataf) VALUES (1, '2012-04-18', '2012-06-18');
INSERT INTO promozioni (idpromo, datai, dataf) VALUES (2, '2012-04-20', '2012-05-19');
INSERT INTO promozioni (idpromo, datai, dataf) VALUES (3, '2012-06-18', '2012-06-21');
INSERT INTO promozioni (idpromo, datai, dataf) VALUES (4, '2012-04-18', '2012-04-21');
INSERT INTO promozioni (idpromo, datai, dataf) VALUES (5, '2012-05-18', '2012-06-18');


--
-- TOC entry 2105 (class 0 OID 16560)
-- Dependencies: 181
-- Data for Name: tempo; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO tempo (data, mese, anno, gsett, festivo) VALUES ('2012-04-18', 'aprile2012          ', 2012, 'lunedi    ', false);
INSERT INTO tempo (data, mese, anno, gsett, festivo) VALUES ('2012-04-19', 'aprile2012          ', 2012, 'martedi   ', false);
INSERT INTO tempo (data, mese, anno, gsett, festivo) VALUES ('2012-04-20', 'aprile2012          ', 2012, 'mercoledi ', NULL);
INSERT INTO tempo (data, mese, anno, gsett, festivo) VALUES ('2012-04-21', 'aprile2012          ', 2012, 'giovedi   ', NULL);
INSERT INTO tempo (data, mese, anno, gsett, festivo) VALUES ('2012-05-18', 'maggio2012          ', 2012, 'domenica  ', NULL);
INSERT INTO tempo (data, mese, anno, gsett, festivo) VALUES ('2012-05-19', 'maggio2012          ', 2012, 'lunedi    ', false);
INSERT INTO tempo (data, mese, anno, gsett, festivo) VALUES ('2012-06-18', 'giugno2012          ', 2012, 'martedi   ', NULL);
INSERT INTO tempo (data, mese, anno, gsett, festivo) VALUES ('2012-06-19', 'giugno2012          ', 2012, 'mercoledi ', false);
INSERT INTO tempo (data, mese, anno, gsett, festivo) VALUES ('2012-06-20', 'giugno2012          ', 2012, 'giovedi   ', false);
INSERT INTO tempo (data, mese, anno, gsett, festivo) VALUES ('2012-06-21', 'giugno2012          ', 2012, 'venerdi   ', false);


--
-- TOC entry 1990 (class 2606 OID 16572)
-- Name: fatti_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY fatti
    ADD CONSTRAINT fatti_pkey PRIMARY KEY (id);


--
-- TOC entry 1988 (class 2606 OID 16567)
-- Name: promozioni_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY promozioni
    ADD CONSTRAINT promozioni_pkey PRIMARY KEY (idpromo);


--
-- TOC entry 2114 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2017-03-23 10:38:02

--
-- PostgreSQL database dump complete
--

--QUERY
--incassi mensili [e settimanali] per ogni prodotto, suddivisi ulteriormente in base alle possibili promozioni
