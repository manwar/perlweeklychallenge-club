CREATE OR REPLACE FUNCTION
f_live_numbers( m int, n int )
RETURNS SETOF int
AS $CODE$
WITH RECURSIVE
numbers AS ( SELECT unnest( regexp_split_to_array( m::text, '' ) ) AS n )
, combinations( i, v, c ) AS (
SELECT 1, n, n
FROM numbers
UNION
SELECT i + 1, n, c || num.n
FROM combinations, numbers num
WHERE length( c || num.n ) < length( m::text ) - 1
AND num.n IN ( SELECT n FROM numbers WHERE n::int > i )
)

SELECT c::int FROM combinations
WHERE c::int % n = 0;

$CODE$
LANGUAGE sql;
