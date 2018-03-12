--funzioni

CREATE FUNCTION controllaData() RETURNS TRIGGER AS 
$BODY$
DECLARE
	anno_film integer;
BEGIN
	SELECT anno INTO anno_film FROM film WHERE id_film=NEW.id_film;
	IF EXTRACT('year' FROM NEW.giorno)<=anno_film THEN
		RAISE EXCEPTION $$Non si possono proiettare film prima della loro uscita!$$;
	ELSE RETURN NEW;
	END IF;
END;
$BODY$
LANGUAGE PLPGSQL;

CREATE FUNCTION controllaSeHaDiretto() RETURNS TRIGGER AS
$BODY$
DECLARE
	n integer;
BEGIN
	SELECT COUNT(id_film) INTO n FROM film WHERE id_regista=OLD.id_regista GROUP BY id_regista;
	IF n<=1 THEN
		RAISE EXCEPTION $$Un regista che non gira non e' un regista!$$;
	END IF;
END;
$BODY$
LANGUAGE PLPGSQL;

--trigger
CREATE TRIGGER coerenza_date BEFORE INSERT OR UPDATE ON proiezione FOR EACH ROW EXECUTE PROCEDURE controllaData();
CREATE TRIGGER regista_solo_se_dirige BEFORE DELETE ON film FOR EACH ROW EXECUTE PROCEDURE controllaSeHaDiretto();
