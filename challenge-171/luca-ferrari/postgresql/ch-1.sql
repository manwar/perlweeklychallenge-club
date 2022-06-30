-- Perl Weekly Challenge 171
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc171;

CREATE OR REPLACE FUNCTION
pwc171.task1_plpgsql( l int DEFAULT 20 )
RETURNS SETOF INT
AS $CODE$
DECLARE
        s int := 0;
        i int;
        d int;
BEGIN
      FOR i IN  2 .. 99999  LOOP
          IF i % 2 = 0 THEN
             CONTINUE;
          END IF;
          s := 0;
          FOR d in  2 .. ( i / 2 )  LOOP
              IF i % d = 0 THEN
                 s := s + d;
              END IF;
          END LOOP;

          IF s > i THEN
             RETURN NEXT i;
             l := l - 1;

             IF l = 0 THEN
                RETURN;
             END IF;
          END IF;
    END LOOP;
RETURN;
END
$CODE$
LANGUAGE plpgsql;
