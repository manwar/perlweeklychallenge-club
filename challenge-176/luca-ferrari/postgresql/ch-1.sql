-- Perl Weekly Challenge 176
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc176;

CREATE OR REPLACE FUNCTION
pwc176.task1_plpgsql()
RETURNS BIGINT
AS $CODE$
DECLARE
        i int;
        m int;
        v int;
        c int;
BEGIN
<<main_loop>>
     FOR i IN 1 .. 999999 LOOP
         FOR m IN 2 .. 6 LOOP
             v := m * i;
             c := 0;

             SELECT count( vv )
             INTO c
             FROM regexp_split_to_table( v::text, '' ) vv
             WHERE vv NOT IN ( SELECT * FROM regexp_split_to_table( i::text, '') );

             CONTINUE main_loop WHEN c <> 0;
         END LOOP;

         -- if here, ok!
         RETURN i;
     END LOOP;
END
$CODE$
LANGUAGE plpgsql;
