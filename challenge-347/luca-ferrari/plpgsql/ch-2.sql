--
-- Perl Weekly Challenge 347
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-347>
--

CREATE SCHEMA IF NOT EXISTS pwc347;

CREATE OR REPLACE FUNCTION
pwc347.task2_plpgsql( phone text )
RETURNS text
AS $CODE$
DECLARE
	x text;
	r text;
	i int;

	groups text[];
BEGIN

	i := 0;


	FOREACH x IN ARRAY regexp_split_to_array( phone, '' ) LOOP


		IF x = '-' OR x = ' ' THEN
		   CONTINUE;
		END IF;

		RAISE INFO 'x = %', x;
		IF r IS NULL THEN
		   r := x;
		ELSE
		   r := r || x;
	        END IF;

		i := i + 1;

		IF i = 3 THEN
		   groups := groups || r;
		   r := NULL;
		   i := 0;
		END IF;
	END LOOP;

	IF i <> 0 THEN
	   groups := groups || r;
	END IF;

	IF length( groups[ array_length( groups, 1 ) ] ) THEN
	   RETURN pwc347.task2_plperl( phone );
	END IF;


	RETURN array_to_string( groups, '-' );

END
$CODE$
LANGUAGE plpgsql;
