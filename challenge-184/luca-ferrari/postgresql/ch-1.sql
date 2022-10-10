-- Perl Weekly Challenge 184
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc184;


CREATE OR REPLACE FUNCTION
pwc184.task1_plpgsql( strings text[] )
RETURNS SETOF text
AS $CODE$
DECLARE
        current_string text;
        c int := 0;
        pref text;
BEGIN
     FOREACH current_string IN ARRAY strings LOOP
       IF c < 10 THEN
          pref := '0' || c;
       ELSE
         pref := c::text;
      END IF;
       RETURN NEXT regexp_replace( current_string,
                                   '^[a-z]{2}',
                                   pref );
       c := c + 1;
     END LOOP;
     RETURN;
END


$CODE$
LANGUAGE plpgsql;
