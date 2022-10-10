-- Perl Weekly Challenge 184
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc184;

CREATE OR REPLACE FUNCTION
pwc184.task2_plpgsql( strings text[])
RETURNS TABLE (n text, l text)
AS $CODE$
DECLARE
        current_string text;
        current_thing text;
BEGIN
        n := null;
        l := null;
        FOREACH current_string IN ARRAY strings LOOP
                FOREACH current_thing IN ARRAY regexp_split_to_array( current_string, '' ) LOOP
                        -- since '\w' gets also numbers
                        -- the test is performed only if it is not
                        -- a number
                        IF current_thing ~ '\d' THEN
                           IF n IS NULL THEN
                              n := current_thing::text;
                           ELSE
                             n := n || ',' || current_thing;
                           END IF;
                        ELSEIF current_thing ~ '\w' THEN
                           IF l IS NULL THEN
                              l := current_thing::text;
                           ELSE
                             l := l || ',' || current_thing;
                           END IF;
                        END IF;
                END LOOP;
        END LOOP;

        RETURN NEXT;
        RETURN;
END
$CODE$
LANGUAGE plpgsql;
