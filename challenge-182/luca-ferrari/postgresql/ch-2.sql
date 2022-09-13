-- Perl Weekly Challenge 182
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc182;

CREATE OR REPLACE FUNCTION
pwc182.task2_plpgsql( paths text[] )
RETURNS text
AS $CODE$
DECLARE
        p text;
        i int;
        pieces text[];
        ok boolean;
        found_pieces text;
        current_pieces text[];
BEGIN
        found_pieces := '';
        i := 1;
        pieces := regexp_split_to_array( paths[1], '/' );


        FOR i IN 1 .. array_length( pieces, 1 )  LOOP
          FOREACH p IN ARRAY paths LOOP
                  current_pieces := regexp_split_to_array( paths[i], '/' );
                  ok := true;
                  IF current_pieces[i] <> pieces[i] THEN
                     ok := false;
                  END IF;
          END LOOP;

          IF ok THEN
             found_pieces := found_pieces || '/' || pieces[i];
          END IF;

        END LOOP;
        RETURN found_pieces;
END
$CODE$
LANGUAGE plpgsql;
