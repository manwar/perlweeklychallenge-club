--
-- Perl Weekly Challenge 203
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-203/>
--

CREATE SCHEMA IF NOT EXISTS pwc203;

CREATE OR REPLACE FUNCTION
pwc203.task1_plpgsql( l int[] )
RETURNS int
AS $CODE$
DECLARE
	a int;
	b int;
	c int;
	d int;
	total int := 0;
BEGIN
	FOR a IN  1 .. array_length( l, 1 )  LOOP
	    FOR b IN  a + 1 .. array_length( l, 1 )  LOOP
	    	FOR c IN  b + 1 .. array_length( l, 1 )  LOOP
		    FOR d IN  c + 1 .. array_length( l, 1 )  LOOP
		    	IF l[a] + l[b] + l[c] = l[d] THEN
			   total := total + 1;
			END IF;
		    END LOOP;
		END LOOP;
	    END LOOP;
	END LOOP;

	RETURN total;

END
$CODE$
LANGUAGE plpgsql;
