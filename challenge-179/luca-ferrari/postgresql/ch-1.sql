-- Perl Weekly Challenge 179
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc179;

CREATE TABLE IF NOT EXISTS
pwc179.number2words
(
        v int PRIMARY KEY
        , t text
);

TRUNCATE pwc179.number2words;

INSERT INTO pwc179.number2words
VALUES
  ( 1, 'first' )
, ( 2, 'second' )
, ( 3, 'third' )
, ( 4, 'fourth' )
, ( 5, 'fifth' )
, ( 6, 'sixth' )
, ( 7, 'seventh' )
, ( 8, 'eigth' )
, ( 9, 'nineth' )
, ( 10, 'tenth' )
, ( 11, 'eleventh' )
, ( 12, 'twelveth' )
, ( 13, 'thirteenth' )
, ( 14, 'fourtineenth' )
, ( 15, 'fifteenth' )
, ( 16, 'sixteenth' )
, ( 17, 'seventeenth' )
, ( 18, 'eigthteenth' )
, ( 19, 'nineteenth' )
, ( 20, 'twentyth' )
, ( 30, 'thirtyth' )
, ( 40, 'fourtyth' )
, ( 50, 'fiftyth' )
, ( 60, 'sixtyth' )
, ( 70, 'seventyth' )
, ( 80, 'eightyth' )
, ( 90, 'ninetyth' );


CREATE OR REPLACE FUNCTION
pwc179.task1_plpgsql( n int )
RETURNS TEXT
AS $CODE$

DECLARE
        w text;
        s text;
BEGIN
        SELECT t
        INTO w
        FROM pwc179.number2words
        WHERE v = n;

        IF FOUND THEN
           RETURN w;
        ELSE
           -- not found, compose the word
           SELECT t
           INTO w
           FROM pwc179.number2words
           WHERE v = ( n / 10 )::int;

           SELECT t
           INTO s
           FROM pwc179.number2words
           WHERE v = ( n % 10 )::int;

           RETURN replace( w, 'th', 'ty') || s;
        END IF;
END

$CODE$
LANGUAGE plpgsql;
