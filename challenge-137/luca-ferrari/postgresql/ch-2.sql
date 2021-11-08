/*
testdb=> select * from f_lychrel( 59, true );
INFO:  Found 1111 after 3 iterations
f_lychrel
-----------
0
*/
CREATE OR REPLACE FUNCTION
f_lychrel( n int, verb boolean default false )
RETURNS smallint
AS $CODE$
DECLARE
        result    bigint := n;
        iteration int    := 0;
BEGIN
        IF n < 10 OR n > 10000 THEN
           RAISE 'n is out of bounds!';
        END IF;

        WHILE result < 10000000 AND iteration < 500 LOOP
              iteration = iteration + 1;
              result    = result + reverse( result::text )::int;
              IF result = reverse( result::text )::int THEN
                 IF verb THEN
                    RAISE INFO 'Found % after % iterations', result, iteration;
                 END IF;

                 RETURN 0;
             END IF;

        END LOOP;

        RETURN 1;
END
$CODE$
LANGUAGE plpgsql;
