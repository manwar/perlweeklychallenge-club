--
-- Perl Weekly Challenge 227
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-227/>
--

CREATE SCHEMA IF NOT EXISTS pwc227;

CREATE OR REPLACE FUNCTION
pwc227.task1_plpgsql( y int)
RETURNS int
AS $CODE$
DECLARE
	fridays int := 0;
	m int;
BEGIN
	FOR m IN 1 .. 12 LOOP
	    IF extract( dow FROM make_date( y, m, 13 ) ) = 5 THEN
	       fridays := fridays + 1;
	    END IF;
	END LOOP;

	RETURN fridays;
END
$CODE$
LANGUAGE plpgsql;
