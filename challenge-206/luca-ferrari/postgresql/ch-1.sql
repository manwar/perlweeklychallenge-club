--
-- Perl Weekly Challenge 206
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-206/>
--

CREATE SCHEMA IF NOT EXISTS pwc206;

CREATE OR REPLACE FUNCTION
pwc206.task1_plpgsql( t text[] )
RETURNS time
AS $CODE$

DECLARE
	m time;
	t1 text;
	t2 text;
BEGIN

	FOREACH t1 IN ARRAY t LOOP
		FOREACH t2 IN ARRAY t LOOP
			IF t1 = t2 THEN
			   CONTINUE;
			END IF;

			IF m IS NULL OR ( t2::time - t1::time ) < m THEN
			   m := ( t2::time - t1::time );
			END IF;

		END LOOP;
	END LOOP;

	RETURN m;
END
$CODE$
LANGUAGE plpgsql;
