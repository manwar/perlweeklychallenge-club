CREATE OR REPLACE FUNCTION
f_pentagon( n bigint )
RETURNS bigint
AS
$CODE$
        SELECT ( n * ( 3 * n - 1 ) / 2 );
$CODE$
LANGUAGE sql
IMMUTABLE;

/*
pentagon_pairs
----------------
1020, 2167
2167, 1020
(2 rows)

Time: 5820,066 ms (00:05,820)

*/
WITH RECURSIVE pentagons( n, p )
AS
(
        SELECT 1 AS n
               , f_pentagon( 1 ) AS p

UNION
        SELECT p.n + 1
               , f_pentagon( p.n + 1 )
        FROM pentagons p
        WHERE p.n < 5000
)

SELECT format( '%s, %s', l.n, r.n ) AS pentagon_pairs
FROM pentagons l, pentagons r
WHERE EXISTS(
      SELECT *
      FROM pentagons ps
      WHERE ps.p = l.p + r.p
      )
AND EXISTS (
    SELECT *
    FROM pentagons ps
    WHERE ps.p = abs( l.p - r.p )
    )
;
