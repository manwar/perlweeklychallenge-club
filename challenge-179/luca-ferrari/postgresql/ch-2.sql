-- Perl Weekly Challenge 179
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc179;

CREATE TABLE IF NOT EXISTS pwc179.symbols
(
        v int PRIMARY KEY
        , s text
);

TRUNCATE pwc179.symbols;

INSERT INTO pwc179.symbols
VALUES
( 0, '▁')
,(1, '▁')
,(2,'▂')
,(3, '▃')
,(4, '▄')
,(5, '▅')
,(6, '▆')
,(7,'▇')
,(8, '█')
,(9, '█');


CREATE OR REPLACE FUNCTION
pwc179.task2_plpgsql( n int[] )
RETURNS text
AS $CODE$
DECLARE
        c int;
        t text;
        tt text;
        scale_max int;
        scale_min int;
        scale_count int;
BEGIN
     t := '';

     SELECT min(v), max(v), count(v)
     INTO scale_min, scale_max, scale_count
     FROM pwc179.symbols;

     FOREACH c IN ARRAY n LOOP
         SELECT s
         INTO   tt
         FROM pwc179.symbols
         WHERE v = ( ( c - scale_min ) / ( scale_max - scale_min ) );
         t := t || tt;
     END LOOP;

     RETURN t;
END
$CODE$
LANGUAGE plpgsql;
