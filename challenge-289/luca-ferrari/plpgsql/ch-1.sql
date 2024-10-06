--
-- Perl Weekly Challenge 289
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-289>
--

CREATE SCHEMA IF NOT EXISTS pwc289;

CREATE OR REPLACE FUNCTION
pwc289.task1_plpgsql( n int[] )
RETURNS int
AS $CODE$
DECLARE
	found_max int;
BEGIN
	IF array_length( n, 1 ) > 3 THEN
		WITH s AS (
			SELECT v, row_number()  OVER ( ORDER BY v DESC ) AS r
			FROM unnest( n ) v
			GROUP BY v
		        ORDER BY v DESC
		)
		SELECT v
		INTO found_max
		FROM s
		WHERE
		r = 3
		;
	ELSE
		SELECT MAX( v )
		INTO found_max
		FROM unnest( n ) v;
	END IF;

	RETURN found_max;

END
$CODE$
LANGUAGE plpgsql;
