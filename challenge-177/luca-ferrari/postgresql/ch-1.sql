-- Perl Weekly Challenge 177
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc177;

CREATE OR REPLACE FUNCTION
pwc177.task1_plpgsql( n int )
RETURNS BOOLEAN
AS $CODE$
DECLARE
        interim int := 0;
        col     int := 0;
BEGIN

        CREATE TEMPORARY TABLE
        t_check( r int, c int, v int )
        ON COMMIT DROP;

        INSERT INTO t_check( r, c, v )
      VALUES
      ( 0, 0, 0),
      ( 0, 1,  3),
      ( 0, 2,  1),
      ( 0, 3, 7),
      ( 0, 4, 5),
      ( 0, 5, 9),
      ( 0, 6, 8),
      ( 0, 7, 6),
      ( 0, 8, 4),
      ( 0, 9, 2),
      ( 1,0,  7),
      ( 1,1, 0),
      ( 1,2, 9),
      ( 1,3, 2),
      ( 1,4, 1),
      ( 1,5,  5),
      ( 1,6, 4),
      ( 1,7,  8),
      ( 1,8,  6),
      ( 1,9, 3),
      ( 2,0, 4),
      ( 2,1, 2),
      ( 2,2, 0),
      ( 2,3, 6),
      ( 2,4, 8),
      ( 2,5, 7),
      ( 2,6, 1),
      ( 2,7, 3),
      ( 2,8,  5),
      ( 2,9,  9),
      ( 3,0,  1),
      ( 3,1,  7),
      ( 3,2,   5),
      ( 3,3,  0),
      ( 3,4,  9),
      ( 3,5,  8),
      ( 3,6,  3),
      ( 3,7,  4),
      ( 3,8,   2),
      ( 3,9,  6),
      ( 4,0,  6),
      ( 4,1,  1),
      ( 4,2,  2),
      ( 4,3,  3),
      ( 4,4,  0),
      ( 4,5,  4),
      ( 4,6,  5),
      ( 4,7,  9),
      ( 4,8,  7),
      ( 4,9,  8),
      ( 5,0, 3),
      ( 5,1, 6),
      ( 5,2, 7),
      ( 5,3, 4),
      ( 5,4, 2),
      ( 5,5, 0),
      ( 5,6, 9),
      ( 5,7, 5),
      ( 5,8, 8),
      ( 5,9, 1) ,
      ( 6,0, 5),
      ( 6,1, 8),
      ( 6,2, 6),
      ( 6,3, 9),
      ( 6,4, 7),
      ( 6,5, 2),
      ( 6,6, 0),
      ( 6,7, 1),
      ( 6,8, 3),
      ( 6,9, 4) ,
      ( 7,0, 8),
      ( 7,1, 9),
      ( 7,2, 4),
      ( 7,3, 5),
      ( 7,4, 3),
      ( 7,5, 6),
      ( 7,6, 2),
      ( 7,7, 0),
      ( 7,8, 1),
      ( 7,9, 7) ,
      ( 8,0, 9),
      ( 8,1, 4),
      ( 8,2, 3),
      ( 8,3, 8),
      ( 8,4, 6),
      ( 8,5, 1),
      ( 8,6, 7),
      ( 8,7, 2),
      ( 8,8, 0),
      ( 8,9, 5) ,
      ( 9,0,  2),
      ( 9,1,  5),
      ( 9,2,  8),
      ( 9,3,  1),
      ( 9,4,  4),
      ( 9,5,  3),
      ( 9,6,  6),
      ( 9,7,  7),
      ( 9,8,  9),
      ( 9,9,  0)
         ;


         FOR col IN SELECT regexp_split_to_table( n::text, '' ) LOOP
                 SELECT v
                 INTO interim
                 FROM t_check
                 WHERE c = col
                 AND   r = interim;
         END LOOP;

         IF interim = 0 THEN
            RETURN TRUE;
         ELSE
           RETURN FALSE;
         END IF;

END
$CODE$
LANGUAGE plpgsql;
