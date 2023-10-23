--
-- Perl Weekly Challenge 240
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-240/>
--

CREATE SCHEMA IF NOT EXISTS pwc240;

CREATE OR REPLACE FUNCTION
pwc240.task2_plpgsql( n int[] )
RETURNS SETOF INT
AS $CODE$
DECLARE
	current_index int;
	position  int;
BEGIN
	FOR current_index IN 1 .. array_length( n, 1 ) LOOP
	    position := n[ current_index ];
	    IF position = 0 THEN
	       position := 1;
	    END IF;
	    RETURN NEXT n[ position ];
	END LOOP;

	RETURN;
END
$CODE$
LANGUAGE plpgsql;
