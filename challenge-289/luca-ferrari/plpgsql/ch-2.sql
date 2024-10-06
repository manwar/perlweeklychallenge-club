--
-- Perl Weekly Challenge 289
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-289>
--

CREATE SCHEMA IF NOT EXISTS pwc289;

CREATE OR REPLACE FUNCTION
pwc289.task2_plpgsql( words text[])
RETURNS SETOF text
AS $CODE$
DECLARE

	current_word text;
	first_index int;
	last_index int;
	new_word text;
BEGIN
	FOREACH current_word IN ARRAY words LOOP
		first_index := 1;
		last_index  := length( current_word );
		new_word := substring( current_word from first_index for 1 );

		WHILE NOT substring( current_word from last_index for 1 ) ~ '[a-z0-9A-Z]' LOOP
		      last_index := last_index - 1;
		END LOOP;


		WITH l AS ( SELECT v::text
			    FROM  regexp_split_to_table( substring( current_word from first_index + 1 for last_index - first_index - 1 ), '' ) v
   			    ORDER BY random() )
		SELECT string_agg( l.v, '' )
		INTO new_word
		FROM  l;


		RETURN NEXT substring( current_word from first_index for 1 )
		|| new_word
		|| substring( current_word from last_index  );
	END LOOP;

RETURN;
END
$CODE$
LANGUAGE plpgsql;
