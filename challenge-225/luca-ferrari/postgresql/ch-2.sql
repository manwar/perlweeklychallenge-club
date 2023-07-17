--
-- Perl Weekly Challenge 225
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-225/>
--

CREATE SCHEMA IF NOT EXISTS pwc225;

CREATE OR REPLACE FUNCTION
pwc225.task2_plpgsql( numbers int[] )
RETURNS SETOF INT
AS $CODE$
DECLARE
	current_value int := 0;
	current_sum int := 0;

	current_index int := 0;
	current_sub_index int := 0;
	a_left int[];
	a_right int[];
BEGIN

	a_left := array_append( a_left, 0 );
	current_index := 0;
	FOR current_index IN 1 .. array_length( numbers, 1 ) - 1 LOOP
	    current_sum := 0;
	    FOR current_sub_index IN 1 .. current_index LOOP
	    	current_sum := current_sum + numbers[ current_sub_index ];
	    END LOOP;
	    a_left := array_append( a_left, current_sum );
	END LOOP;


	current_index := 0;
	FOR current_index IN 2 .. array_length( numbers, 1 )  LOOP
	    current_sum := 0;
	    FOR current_sub_index IN current_index .. array_length( numbers, 1 ) LOOP
	    	current_sum := current_sum + numbers[ current_sub_index ];
	    END LOOP;
	    a_right := array_append( a_right, current_sum );
	END LOOP;

        a_right := array_append( a_right, 0 );

	FOR current_index IN 1 .. array_length( a_left, 1 ) LOOP
	    current_value := a_left[ current_index ] - a_right[ current_index ];
	    IF current_value > 0 THEN
	       RETURN NEXT current_value;
	    ELSE
	       RETURN NEXT ( current_value * -1 );
	    END IF;
	END LOOP;

RETURN;

END
$CODE$
LANGUAGE plpgsql;
