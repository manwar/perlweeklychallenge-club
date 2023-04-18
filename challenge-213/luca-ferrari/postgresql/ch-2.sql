--
-- Perl Weekly Challenge 213
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-213/>
--

CREATE SCHEMA IF NOT EXISTS pwc213;

/*
CREATE OR REPLACE FUNCTION
pwc213.task2_plpgsql( s int, d int, routes int[] )
RETURNS SETOF int
AS $CODE$
   SELECT pwc213.task2_plperl( s, d, routes );
$CODE$
LANGUAGE sql;
*/

CREATE OR REPLACE FUNCTION
pwc213.task2_plpgsql( s int, d int, routes int[] )
RETURNS SETOF int
AS $CODE$
DECLARE
	slice_size int := 3;
	current_route_index int;
	current_route int[];
	next_route_index int;
	next_node int;
	need_loop boolean;
	node int;
	path int[];
BEGIN
	need_loop := true;
	current_route_index := 1;
<<rescan>>
	WHILE need_loop LOOP
		FOREACH node IN ARRAY routes[ current_route_index : current_route_index ] LOOP
  		        RETURN NEXT node;
			IF node = d THEN
			   EXIT;
			END IF;

			need_loop := false;
			FOR next_route_index IN current_route_index + 1 .. array_length( routes, 1 ) LOOP
			    FOREACH next_node IN ARRAY routes[ next_route_index : next_route_index ] LOOP
			    	    IF next_node = node THEN
				       current_route_index := next_route_index;
				       need_loop := true;
				       CONTINUE rescan;
				    END IF;
			    END LOOP;
		    	END LOOP;
		END LOOP;
	END LOOP;

	IF node <> d THEN
	   RAISE EXCEPTION 'Cannot find the path!';
	END IF;

	return;
END
$CODE$
LANGUAGE plpgsql;
