--
-- Perl Weekly Challenge 333
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-333>
--

CREATE SCHEMA IF NOT EXISTS pwc333;

CREATE OR REPLACE FUNCTION
pwc333.task2_plpgsql( n int[] )
RETURNS SETOF int
AS $CODE$
DECLARE
	v int;
	l int;
BEGIN

	l := array_length( n, 1 );

	FOREACH v IN ARRAY n LOOP
		IF l = 0 THEN
		   RETURN;
		END IF;


		RETURN NEXT v;
		l := l - 1;

		IF l = 0 THEN
		   RETURN;
		END IF;

		IF v = 0 THEN
		   RETURN NEXT v;
		   l := l - 1;
		END IF;
	END LOOP;

	RETURN;
END
$CODE$
LANGUAGE plpgsql;
