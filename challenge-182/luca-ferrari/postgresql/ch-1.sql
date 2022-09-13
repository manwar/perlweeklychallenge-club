-- Perl Weekly Challenge 182
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc182;

CREATE OR REPLACE FUNCTION
pwc182.task1_plpgsql( n int[] )
RETURNS int
AS $CODE$
DECLARE
        i int;
        index int := -1;
        current_max int := 0;
        current_index int := -1;
BEGIN
        FOREACH i IN ARRAY n LOOP
                index := index + 1;

                IF i > current_max THEN
                   current_max   := i;
                   current_index := index;
                END IF;
        END LOOP;

        RETURN current_index;
END
$CODE$
LANGUAGE plpgsql;
