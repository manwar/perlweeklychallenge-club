CREATE OR REPLACE FUNCTION
pwc277.task1_plpgsql( words1 text[], words2 text[] )
RETURNS int
AS $CODE$

   WITH w1 AS (
       SELECT w::text
    FROM unnest( words1 ) w
    GROUP BY w
    HAVING count(*) = 1
  ),
  w2 AS (
         SELECT w::text
    FROM unnest( words2 ) w
    GROUP BY w
    HAVING count(*) = 1
  )
  SELECT count( l.w )
  FROM w1 l, w2 r
  WHERE l.w = r.w

$CODE$
LANGUAGE sql;


