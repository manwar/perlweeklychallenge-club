--
-- Perl Weekly Challenge 209
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-209/>
--

CREATE SCHEMA IF NOT EXISTS pwc209;

CREATE OR REPLACE FUNCTION
pwc209.task1_plpgsql( b text )
RETURNS int
AS $CODE$
DECLARE
BEGIN
	IF ( length( b ) % 2 = 0 AND b ~ '00$' ) OR ( length( b ) % 2 = 1 AND b ~ '0$' ) THEN
	   RETURN 1;
	ELSE
	  RETURN 0;
	END IF;

END
$CODE$
LANGUAGE plpgsql;
