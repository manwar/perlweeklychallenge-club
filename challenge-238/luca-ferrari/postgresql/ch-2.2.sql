CREATE OR REPLACE FUNCTION pwc238.reduce( n int )
RETURNS int
AS $CODE$
DECLARE
	current_value int;
	step_counter  int;
	digit text;
	multiplication int;

BEGIN
	current_value := n;
	step_counter  := 0;

	WHILE current_value > 9 LOOP
	      multiplication := 1;
	      step_counter   := step_counter + 1;

	      FOREACH digit IN ARRAY regexp_split_to_array( current_value::text, '' ) LOOP
	      	      multiplication := multiplication * digit::int;
	      END LOOP;

	      current_value := multiplication;
	END LOOP;

	RETURN step_counter;
END
$CODE$
LANGUAGE plpgsql;



--
-- Function task2_plpgsql
-- Schema   pwc238
--
-- Description:
--
--
-- Return Type: SETOF INT
--
CREATE OR REPLACE FUNCTION
pwc238.task2_plpgsql( nums int[] )
RETURNS SETOF INT
AS $CODE$

SELECT v
FROM unnest( nums ) v
ORDER BY pwc238.reduce( v ), v;

$CODE$
LANGUAGE sql
VOLATILE
;
