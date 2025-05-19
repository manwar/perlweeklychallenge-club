--
-- Perl Weekly Challenge 322
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-322>
--

CREATE SCHEMA IF NOT EXISTS pwc322;

CREATE OR REPLACE FUNCTION
pwc322.task2_plpgsql( n int[] )
RETURNS SETOF int
AS $CODE$
DECLARE
   current int;
   r       int;
BEGIN

	FOR current IN SELECT x FROM unnest( n ) x LOOP
	    WITH sorting AS (
	    	 SELECT row_number() over ( order by y ) as sorted, y
		 FROM   unnest( n ) y
	    )
	    SELECT sorted
	    INTO r
	    FROM sorting
	    WHERE y = current;

	    RETURN NEXT r;

	END LOOP;

END
$CODE$
LANGUAGE plpgsql;
