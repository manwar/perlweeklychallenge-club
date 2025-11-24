--
-- Perl Weekly Challenge 349
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-349>
--

CREATE SCHEMA IF NOT EXISTS pwc349;

CREATE OR REPLACE FUNCTION
pwc349.task1_plpgsql( s text )
RETURNS int
AS $CODE$
DECLARE
	c text;
	r int := 0;
	ss text;
	cc record;
BEGIN

	FOREACH c IN ARRAY regexp_split_to_array( s, '' ) LOOP
		FOR cc IN SELECT v FROM regexp_matches( s, c || '+' ) v LOOP
			IF length( cc.v::text ) - 2 > r THEN
			   r = length( cc.v::text ) - 2;
			END IF;
		END LOOP;
	END LOOP;

	RETURN r;

END
$CODE$
LANGUAGE plpgsql;
