-- Perl Weekly Challenge 163
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc163;

CREATE OR REPLACE FUNCTION
pwc163.task1_plpgsql( n int[] )
RETURNS int
AS $CODE$
DECLARE
        summy int := 0;
        index int;
BEGIN
       FOR index IN 2 .. array_length( n, 1 )  LOOP
           summy := summy
                    + ( n[ index - 1 ]::bit(8)
                        &
                        n[ index ]::bit( 8 ) )::int;
       END LOOP;

       summy := summy
                + ( n[ 1 ]::bit(8)
                    &
                    n[ array_length( n, 1 ) ]::bit( 8 ) )::int;

      RETURN summy;
END
$CODE$
LANGUAGE plpgsql;
