--
-- Perl Weekly Challenge 240
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-240/>
--

CREATE SCHEMA IF NOT EXISTS pwc240;

CREATE OR REPLACE FUNCTION
pwc240.task1_plpgsql( c text, s text[] )
RETURNS boolean
AS $CODE$
DECLARE
	check_letters text[];
	current_index int;
	current_letter text;
BEGIN
	check_letters := regexp_split_to_array( c, '' );

	IF array_length( check_letters, 1 ) <> array_length( s, 1 ) THEN
	   RETURN FALSE;
	END IF;

	FOR current_index IN 1 .. array_length( check_letters, 1 ) LOOP
	    current_letter := ( regexp_split_to_array( s[ current_index ], '' ) )[ 1 ];
	    IF lower( current_letter ) <> lower( check_letters[ current_index ] ) THEN
	       RETURN FALSE;
	    END IF;
	END LOOP;

	RETURN TRUE;
END
$CODE$
LANGUAGE plpgsql;
