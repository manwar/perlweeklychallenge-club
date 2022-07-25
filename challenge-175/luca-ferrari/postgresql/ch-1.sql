-- Perl Weekly Challenge 175
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc175;

CREATE OR REPLACE FUNCTION
pwc175.task1_plpgsql( year int DEFAULT 2022 )
RETURNS SETOF DATE
AS $CODE$
DECLARE
        last_sunday date;
        d           date;

BEGIN

        FOR d IN SELECT sunday FROM
                               generate_series( to_date( year || '-01-01' ),
                                                to_date( year || '-12-31' ),
                                                '1 day'::interval ) sunday
                                               WHERE
                                               extract( dow from sunday ) = 0
                                               ORDER BY 1 ASC
                                               LOOP
           IF last_sunday IS NULL THEN
              last_sunday := d;
           END IF;

           IF extract( day from last_sunday ) < extract( day from d ) AND extract( month from last_sunday ) = extract( month from d ) THEN
            last_sunday := d;
            CONTINUE;
          END IF;

           IF extract( month from last_sunday ) <> extract( month from d ) THEN
              RETURN NEXT last_sunday;
              last_sunday := d;
           END IF;

       END LOOP;

       RETURN NEXT last_sunday;
END
$CODE$
LANGUAGE plpgsql;
