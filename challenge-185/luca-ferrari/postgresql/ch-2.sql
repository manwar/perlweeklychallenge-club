-- Perl Weekly Challenge 185
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc185;

CREATE OR REPLACE FUNCTION
pwc185.task2_plpgsql( code text )
RETURNS text
AS $CODE$
DECLARE
        how_many int := 4;
        d char;
        code_out text := '';
BEGIN
        FOREACH d IN ARRAY regexp_split_to_array( code, '' ) LOOP
                IF how_many = 0 OR d !~ '\w'  THEN
                   code_out := code_out || d;
                   CONTINUE;
               ELSEIF how_many > 0 AND d ~ '\w' THEN
                    code_out := code_out || 'x';
                    how_many := how_many - 1;

               ELSE
                    code_out := code_out || d;
               END IF;
        END LOOP;

RETURN code_out;
END
$CODE$
LANGUAGE plpgsql;
