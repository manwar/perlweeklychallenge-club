CREATE OR REPLACE FUNCTION f_ulam_do_sum( ulam int[] )
RETURNS SETOF int
AS $CODE$
DECLARE
        left_index int;
        right_index int;
BEGIN

        FOR left_index IN 1 .. array_length( ulam, 1 ) LOOP
            FOR right_index IN left_index + 1 .. array_length( ulam, 1 ) LOOP
                RETURN NEXT ulam[ left_index ] + ulam[ right_index ];
            END LOOP;
        END LOOP;

        RETURN;
END
$CODE$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION f_ulam( u int, v int, lim int default 10 )
RETURNS int[]
AS $CODE$
DECLARE
        ulam int[];
        next_value int;
BEGIN
--        PERFORM array_append( ulam, u );
--        PERFORM array_append( ulam, v );
--        PERFORM array_append( ulam, u + v );


        ulam := ulam || u || v || u + v;

        WHILE array_length( ulam, 1 ) < lim LOOP

              SELECT vv
              INTO next_value
              FROM f_ulam_do_sum( ulam ) AS sums( vv )
              WHERE vv > ulam[ array_length( ulam, 1 ) ]
              GROUP BY 1
              HAVING COUNT( * ) = 1
              ORDER BY vv
              LIMIT 1;

              ulam := ulam || next_value;
        END LOOP;

        RETURN ulam;
END
$CODE$
LANGUAGE plpgsql;
