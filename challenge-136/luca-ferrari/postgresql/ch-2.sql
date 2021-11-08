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

