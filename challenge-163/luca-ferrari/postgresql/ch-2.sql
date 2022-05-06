-- Perl Weekly Challenge 163
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc163;


CREATE OR REPLACE FUNCTION
pwc163.task2_reduce( n int[] )
RETURNS int[]
AS $CODE$
DECLARE
        summy int;
        index int;
        res   int[];
BEGIN

        FOR index IN 2 .. array_length( n, 1 ) LOOP
            IF index = 2 THEN
               res := array_append( res, n[ index ] );
            ELSE
               res := array_append( res,  n[ index ] + res[ array_length( res, 1 ) ] );
            END IF;
        END LOOP;

        RETURN res;
END
$CODE$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION
pwc163.task2_plpgsql( n int[] )
RETURNS int
AS $CODE$
DECLARE
BEGIN
        WHILE array_length( n, 1 ) > 1 LOOP
              n := pwc163.task2_reduce( n );
        END LOOP;

        RETURN n[ 1 ];
END
$CODE$
LANGUAGE plpgsql;
