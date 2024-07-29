--
-- Perl Weekly Challenge 280
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-280>
--

CREATE SCHEMA IF NOT EXISTS pwc280;

CREATE OR REPLACE FUNCTION
pwc280.task1_plpgsql( s text )
RETURNS char
AS $CODE$
DECLARE
	needle char;
	counting int;
BEGIN

	FOR needle IN SELECT v::char FROM regexp_split_to_table( s, '' ) v LOOP
		counting := 0;
		SELECT count( * )
		INTO counting
		FROM regexp_split_to_table( s, '' ) v
		WHERE v = needle;

		IF counting > 1 THEN
		   RETURN needle;
		END IF;
	END LOOP;

	RETURN NULL;
END
$CODE$
LANGUAGE plpgsql;
