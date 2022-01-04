CREATE OR REPLACE FUNCTION
f_is_prime( val int )
RETURNS bool
AS $CODE$
DECLARE
        i int;
BEGIN
     IF val <= 0 THEN
        RAISE EXCEPTION 'Cannot use a number less than 1!';
     END IF;

     FOR i IN 2 .. ( val - 1 ) LOOP
         IF val % i = 0 THEN
            RETURN false;
         END IF;
     END LOOP;

     RETURN true;
END
$CODE$
LANGUAGE plpgsql;


WITH primes AS (
SELECT n as needle, row_number() OVER( PARTITION BY f_is_prime( n ) ) as idx
FROM generate_series( 1, 10000 ) n
WHERE f_is_prime( n )
ORDER BY n
)
SELECT *
FROM primes
WHERE idx = 1001;
