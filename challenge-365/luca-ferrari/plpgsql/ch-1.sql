--
-- Perl Weekly Challenge 365
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-365>
--

CREATE SCHEMA IF NOT EXISTS pwc365;

CREATE OR REPLACE FUNCTION
pwc365.task1_plpgsql( s text, b int )
RETURNS int
AS $CODE$
DECLARE
	current_sum int := 0;
	n int;
	c char;
	final_sum int := 0;
BEGIN

	FOR c IN SELECT v FROM regexp_split_to_table( s, '' ) v LOOP
	    final_sum := final_sum + ascii( c ) - ascii( 'a' ) + 1;
	END LOOP;


	WHILE b > 0 LOOP
	      current_sum := 0;
	      FOR n IN SELECT v::int FROM regexp_split_to_table( final_sum::text, '' ) v LOOP
	      	  current_sum := current_sum + n;
	      END LOOP;
	      b := b - 1;
	      final_sum := current_sum;
	END LOOP;

	RETURN current_sum;
END
$CODE$
LANGUAGE plpgsql;
