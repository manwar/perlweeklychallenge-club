--
-- Perl Weekly Challenge 323
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-323>
--

CREATE SCHEMA IF NOT EXISTS pwc323;

CREATE OR REPLACE FUNCTION
pwc323.task2_plpgsql( income int, taxes int[] )
RETURNS float
AS $CODE$
DECLARE
	v float := 0;
	previous int := 0;
	i int;
	up_to int;
	pct float;
BEGIN

	FOR i IN 1 .. array_length( taxes, 1 ) LOOP
	    IF mod( i, 2 ) = 0 THEN
	       CONTINUE;
	    END IF;

	    pct := taxes[ i + 1 ];
	    up_to := taxes[ i ];

	    IF previous > income THEN
	       CONTINUE;
	    END IF;

	    IF up_to < income THEN
	       v := v + ( up_to - previous ) * pct / 100;
	    ELSE
	      v := v + ( income - previous ) * pct / 100;
	    END IF;

            previous := up_to;

	END LOOP;

	RETURN v;
END
$CODE$
LANGUAGE plpgsql;
