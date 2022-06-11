-- Perl Weekly Challenge 159

CREATE SCHEMA IF NOT EXISTS  pwc159;

CREATE OR REPLACE FUNCTION
pwc159.prime_factors( n int )
RETURNS SETOF int
AS $CODE$
DECLARE
        factor int;
BEGIN
        factor := 2;

        WHILE ( factor <= n AND n > 1 ) LOOP
              IF n % factor = 0 THEN
                 n := n / factor;
                 RETURN NEXT factor;
              ELSE
                factor := factor + 1;
              END IF;
        END LOOP;

        RETURN;
END
$CODE$
LANGUAGE plpgsql;


\set n 5

WITH count_prime_factors(  c, cc ) AS
(
        SELECT count( distinct pf ), count( pf )
        FROM pwc159.prime_factors( :n ) pf
)
SELECT :n AS number,
       CASE
       WHEN c - cc <> 0 THEN 0
       WHEN c % 2  = 0  THEN 1
       ELSE -1
       END

FROM count_prime_factors;
