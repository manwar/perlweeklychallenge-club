-- Perl Weekly Challenge 185
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc185;

CREATE OR REPLACE FUNCTION
pwc185.task1_plpgsql( mac_input text )
RETURNS text
AS $CODE$
DECLARE
        c int := 1;
        d char;
        mac_output text := '';
BEGIN
        mac_input := replace( mac_input, '.', '' );
        FOREACH d IN ARRAY regexp_split_to_array( mac_input, '' ) LOOP
                mac_output := mac_output || d;
                IF c % 2 = 0 THEN
                   mac_output := mac_output || ':';
                END IF;
                c := c + 1;
        END LOOP;

        RETURN mac_output;
END
$CODE$
LANGUAGE plpgsql;
