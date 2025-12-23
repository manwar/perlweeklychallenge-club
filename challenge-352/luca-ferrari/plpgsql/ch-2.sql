--
-- Perl Weekly Challenge 352
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-352>
--

CREATE SCHEMA IF NOT EXISTS pwc352;

CREATE OR REPLACE FUNCTION
pwc352.task2_plpgsql( bits bit[] )
RETURNS SETOF text
AS $CODE$
DECLARE
	c int;
BEGIN

	FOR i IN 1 .. array_length( bits, 1 ) LOOP
	    c := cast( '0b' || array_to_string( bits[ 1 : i ], '' ) as int );
	    IF mod( c, 5 ) = 0 THEN
	       RETURN NEXT array_to_string( bits[ 1 : i ], '' );
	    END IF;
	END LOOP;

	RETURN;
END
$CODE$
LANGUAGE plpgsql;
