-- Perl Weekly Challenge 195
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc195;

CREATE OR REPLACE FUNCTION
pwc195.task1_plpgsql( n int )
RETURNS int
AS $CODE$
DECLARE
	i int;
	freq int;
	counter int := 0;
BEGIN
	FOR i IN 1 .. n LOOP
	    SELECT count(*)
	    INTO   freq
	    FROM regexp_split_to_table( i::text, '' ) as n(d)
	    GROUP BY d
	    ORDER BY 1 DESC;

	    IF freq = 1 THEN
	       counter := counter + 1;
	    END IF;

	END LOOP;

	RETURN counter;
END
$CODE$
LANGUAGE plpgsql;
