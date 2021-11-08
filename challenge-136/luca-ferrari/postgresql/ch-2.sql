
CREATE OR REPLACE FUNCTION task2( l int default 16)
  RETURNS SETOF text
  AS $CODE$

WITH RECURSIVE
  fib( p, n ) AS (
    SELECT 1 as p, 1 as n
    UNION
    SELECT n, p + n FROM fib WHERE n < l
  )
    , permutations AS (
      SELECT n::text as perm_n, n as perm_sum, array[ 1 ] as pivot
        FROM fib
      UNION ALL
      SELECT permutations.perm_n || ',' || fib.n, perm_sum + fib.n, array_append( pivot, fib.n )
      FROM permutations, fib
       WHERE fib.n < l
       AND position( fib.n::text in perm_n ) = 0
            
    )
  , results as (
    SELECT array( SELECT perm_n FROM permutations )
  )
  SELECT *
  FROM results;

  $CODE$
    LANGUAGE sql;
