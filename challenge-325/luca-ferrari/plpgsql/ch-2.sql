--
-- Perl Weekly Challenge 325
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-325>
--

CREATE SCHEMA IF NOT EXISTS pwc325;

CREATE OR REPLACE FUNCTION
pwc325.task2_plpgsql( prices int[] )
RETURNS SETOF int
AS $CODE$
DECLARE
	current_price int;
BEGIN
	FOR i IN 1 .. array_length( prices, 1 ) LOOP
	    SELECT prices[ i ] -
	    	   ( SELECT v
		     FROM unnest( prices[ i + 1 : array_length( prices, 1 ) - 1 ] ) v
		     WHERE v::int < prices[ i ]
		     LIMIT 1
		  )
           INTO current_price;

	   IF NOT FOUND THEN
	      RETURN NEXT prices[ i ];
	   ELSE
	     RETURN NEXT current_price;
	   END IF;
	END LOOP;

RETURN;
END
$CODE$
LANGUAGE plpgsql;
