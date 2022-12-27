-- Perl Weekly Challenge 197
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc197;

CREATE OR REPLACE FUNCTION
pwc197.task1_plpgsql( l int[] )
RETURNS int[]
AS $CODE$
DECLARE
   i int;
   v int[];
   zeros int := 0;
BEGIN
	FOREACH i IN ARRAY l LOOP
		IF i = 0 THEN
		   zeros := zeros + 1;
		   CONTINUE;
		END IF;

		v := v || i;
	END LOOP;

	WHILE zeros > 0 LOOP
	      v := v || 0;
	      zeros := zeros - 1;
	END LOOP;

	RETURN v;
END
$CODE$
LANGUAGE plpgsql;
