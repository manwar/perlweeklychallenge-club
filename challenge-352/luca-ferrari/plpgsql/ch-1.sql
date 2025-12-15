--
-- Perl Weekly Challenge 352
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-352>
--

CREATE SCHEMA IF NOT EXISTS pwc352;

CREATE OR REPLACE FUNCTION
pwc352.task1_plpgsql( strings text[] )
RETURNS SETOF text
AS $CODE$
DECLARE
	counter int;
BEGIN
	counter := 0;

	FOR i IN 1 .. array_length( strings, 1 ) LOOP
	    SELECT count( v )
	    INTO   counter
	    FROM   unnest( strings[ i + 1 : array_length( strings, 1 ) ] ) v
	    WHERE  v like '%' || strings[ i ] || '%'
	    ;


	    IF counter > 0 THEN
	       RETURN NEXT strings[ i ];
	    END IF;

	END LOOP;

	RETURN;
END
$CODE$
LANGUAGE plpgsql;
