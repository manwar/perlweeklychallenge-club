-- Perl Weekly Challenge 193
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc193;

CREATE OR REPLACE FUNCTION
pwc193.task2_plpgsql( s text )
RETURNS text
AS $CODE$
DECLARE
	c char;
	pre int;
	cur int;

	count_all int;
	count_odd int;
BEGIN
	CREATE TEMPORARY TABLE IF NOT EXISTS translations( l char, i int DEFAULT 0 );
	TRUNCATE translations;

	INSERT INTO translations
	VALUES
	  ( 'a', 0 )
	, ( 'b', 1 )
	, ( 'c', 2 )
	, ( 'd', 3 )
	, ( 'e', 4 )
	, ( 'f', 5 )
	, ( 'g', 6 )
	, ( 'h', 7 )
	, ( 'i', 8 )
	, ( 'j', 9 )
	, ( 'k', 10 )
	, ( 'l', 11 )
	, ( 'm', 12 )
	, ( 'n', 13 )
	, ( 'o', 14 )
	, ( 'p', 15 )
	, ( 'q', 16 )
	, ( 'r', 17 )
	, ( 's', 18 )
	, ( 't', 19 )
	, ( 'u', 20 )
	, ( 'v', 21 )
	, ( 'x', 22 )
	, ( 'y', 23 )
	, ( 'z', 24 );


	CREATE TEMPORARY TABLE IF NOT EXISTS result( v int );
	TRUNCATE result;

	FOR c IN SELECT regexp_split_to_table( s, '' ) LOOP
	    SELECT i
	    INTO cur
	    FROM translations
	    WHERE l = c;

	    IF pre IS NOT NULL THEN
	       INSERT INTO result
	       SELECT cur - pre;
	    END IF;

	    pre := cur;
	END LOOP;


	SELECT count( * )
	INTO count_all
	FROM result;

	SELECT count(*)
	INTO count_odd
	FROM result
	WHERE V % 2 <> 0;

	IF count_all <> count_odd THEN
	   RETURN NULL;
	ELSE
	  RETURN s;
	END IF;
END
$CODE$
LANGUAGE plpgsql;
