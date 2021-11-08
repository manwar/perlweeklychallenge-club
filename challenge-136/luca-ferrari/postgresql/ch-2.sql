<<<<<<< HEAD

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
=======
CREATE OR REPLACE FUNCTION fibonacci_sum( l int DEFAULT 16 )
RETURNS bigint
AS $CODE$

WITH RECURSIVE
fibonacci( n, p ) AS
(
        SELECT 1, 1
        UNION
        SELECT p + n, n
        FROM fibonacci
        WHERE n < l
)
, permutations AS
(
        SELECT n::text AS current_value, n as total_sum
        FROM fibonacci
        UNION
        SELECT current_value || ',' || n, total_sum + n
        FROM permutations, fibonacci
        WHERE
                position( n::text in  current_value ) = 0
       AND n > ALL( string_to_array( current_value, ',' )::int[] )


)
SELECT count(*)
FROM permutations
WHERE total_sum = l
;

$CODE$
LANGUAGE SQL;
>>>>>>> dfcf558b2190d45a5ebf3c486a7c316dbc3e197e
