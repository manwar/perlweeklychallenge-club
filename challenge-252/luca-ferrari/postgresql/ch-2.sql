--
-- Perl Weekly Challenge 252
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-252/>
--

CREATE SCHEMA IF NOT EXISTS pwc252;

CREATE OR REPLACE FUNCTION
pwc252.task2_plpgsql( size int )
RETURNS SETOF int
AS $CODE$
DECLARE
	next_value int;
BEGIN

	IF size <= 3 THEN
	   RAISE 'Cannot work with a size less than 3!';
	END IF;

	IF mod( size, 2 ) = 0 THEN
	   FOR i IN 1 .. ( size / 2 ) LOOP
	       RETURN NEXT i;
	       RETURN NEXT (i * -1);
	   END LOOP;
	ELSE
	    FOR i IN 2 .. ( size - 1 ) / 2  LOOP
	       RETURN NEXT i;
	       RETURN NEXT (i * -1);
	   END LOOP;

	   next_value := ( size - 1 ) / 2  + 1;
	   RETURN NEXT next_value;
	   RETURN NEXT next_value + 1;
	   RETURN NEXT ( next_value + next_value + 1 ) * -1;
	END IF;
RETURN;
END
$CODE$
LANGUAGE plpgsql;
