CREATE OR REPLACE FUNCTION
f_find_divisors( divisors int default 8, count int default 10 )
RETURNS SETOF int
AS $CODE$
DECLARE
   current_number  int;
   current_divisor int;
   current_found   int;
BEGIN
    FOR current_number IN 1 .. 999999 LOOP
        IF count = 0 THEN
           EXIT;
        END IF;

        current_found := 0;

        FOR current_divisor IN 1 .. current_number LOOP
            IF current_number % current_divisor = 0 THEN
               current_found := current_found + 1;
            END IF;
        END LOOP;

        IF current_found = divisors THEN
           count := count - 1;
           RETURN NEXT current_number;
        END IF;
    END LOOP;

    RETURN;
END
$CODE$
LANGUAGE plpgsql;
