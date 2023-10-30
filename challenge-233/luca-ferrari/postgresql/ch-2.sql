--
-- Perl Weekly Challenge 233
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-233/>
--

CREATE SCHEMA IF NOT EXISTS pwc233;


CREATE OR REPLACE FUNCTION
pwc233.task2_plpgsql( nums int[] )
RETURNS SETOF int
AS $CODE$
DECLARE
	current_number int;
BEGIN
	CREATE TEMPORARY TABLE IF NOT EXISTS freqs( v int, f int DEFAULT 1, primary key ( v ) );
	TRUNCATE freqs;

	FOREACH current_number IN ARRAY nums LOOP
		INSERT INTO freqs( v )
		VALUES( current_number )
		ON CONFLICT ( v )
		DO UPDATE
		   SET f = ( SELECT f + 1
		       	     FROM freqs
			     WHERE v = EXCLUDED.v )
		;
	END LOOP;

	RETURN QUERY
	       SELECT v
	       FROM freqs
	       ORDER BY f DESC, v DESC;
END
$CODE$
LANGUAGE plpgsql;


/*
 * Another possible approach
 */
CREATE OR REPLACE FUNCTION
pwc233.task2_plpgsql( nums int[] )
RETURNS SETOF int
AS $CODE$
DECLARE
	current_number int;
	current_freq   int;
BEGIN
	CREATE TEMPORARY TABLE IF NOT EXISTS freqs( v int, f int DEFAULT 1, primary key ( v ) );
	TRUNCATE freqs;

	FOREACH current_number IN ARRAY nums LOOP
		SELECT f + 1
		INTO   current_freq
		FROM freqs
		WHERE v = current_number;

		IF NOT FOUND THEN
		   current_freq := 1;
		END IF;

		INSERT INTO freqs( v, f )
		VALUES( current_number, current_freq )
		ON CONFLICT ( v )
		DO UPDATE
		   SET f = current_freq
		;
	END LOOP;

	RETURN QUERY
	       SELECT v
	       FROM freqs
	       ORDER BY f DESC, v DESC;
END
$CODE$
LANGUAGE plpgsql;
