DROP TABLE IF EXISTS fraction_tree;
CREATE TABLE fraction_tree (
       pk int GENERATED ALWAYS AS IDENTITY
       , numerator int default 1
       , denominator int default 1
       , child_of int
       , level int default 1
       , PRIMARY KEY( pk )
       , FOREIGN KEY (child_of) REFERENCES fraction_tree( pk )
);


TRUNCATE TABLE fraction_tree;
ALTER TABLE fraction_tree ALTER COLUMN pk RESTART;


INSERT INTO fraction_tree( numerator, denominator )
VALUES( 1, 1 );





CREATE OR REPLACE FUNCTION
f_add_one_level_fraction_tree()
RETURNS INT
AS $CODE$
DECLARE
        current_left   fraction_tree%rowtype;
        current_right  fraction_tree%rowtype;
        previous_tuple fraction_tree%rowtype;
        nodes_added    int := 0;
BEGIN

        FOR previous_tuple IN SELECT * FROM fraction_tree
                                     WHERE level = ( SELECT max( level ) FROM fraction_tree )
                                     LOOP


                current_left.numerator   := previous_tuple.numerator;
                current_left.denominator := ( previous_tuple.numerator + previous_tuple.denominator );
                current_left.child_of    := previous_tuple.pk;
                current_left.level       := previous_tuple.level + 1;
                current_left.pk          := nextval( 'fraction_tree_pk_seq' );

                current_right.numerator   := ( previous_tuple.numerator + previous_tuple.denominator );
                current_right.denominator := previous_tuple.denominator;
                current_right.child_of    := previous_tuple.pk;
                current_right.level       := previous_tuple.level + 1;
                current_right.pk          := nextval( 'fraction_tree_pk_seq' );

                INSERT INTO fraction_tree
                OVERRIDING SYSTEM VALUE
                SELECT current_left.*;

                INSERT INTO fraction_tree
                OVERRIDING SYSTEM VALUE
                SELECT current_right.*;

                nodes_added := nodes_added + 2;

       END LOOP;

       RETURN nodes_added;
END
$CODE$
LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION
f_populate_fraction_tree( levels int default 4 )
RETURNS int
AS $CODE$
DECLARE
        i           int := 0;
        nodes_added int := 0;
BEGIN
     FOR i IN 1 .. levels LOOP
         nodes_added := nodes_added + f_add_one_level_fraction_tree();
     END LOOP;

     RETURN nodes_added;
END
$CODE$
LANGUAGE plpgsql;


/*
testdb=> select * from  f_search_for_fraction_tree( 3, 5 );
description | fraction
-------------+----------
child       | 3/5
parent      | 3/2
grandparent | 1/2

*/

CREATE OR REPLACE FUNCTION
f_search_for_fraction_tree( numer int, denomin int )
RETURNS TABLE ( description text, fraction text )
AS $CODE$
DECLARE
        current_tuple fraction_tree%rowtype;
BEGIN
        SELECT 'child', numerator || '/' || denominator
        INTO description, fraction
        FROM fraction_tree
        WHERE numerator   = numer
        AND   denominator = denomin;

        IF FOUND THEN
           RETURN NEXT;


           SELECT 'parent', numerator || '/' || denominator
           INTO description, fraction
           FROM fraction_tree
           WHERE pk = ( SELECT child_of
                        FROM fraction_tree
                        WHERE numerator   = numer
                        AND   denominator = denomin );

           RETURN NEXT;



           SELECT 'grandparent', numerator || '/' || denominator
           INTO description, fraction
           FROM fraction_tree
           WHERE pk = ( SELECT child_of
                        FROM fraction_tree
                        WHERE pk = ( SELECT child_of
                                     FROM fraction_tree
                                     WHERE numerator   = numer
                                     AND   denominator = denomin ) );

          RETURN NEXT;

        END IF;

        RETURN;
END
$CODE$
LANGUAGE plpgsql;
