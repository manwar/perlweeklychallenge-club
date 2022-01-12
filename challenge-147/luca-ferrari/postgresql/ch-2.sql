/*
testdb=> select * from f_pentagons_pairs();
INFO:  P(1020) + P(2167) = P(8602840) =  1560090
INFO:  P(1020) - P(2167) = P(5482660) =  7042750
n1  |  n2  |    s    |    d    |   ps    |   pd
------+------+---------+---------+---------+---------
1020 | 2167 | 1560090 | 7042750 | 8602840 | 5482660
(1 row)

Time: 7257,715 ms (00:07,258)

*/

CREATE OR REPLACE FUNCTION
f_pentagon( n bigint )
RETURNS bigint
AS
$CODE$
        SELECT ( n * ( 3 * n - 1 ) / 2 );
$CODE$
LANGUAGE sql
IMMUTABLE;


DROP TABLE IF EXISTS pentagons;
CREATE TABLE pentagons
(
        n bigint
        , p bigint GENERATED ALWAYS AS ( f_pentagon( n ) ) STORED
);



INSERT INTO pentagons( n )
SELECT generate_series( 1, 5000 );




CREATE OR REPLACE FUNCTION
f_pentagons_pairs()
RETURNS TABLE ( n1 bigint, n2 bigint,  s bigint, d bigint, ps bigint, pd bigint )
AS $CODE$
DECLARE
        current_tuple pentagons%rowtype;
        other_tuple   pentagons%rowtype;
        fnd           int := 0;
BEGIN

        FOR current_tuple IN SELECT * FROM pentagons ORDER BY n LOOP
            SELECT *
            INTO other_tuple
            FROM pentagons pp
            WHERE EXISTS(
                  SELECT *
                  FROM pentagons ps
                  WHERE ps.p = current_tuple.p + pp.p
                  )
           AND EXISTS (
               SELECT *
               FROM pentagons ps
               WHERE ps.p = abs( current_tuple.p - pp.p )
           );


           IF FOUND THEN
              SELECT current_tuple.n
                     , other_tuple.n
                     , current_tuple.p + other_tuple.p
                     , abs( current_tuple.p - other_tuple.p )
                     , p1.n
                     , p2.n
              INTO n1, n2, s, d, ps, pd
              FROM pentagons p1, pentagons p2
              WHERE p1.p = current_tuple.p + other_tuple.p
              AND   p2.p = abs( current_tuple.p - other_tuple.p );

              RAISE INFO 'P(%) + P(%) = P(%) =  %',
                         n1, n2, ps, s;

             RAISE INFO 'P(%) - P(%) = P(%) =  %',
                        n1, n2, pd, d;


              fnd := fnd + 1;
              RETURN NEXT;
              RETURN;
           END IF;

        END LOOP;

        RETURN;
END
$CODE$
LANGUAGE plpgsql;
