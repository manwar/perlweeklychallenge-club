-- Perl Weekly Challenge 194
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc194;

CREATE OR REPLACE FUNCTION
pwc194.task2_plpgsql( what text)
RETURNS int
AS $CODE$
DECLARE
	t text;
	current_max int;
	current_min int;
	current_count int;
BEGIN
	CREATE TEMPORARY TABLE IF NOT EXISTS counter ( l char, c int, PRIMARY KEY(l) );
	TRUNCATE counter;

	FOR t IN SELECT v FROM regexp_split_to_table( what, '' ) v LOOP
	    INSERT INTO counter AS cnt ( l, c )
	    VALUES ( t, 1 )
	    ON CONFLICT (l)
	    DO UPDATE SET c = cnt.c + 1;
	END LOOP;

	SELECT max(c), min(c)
	INTO current_max, current_min
	FROM counter;

	IF current_max - current_min <> 1 THEN
	   RETURN 0;
	END IF;

	SELECT count(*)
	INTO current_count
	FROM counter
	WHERE c = current_max;

	IF current_count <> 1 THEN
	   RETURN 0;
	END IF;

	RETURN 1;
END
$CODE$
LANGUAGE plpgsql;
