--
-- Perl Weekly Challenge 235
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-235/>
--

CREATE SCHEMA IF NOT EXISTS pwc235;

CREATE OR REPLACE FUNCTION
pwc235.task1_plpgsql( nums int[] )
RETURNS boolean
AS $CODE$
DECLARE
	current_array int[];
	string_array  text;
	string_sorted text;
BEGIN

        SELECT string_agg( x::text, ',' )
	INTO string_array
	FROM ( SELECT unnest( nums ) y ORDER BY 1 ) x
	ORDER BY 1;


	FOR i IN 1 .. array_length( nums, 1 ) LOOP

	    current_array := '{}';

	    IF i <> 1 THEN
	       	current_array := current_array || nums[ 1 : ( i - 1 ) ];
	    END IF;

	    current_array := current_array || nums[ ( i + 1 ) : ];

	    SELECT string_agg( x::text, ',' )
	    INTO string_sorted
	    FROM ( SELECT y::text FROM unnest( current_array ) y ORDER BY 1 ) x
	    ;


	    SELECT string_agg( x::text, ',' )
	    INTO string_array
	    FROM ( SELECT y::text FROM unnest( current_array ) y ) x
	    ;

	    IF string_sorted = string_array THEN
	       RETURN true;
	    END IF;

	END LOOP;

	RETURN false;
END
$CODE$
LANGUAGE plpgsql;
