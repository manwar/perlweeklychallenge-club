CREATE OR REPLACE FUNCTION
f_is_prime( n bigint )
RETURNS bool
AS
$CODE$
DECLARE
        i int;
BEGIN
        FOR i IN 2 .. ( n - 1 ) LOOP
            IF n % i = 0 THEN
               RETURN false;
            END IF;
        END LOOP;

        RETURN true;
END
$CODE$
LANGUAGE plpgsql;


/**
testdb=> select * from f_generate_truncated_primes();
f_generate_truncated_primes
-----------------------------
11
13
17
23
31
37
41
43
47
53
61
67
71
73
83
97
113
131
137
167
(20 rows)

*/
CREATE OR REPLACE FUNCTION
f_generate_truncated_primes( l int = 20 )
RETURNS SETOF int
AS
$CODE$
DECLARE
        i int;
        current bigint;
        fnd   int := 0;
BEGIN
<<MAIN_LOOP>>
        FOR current IN SELECT * FROM generate_series( 10, 999999 ) LOOP
            CONTINUE WHEN current::text LIKE '%0%';

            IF NOT f_is_prime( current ) THEN
               CONTINUE MAIN_LOOP;
            END IF;


            FOR i IN 1 .. length( current::text ) LOOP
                IF NOT f_is_prime( substring( current::text FROM i )::int ) THEN
                   CONTINUE MAIN_LOOP;
                END IF;
            END LOOP;

            fnd := fnd + 1;
            RETURN NEXT current;
            IF fnd >= l THEN
               RETURN;
            END IF;
        END LOOP;

        RETURN;
END
$CODE$
LANGUAGE plpgsql;
