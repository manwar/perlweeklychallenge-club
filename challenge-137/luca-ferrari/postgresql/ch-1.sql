/*
testdb=> select * from f_long_year();
f_long_year
-------------
1903
1908
1914
1920
1925
1931
1936
1942
1948
1953
1959
1964
1970
1976
1981
1987
1992
1998
2004
2009
2015
2020
2026
2032
2037
2043
2048
2054
2060
2065
2071
2076
2082
2088
2093
2099
(36 rows)


*/
CREATE OR REPLACE FUNCTION
f_long_year()
RETURNS SETOF int
AS $CODE$
DECLARE
        current_year int;
BEGIN
        FOR current_year IN 1900 .. 2100 LOOP
           IF date_part( 'week', make_Date( current_year, 12, 31 ) ) = 53 THEN
              RETURN NEXT current_year;
           END IF;
        END LOOP;

        RETURN;
END
$CODE$
LANGUAGE plpgsql;
