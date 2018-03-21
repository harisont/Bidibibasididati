--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.4
-- Dumped by pg_dump version 9.3.4
-- Started on 2014-04-04 10:37:48

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 1997 (class 1262 OID 16414)
-- Name: catenaHotels; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "catenaHotels" WITH TEMPLATE = template0 ENCODING = 'UTF8';


ALTER DATABASE "catenaHotels" OWNER TO postgres;

\connect "catenaHotels"

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 181 (class 3079 OID 11750)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner:
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2000 (class 0 OID 0)
-- Dependencies: 181
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 170 (class 1259 OID 16464)
-- Name: camera; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE camera (
    cameraid integer NOT NULL,
    hotelid integer NOT NULL,
    tipologiaid integer NOT NULL,
    prezzo integer NOT NULL
);


ALTER TABLE public.camera OWNER TO postgres;

--
-- TOC entry 173 (class 1259 OID 16494)
-- Name: stato_camere; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE stato_camere (
    cameraid integer NOT NULL,
    data date NOT NULL,
    stato character varying(4) NOT NULL
);


ALTER TABLE public.stato_camere OWNER TO postgres;

--
-- TOC entry 180 (class 1259 OID 16618)
-- Name: calendario_camere; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW calendario_camere AS
 SELECT DISTINCT camera.hotelid,
    stato_camere.data
   FROM (camera
   JOIN stato_camere USING (cameraid))
  ORDER BY camera.hotelid, stato_camere.data;


ALTER TABLE public.calendario_camere OWNER TO postgres;

--
-- TOC entry 175 (class 1259 OID 16575)
-- Name: fatti; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE fatti (
    cameraid integer NOT NULL,
    data date NOT NULL,
    hotelid integer,
    prezzo integer
);


ALTER TABLE public.fatti OWNER TO postgres;

--
-- TOC entry 179 (class 1259 OID 16613)
-- Name: fatti2; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE fatti2 (
    hotelid integer NOT NULL,
    data date NOT NULL,
    libere real,
    occupate real,
    nd real
);


ALTER TABLE public.fatti2 OWNER TO postgres;

--
-- TOC entry 171 (class 1259 OID 16469)
-- Name: hotel; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE hotel (
    hotelid integer NOT NULL,
    nome character varying(20) NOT NULL,
    stelle integer NOT NULL,
    "città" character varying(20) NOT NULL,
    prov character varying(2) NOT NULL,
    regione character varying(20) NOT NULL
);


ALTER TABLE public.hotel OWNER TO postgres;

--
-- TOC entry 176 (class 1259 OID 16580)
-- Name: libere; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW libere AS
 SELECT stato_camere.data,
    camera.hotelid,
    count(*) AS libere
   FROM (stato_camere
   JOIN camera USING (cameraid))
  WHERE ((stato_camere.stato)::text = 'LIB'::text)
  GROUP BY stato_camere.data, camera.hotelid;


ALTER TABLE public.libere OWNER TO postgres;

--
-- TOC entry 178 (class 1259 OID 16588)
-- Name: nondisponibili; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW nondisponibili AS
 SELECT stato_camere.data,
    camera.hotelid,
    count(*) AS nd
   FROM (stato_camere
   JOIN camera USING (cameraid))
  WHERE ((stato_camere.stato)::text = 'ND'::text)
  GROUP BY stato_camere.data, camera.hotelid;


ALTER TABLE public.nondisponibili OWNER TO postgres;

--
-- TOC entry 177 (class 1259 OID 16584)
-- Name: occupate; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW occupate AS
 SELECT stato_camere.data,
    camera.hotelid,
    count(*) AS occupate
   FROM (stato_camere
   JOIN camera USING (cameraid))
  WHERE ((stato_camere.stato)::text = 'OCC'::text)
  GROUP BY stato_camere.data, camera.hotelid;


ALTER TABLE public.occupate OWNER TO postgres;

--
-- TOC entry 174 (class 1259 OID 16499)
-- Name: tempo; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE tempo (
    data date NOT NULL,
    mese character(20),
    anno integer,
    gsett character(10),
    festivo boolean
);


ALTER TABLE public.tempo OWNER TO postgres;

--
-- TOC entry 172 (class 1259 OID 16477)
-- Name: tipologia; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE tipologia (
    tipologiaid integer NOT NULL,
    nome character varying(20) NOT NULL,
    sat_tv integer NOT NULL,
    minibar integer NOT NULL,
    idromassaggio integer NOT NULL,
    salotto integer NOT NULL
);


ALTER TABLE public.tipologia OWNER TO postgres;

--
-- TOC entry 1986 (class 0 OID 16464)
-- Dependencies: 170
-- Data for Name: camera; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO camera (cameraid, hotelid, tipologiaid, prezzo) VALUES (1, 1, 1, 50);
INSERT INTO camera (cameraid, hotelid, tipologiaid, prezzo) VALUES (2, 1, 2, 70);
INSERT INTO camera (cameraid, hotelid, tipologiaid, prezzo) VALUES (3, 1, 3, 100);
INSERT INTO camera (cameraid, hotelid, tipologiaid, prezzo) VALUES (4, 2, 2, 100);
INSERT INTO camera (cameraid, hotelid, tipologiaid, prezzo) VALUES (5, 2, 3, 150);
INSERT INTO camera (cameraid, hotelid, tipologiaid, prezzo) VALUES (6, 3, 1, 100);
INSERT INTO camera (cameraid, hotelid, tipologiaid, prezzo) VALUES (7, 3, 3, 150);
INSERT INTO camera (cameraid, hotelid, tipologiaid, prezzo) VALUES (8, 3, 3, 170);
INSERT INTO camera (cameraid, hotelid, tipologiaid, prezzo) VALUES (9, 4, 1, 80);
INSERT INTO camera (cameraid, hotelid, tipologiaid, prezzo) VALUES (10, 4, 2, 130);
INSERT INTO camera (cameraid, hotelid, tipologiaid, prezzo) VALUES (11, 5, 1, 150);
INSERT INTO camera (cameraid, hotelid, tipologiaid, prezzo) VALUES (12, 5, 2, 270);
INSERT INTO camera (cameraid, hotelid, tipologiaid, prezzo) VALUES (13, 5, 3, 350);
INSERT INTO camera (cameraid, hotelid, tipologiaid, prezzo) VALUES (14, 6, 1, 70);
INSERT INTO camera (cameraid, hotelid, tipologiaid, prezzo) VALUES (15, 6, 2, 90);
INSERT INTO camera (cameraid, hotelid, tipologiaid, prezzo) VALUES (16, 6, 3, 180);
INSERT INTO camera (cameraid, hotelid, tipologiaid, prezzo) VALUES (17, 1, 1, 50);
INSERT INTO camera (cameraid, hotelid, tipologiaid, prezzo) VALUES (18, 1, 1, 50);


--
-- TOC entry 1991 (class 0 OID 16575)
-- Dependencies: 175
-- Data for Name: fatti; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (1, '2012-06-18', 1, 50);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (1, '2012-06-19', 1, 50);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (1, '2012-05-18', 1, 50);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (1, '2012-05-19', 1, 50);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (1, '2012-04-18', 1, 50);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (1, '2012-04-19', 1, 50);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (2, '2012-06-19', 1, 70);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (2, '2012-06-18', 1, 70);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (2, '2012-05-19', 1, 70);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (2, '2012-05-18', 1, 70);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (2, '2012-04-18', 1, 70);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (2, '2012-04-19', 1, 70);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (3, '2012-06-19', 1, 100);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (3, '2012-06-18', 1, 100);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (3, '2012-05-19', 1, 100);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (3, '2012-05-18', 1, 100);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (3, '2012-04-18', 1, 100);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (3, '2012-04-19', 1, 100);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (4, '2012-06-19', 2, 100);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (4, '2012-06-18', 2, 100);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (4, '2012-05-19', 2, 100);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (4, '2012-05-18', 2, 100);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (4, '2012-04-18', 2, 100);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (4, '2012-04-19', 2, 100);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (5, '2012-06-19', 2, 150);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (5, '2012-06-18', 2, 150);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (5, '2012-04-19', 2, 150);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (5, '2012-04-18', 2, 150);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (5, '2012-05-18', 2, 150);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (5, '2012-05-19', 2, 150);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (6, '2012-06-19', 3, 100);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (6, '2012-06-18', 3, 100);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (6, '2012-05-19', 3, 100);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (6, '2012-05-18', 3, 100);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (6, '2012-04-18', 3, 100);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (6, '2012-04-19', 3, 100);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (7, '2012-06-19', 3, 150);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (7, '2012-06-18', 3, 150);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (7, '2012-05-18', 3, 150);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (7, '2012-05-19', 3, 150);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (7, '2012-04-18', 3, 150);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (7, '2012-04-19', 3, 150);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (8, '2012-06-19', 3, 170);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (8, '2012-06-18', 3, 170);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (8, '2012-05-18', 3, 170);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (8, '2012-05-19', 3, 170);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (8, '2012-04-18', 3, 170);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (8, '2012-04-19', 3, 170);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (9, '2012-06-19', 4, 80);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (9, '2012-06-18', 4, 80);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (9, '2012-05-19', 4, 80);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (9, '2012-05-18', 4, 80);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (9, '2012-04-18', 4, 80);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (9, '2012-04-19', 4, 80);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (10, '2012-06-19', 4, 130);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (10, '2012-06-18', 4, 130);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (10, '2012-05-19', 4, 130);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (10, '2012-05-18', 4, 130);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (10, '2012-04-18', 4, 130);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (10, '2012-04-19', 4, 130);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (11, '2012-06-19', 5, 150);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (11, '2012-06-18', 5, 150);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (11, '2012-04-18', 5, 150);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (11, '2012-04-19', 5, 150);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (11, '2012-05-18', 5, 150);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (11, '2012-05-19', 5, 150);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (12, '2012-06-19', 5, 270);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (12, '2012-06-18', 5, 270);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (12, '2012-05-19', 5, 270);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (12, '2012-05-18', 5, 270);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (12, '2012-04-18', 5, 270);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (12, '2012-04-19', 5, 270);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (13, '2012-06-19', 5, 350);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (13, '2012-06-18', 5, 350);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (13, '2012-05-19', 5, 350);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (13, '2012-05-18', 5, 350);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (13, '2012-04-18', 5, 350);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (13, '2012-04-19', 5, 350);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (14, '2012-06-19', 6, 70);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (14, '2012-06-18', 6, 70);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (14, '2012-04-18', 6, 70);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (14, '2012-04-19', 6, 70);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (14, '2012-05-18', 6, 70);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (14, '2012-05-19', 6, 70);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (15, '2012-06-19', 6, 90);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (15, '2012-06-18', 6, 90);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (15, '2012-05-19', 6, 90);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (15, '2012-05-18', 6, 90);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (15, '2012-04-18', 6, 90);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (15, '2012-04-19', 6, 90);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (16, '2012-06-19', 6, 180);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (16, '2012-06-18', 6, 180);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (16, '2012-05-19', 6, 180);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (16, '2012-05-18', 6, 180);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (16, '2012-04-18', 6, 180);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (16, '2012-04-19', 6, 180);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (17, '2012-04-19', 1, 50);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (17, '2012-06-19', 1, 50);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (17, '2012-05-19', 1, 50);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (17, '2012-06-18', 1, 50);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (17, '2012-05-18', 1, 50);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (17, '2012-04-18', 1, 50);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (18, '2012-04-19', 1, 50);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (18, '2012-06-19', 1, 50);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (18, '2012-05-19', 1, 50);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (18, '2012-06-18', 1, 50);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (18, '2012-05-18', 1, 50);
INSERT INTO fatti (cameraid, data, hotelid, prezzo) VALUES (18, '2012-04-18', 1, 50);


--
-- TOC entry 1992 (class 0 OID 16613)
-- Dependencies: 179
-- Data for Name: fatti2; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO fatti2 (hotelid, data, libere, occupate, nd) VALUES (1, '2012-04-19', 2, 2, 1);
INSERT INTO fatti2 (hotelid, data, libere, occupate, nd) VALUES (1, '2012-05-19', 1, 3, 1);
INSERT INTO fatti2 (hotelid, data, libere, occupate, nd) VALUES (1, '2012-06-18', 2, 2, 1);
INSERT INTO fatti2 (hotelid, data, libere, occupate, nd) VALUES (1, '2012-06-19', 2, 2, 1);
INSERT INTO fatti2 (hotelid, data, libere, occupate, nd) VALUES (1, '2012-05-18', 0, 4, 1);
INSERT INTO fatti2 (hotelid, data, libere, occupate, nd) VALUES (3, '2012-05-18', 0, 1, 2);
INSERT INTO fatti2 (hotelid, data, libere, occupate, nd) VALUES (3, '2012-05-19', 0, 2, 1);
INSERT INTO fatti2 (hotelid, data, libere, occupate, nd) VALUES (4, '2012-06-19', 0, 1, 1);
INSERT INTO fatti2 (hotelid, data, libere, occupate, nd) VALUES (2, '2012-04-19', 1, 0, 1);
INSERT INTO fatti2 (hotelid, data, libere, occupate, nd) VALUES (2, '2012-05-19', 1, 0, 1);
INSERT INTO fatti2 (hotelid, data, libere, occupate, nd) VALUES (6, '2012-05-19', 2, 0, 1);
INSERT INTO fatti2 (hotelid, data, libere, occupate, nd) VALUES (1, '2012-04-18', 1, 4, 0);
INSERT INTO fatti2 (hotelid, data, libere, occupate, nd) VALUES (2, '2012-04-18', 1, 1, 0);
INSERT INTO fatti2 (hotelid, data, libere, occupate, nd) VALUES (3, '2012-04-18', 2, 1, 0);
INSERT INTO fatti2 (hotelid, data, libere, occupate, nd) VALUES (3, '2012-04-19', 2, 1, 0);
INSERT INTO fatti2 (hotelid, data, libere, occupate, nd) VALUES (3, '2012-06-18', 1, 2, 0);
INSERT INTO fatti2 (hotelid, data, libere, occupate, nd) VALUES (3, '2012-06-19', 1, 2, 0);
INSERT INTO fatti2 (hotelid, data, libere, occupate, nd) VALUES (4, '2012-04-19', 1, 1, 0);
INSERT INTO fatti2 (hotelid, data, libere, occupate, nd) VALUES (4, '2012-05-18', 1, 1, 0);
INSERT INTO fatti2 (hotelid, data, libere, occupate, nd) VALUES (4, '2012-05-19', 1, 1, 0);
INSERT INTO fatti2 (hotelid, data, libere, occupate, nd) VALUES (5, '2012-04-18', 1, 2, 0);
INSERT INTO fatti2 (hotelid, data, libere, occupate, nd) VALUES (5, '2012-04-19', 2, 1, 0);
INSERT INTO fatti2 (hotelid, data, libere, occupate, nd) VALUES (5, '2012-05-19', 1, 2, 0);
INSERT INTO fatti2 (hotelid, data, libere, occupate, nd) VALUES (5, '2012-06-19', 1, 2, 0);
INSERT INTO fatti2 (hotelid, data, libere, occupate, nd) VALUES (6, '2012-04-18', 1, 2, 0);
INSERT INTO fatti2 (hotelid, data, libere, occupate, nd) VALUES (6, '2012-04-19', 2, 1, 0);
INSERT INTO fatti2 (hotelid, data, libere, occupate, nd) VALUES (6, '2012-06-19', 2, 1, 0);
INSERT INTO fatti2 (hotelid, data, libere, occupate, nd) VALUES (2, '2012-06-18', 0, 2, 0);
INSERT INTO fatti2 (hotelid, data, libere, occupate, nd) VALUES (2, '2012-06-19', 0, 2, 0);
INSERT INTO fatti2 (hotelid, data, libere, occupate, nd) VALUES (4, '2012-04-18', 0, 2, 0);
INSERT INTO fatti2 (hotelid, data, libere, occupate, nd) VALUES (5, '2012-05-18', 0, 3, 0);
INSERT INTO fatti2 (hotelid, data, libere, occupate, nd) VALUES (5, '2012-06-18', 0, 3, 0);
INSERT INTO fatti2 (hotelid, data, libere, occupate, nd) VALUES (6, '2012-05-18', 0, 3, 0);
INSERT INTO fatti2 (hotelid, data, libere, occupate, nd) VALUES (6, '2012-06-18', 0, 3, 0);
INSERT INTO fatti2 (hotelid, data, libere, occupate, nd) VALUES (2, '2012-05-18', 2, 0, 0);
INSERT INTO fatti2 (hotelid, data, libere, occupate, nd) VALUES (4, '2012-06-18', 2, 0, 0);


--
-- TOC entry 1987 (class 0 OID 16469)
-- Dependencies: 171
-- Data for Name: hotel; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO hotel (hotelid, nome, stelle, "città", prov, regione) VALUES (1, 'primavera', 2, 'perugia', 'PG', 'umbria');
INSERT INTO hotel (hotelid, nome, stelle, "città", prov, regione) VALUES (2, 'brufani', 4, 'perugia', 'PG', 'umbria');
INSERT INTO hotel (hotelid, nome, stelle, "città", prov, regione) VALUES (3, 'italia', 3, 'foligno', 'PG', 'umbria');
INSERT INTO hotel (hotelid, nome, stelle, "città", prov, regione) VALUES (4, 'melody', 4, 'siena', 'SI', 'toscana');
INSERT INTO hotel (hotelid, nome, stelle, "città", prov, regione) VALUES (5, 'signoria', 3, 'firenze', 'FI', 'toscana');
INSERT INTO hotel (hotelid, nome, stelle, "città", prov, regione) VALUES (6, 'belvedere', 4, 'san gimignano', 'SI', 'toscana');


--
-- TOC entry 1989 (class 0 OID 16494)
-- Dependencies: 173
-- Data for Name: stato_camere; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO stato_camere (cameraid, data, stato) VALUES (1, '2012-04-19', 'LIB');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (1, '2012-04-18', 'LIB');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (2, '2012-04-19', 'ND');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (2, '2012-04-18', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (3, '2012-04-19', 'LIB');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (3, '2012-04-18', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (4, '2012-04-19', 'LIB');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (4, '2012-04-18', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (5, '2012-05-19', 'LIB');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (5, '2012-05-18', 'LIB');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (1, '2012-05-19', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (1, '2012-05-18', 'ND');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (1, '2012-06-19', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (1, '2012-06-18', 'LIB');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (6, '2012-04-19', 'LIB');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (6, '2012-04-18', 'LIB');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (7, '2012-04-19', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (7, '2012-04-18', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (7, '2012-05-19', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (7, '2012-05-18', 'ND');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (8, '2012-04-19', 'LIB');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (8, '2012-04-18', 'LIB');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (8, '2012-05-19', 'ND');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (8, '2012-05-18', 'ND');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (9, '2012-04-19', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (9, '2012-04-18', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (10, '2012-04-19', 'LIB');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (10, '2012-04-18', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (11, '2012-05-19', 'LIB');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (11, '2012-05-18', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (11, '2012-04-19', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (11, '2012-04-18', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (12, '2012-04-19', 'LIB');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (12, '2012-04-18', 'LIB');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (13, '2012-04-19', 'LIB');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (13, '2012-04-18', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (14, '2012-05-19', 'LIB');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (14, '2012-05-18', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (14, '2012-04-19', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (14, '2012-04-18', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (15, '2012-04-19', 'LIB');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (15, '2012-04-18', 'LIB');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (16, '2012-04-19', 'LIB');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (16, '2012-04-18', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (17, '2012-04-18', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (18, '2012-04-18', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (17, '2012-05-18', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (18, '2012-05-18', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (17, '2012-06-18', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (18, '2012-06-18', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (2, '2012-05-18', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (2, '2012-05-19', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (2, '2012-06-18', 'ND');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (2, '2012-06-19', 'LIB');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (3, '2012-05-18', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (3, '2012-05-19', 'ND');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (3, '2012-06-18', 'LIB');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (3, '2012-06-19', 'LIB');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (4, '2012-05-18', 'LIB');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (4, '2012-05-19', 'ND');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (4, '2012-06-18', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (4, '2012-06-19', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (5, '2012-04-18', 'LIB');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (5, '2012-04-19', 'ND');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (5, '2012-06-18', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (5, '2012-06-19', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (6, '2012-05-18', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (6, '2012-05-19', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (6, '2012-06-18', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (6, '2012-06-19', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (7, '2012-06-18', 'LIB');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (7, '2012-06-19', 'LIB');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (8, '2012-06-18', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (8, '2012-06-19', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (9, '2012-05-18', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (9, '2012-05-19', 'LIB');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (9, '2012-06-18', 'LIB');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (9, '2012-06-19', 'ND');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (10, '2012-05-18', 'LIB');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (10, '2012-05-19', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (10, '2012-06-18', 'LIB');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (10, '2012-06-19', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (12, '2012-05-18', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (12, '2012-05-19', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (12, '2012-06-18', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (12, '2012-06-19', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (13, '2012-05-18', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (13, '2012-05-19', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (13, '2012-06-18', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (13, '2012-06-19', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (14, '2012-06-18', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (14, '2012-06-19', 'LIB');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (15, '2012-05-18', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (15, '2012-05-19', 'LIB');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (15, '2012-06-18', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (15, '2012-06-19', 'LIB');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (11, '2012-06-18', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (11, '2012-06-19', 'LIB');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (16, '2012-05-18', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (16, '2012-05-19', 'ND');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (16, '2012-06-18', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (16, '2012-06-19', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (17, '2012-05-19', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (17, '2012-06-19', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (17, '2012-04-19', 'OCC');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (18, '2012-05-19', 'LIB');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (18, '2012-06-19', 'ND');
INSERT INTO stato_camere (cameraid, data, stato) VALUES (18, '2012-04-19', 'OCC');


--
-- TOC entry 1990 (class 0 OID 16499)
-- Dependencies: 174
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
-- TOC entry 1988 (class 0 OID 16477)
-- Dependencies: 172
-- Data for Name: tipologia; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO tipologia (tipologiaid, nome, sat_tv, minibar, idromassaggio, salotto) VALUES (1, 'basic', 1, 1, 0, 0);
INSERT INTO tipologia (tipologiaid, nome, sat_tv, minibar, idromassaggio, salotto) VALUES (2, 'comfort', 1, 1, 1, 0);
INSERT INTO tipologia (tipologiaid, nome, sat_tv, minibar, idromassaggio, salotto) VALUES (3, 'luxury', 1, 1, 1, 1);


--
-- TOC entry 1999 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2014-04-04 10:37:48

--
-- PostgreSQL database dump complete
--

--QUERY
--Selezionare i ricavi mensili del 2012 per ogni tipologia di camera, il ricavo totale per ogni tipologia (indipendentemente dal mese) e il totale mensile dei ricavi (indip. dalla tipologia):
SELECT mese, tipologiaid, SUM(prezzo) FROM fatti NATURAL JOIN tempo NATURAL JOIN camera NATURAL JOIN stato_camere WHERE anno=2012 AND stato='OCC' GROUP BY CUBE(mese, tipologiaid);
--Selezionare i ricavi mensili del 2012 per ogni hotel, tipologia di camera e giorno della settimana in modo tale da completare il cubo corrispondente a queste tre dimensioni e tutti i suoi possibili cuboidi:
SELECT mese, hotelid, tipologiaid, gsett, SUM(prezzo) FROM fatti NATURAL JOIN tempo NATURAL JOIN camera NATURAL JOIN stato_camere WHERE anno=2012 AND stato='OCC' GROUP BY CUBE(mese, hotelid, tipologiaid, gsett);
--Selezionare il numero di camere libere, occupate e non disponibili per ogni hotel. Associare la funzione RANK() ad ogni albergo rispetto al rapporto camere occupate/camere totali (posizione 1 per il rapporto più alto):
SELECT hotelid, SUM(libere) AS libere, SUM(occupate) AS occupate, SUM(nd) AS non_disponibili, rank() OVER (ORDER BY SUM(occupate)/(SUM(libere)+SUM(occupate)+SUM(nd)) DESC) FROM fatti2 GROUP BY hotelid;
--Per ogni mese nel 2012, selezionare il numero totale di camere non disponibili. Associare la funzione RANK() ad ogni mese rispetto a tale numero (posizione 1 per il numero più alto):
SELECT mese, SUM(nd) AS non_disponibili, rank() OVER(ORDER BY SUM(nd) DESC) FROM fatti2 NATURAL JOIN tempo WHERE anno=2012 GROUP BY mese;
--Per ogni hotel, calcolare il ricavato totale giornaliero e medio rispetto agli ultimi tre giorni:
SELECT hotelid, data, sum(prezzo), AVG(sum(prezzo)) over (PARTITION BY hotelid ORDER BY data rows 3 preceding) FROM fatti GROUP BY hotelid, data;
