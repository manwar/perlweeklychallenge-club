/**
testdb=> select * from f_eertree( 'redivider' );
current_root |  string
--------------+-----------
r            | redivider
e            | edivide
d            | divid
i            | ivi
(4 rows)

testdb=> select * from f_eertree( 'hello' );
current_root | string
--------------+--------
l            | ll
(1 row)

*/
CREATE OR REPLACE FUNCTION
f_eertree( s text )
RETURNS TABLE( current_root char, string text )
AS $CODE$
DECLARE
        current int;
        other   int;
        other_root   char;
BEGIN

        FOR current IN 1 .. length( s ) LOOP
           current_root := substring( s FROM current FOR  1 );

           FOR other IN current + 1 .. length( s ) LOOP
               other_root := substring( s FROM other FOR 1 );
               IF other_root <> current_root THEN
                  CONTINUE;
               END IF;

               string := substring( s, current, other - current + 1 );

               IF string = reverse( string ) THEN
                  RETURN NEXT;
               END IF;

           END LOOP;
        END LOOP;

        RETURN;

END
$CODE$
LANGUAGE plpgsql;
