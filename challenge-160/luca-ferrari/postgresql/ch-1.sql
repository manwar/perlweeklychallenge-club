-- Perl Weekly Challenge 160
CREATE SCHEMA IF NOT EXISTS pwc160;

/*
testdb=> select pwc160.four_is_magic_plpgsql( 7 );
four_is_magic_plpgsql
-----------------------
Seven is 5
Five is 4
Four is magic

*/
CREATE TABLE IF NOT EXISTS pwc160.words
(
   pk int generated always as identity
   , n int not null
   , w text not null
   , stop boolean default false
   , wlen int generated always as ( length( w ) ) stored
   , primary key( pk )
   , unique( n )
);

TRUNCATE pwc160.words;

INSERT INTO pwc160.words( n, w )
VALUES
( 1, 'One' )
, ( 2, 'Two' )
, ( 3, 'Three' )
, ( 4, 'Four' )
, ( 5, 'Five' )
, ( 6, 'Six' )
, ( 7, 'Seven' )
, ( 8, 'Eight' )
, ( 9, 'Nine' );

UPDATE pwc160.words
SET stop = true
WHERE n = 4;


CREATE OR REPLACE FUNCTION
pwc160.four_is_magic_plpgsql( needle int )
RETURNS SETOF text
AS $CODE$
DECLARE
    current_row pwc160.words%rowtype;
BEGIN

        SELECT *
        INTO current_row
        FROM pwc160.words
        WHERE n = needle;

        WHILE NOT current_row.stop  LOOP
              RETURN NEXT current_row.w || ' is ' || current_row.wlen;

              SELECT *
              INTO current_row
              FROM pwc160.words
              WHERE n = current_row.wlen;
        END LOOP;

        RETURN NEXT current_row.w || ' is magic';
        RETURN;

END
$CODE$
LANGUAGE plpgsql;
