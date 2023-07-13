--
-- Perl Weekly Challenge 225
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-225/>
--

CREATE SCHEMA IF NOT EXISTS pwc225;

CREATE OR REPLACE FUNCTION
pwc225.task1_plpgsql( sentences text[] )
RETURNS int
AS $CODE$
DECLARE
	current_sentence text;
	max_length int := 0;
	current_length int := 0;
BEGIN
	FOREACH current_sentence IN ARRAY sentences LOOP
		SELECT count(*)
		INTO current_length
		FROM regexp_split_to_table( current_sentence, ' ' );

		IF current_length > max_length THEN
		   max_length := current_length;
		END IF;
	END LOOP;

RETURN max_length;
END
$CODE$
LANGUAGE plpgsql;
