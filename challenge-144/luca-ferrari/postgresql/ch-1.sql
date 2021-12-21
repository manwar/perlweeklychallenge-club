/*
 * Check if the current number is prime
 */
CREATE OR REPLACE FUNCTION f_is_prime( n int )
RETURNS bool
AS $CODE$
DECLARE
        divisor int;
BEGIN
        FOR divisor IN 2 .. ( n - 1 ) LOOP
            IF mod( n, divisor ) = 0 THEN
               RETURN false;
            END IF;
        END LOOP;

        RETURN TRUE;
END
$CODE$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION f_semiprime_factors( n int )
RETURNS SETOF int
AS $CODE$
DECLARE
        current_number int;
BEGIN
        FOR current_number IN 1 .. n LOOP
            IF f_is_prime( current_number ) AND mod( n, current_number ) = 0 AND f_is_prime(  ( n / current_number ) ) THEN
               RETURN NEXT current_number;
            END IF;
        END LOOP;

        RETURN;
END
$CODE$
LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION f_is_semiprime( n int )
RETURNS bool
AS $CODE$
   SELECT CASE count( * )
          WHEN 0 THEN false
          ELSE true
          END
          FROM f_semiprime_factors( n ) s;
$CODE$
LANGUAGE sql;



CREATE OR REPLACE FUNCTION f_find_semiprimes( lim int default 100 )
RETURNS SETOF int
AS $CODE$
DECLARE
      n int;
BEGIN
   n := 1;

   WHILE n < lim LOOP
       IF f_is_semiprime( n ) THEN
          RETURN NEXT n;
       END IF;
       n := n + 1;
   END LOOP;

   RETURN;
END
$CODE$
LANGUAGE plpgsql;
