CREATE OR REPLACE FUNCTION
pwc277.task2_plpgsql( nums int[] )
RETURNS int
AS $CODE$
DECLARE
    strong_counter int := 0;
    current int := 0;
BEGIN

    FOR i IN 1 .. array_length( nums, 1 ) - 1 LOOP
        FOR j in ( i + 1 ) .. array_length( nums, 1 ) LOOP
        	SELECT min( x )
    		INTO current
    		FROM unnest( array[ nums[ i ], nums[ j ] ] ) x;

        	IF current > abs( nums[ i ] - nums[ j ] ) AND nums[ i ] <> nums[ j ] THEN
    			strong_counter := strong_counter + 1;
    	    END IF;
        END LOOP;
    END LOOP;

    RETURN strong_counter;

END
$CODE$
LANGUAGE plpgsql;


