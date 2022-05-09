-- Perl Weekly Challenge 164
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc164;


CREATE OR REPLACE FUNCTION
pwc164.is_prime( n int )
RETURNS boolean
AS $CODE$
DECLARE
BEGIN
   FOR i IN 2 .. n - 1 LOOP
     IF n % i = 0 THEN
       RETURN false;
     END IF;
   END LOOP;

   RETURN true;
END
$CODE$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION
pwc164.task1_plpgsql( l int DEFAULT 1000 )
RETURNS SETOF INT
AS $CODE$
DECLARE
BEGIN

     FOR n IN 10 .. l LOOP
         IF pwc164.is_prime( n ) AND n = reverse( n::text )::int THEN
            RETURN NEXT n;
            l := l - 1;
         END IF;

         EXIT WHEN l = 0;
     END LOOP;

RETURN;
END
$CODE$
LANGUAGE plpgsql;
