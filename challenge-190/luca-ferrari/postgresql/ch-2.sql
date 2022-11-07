-- Perl Weekly Challenge 190
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc190;

CREATE OR REPLACE FUNCTION
pwc190.task2_plpgsql( num text)
RETURNS SETOF text
AS $CODE$
DECLARE
	decoded text := '';
BEGIN
	CREATE TEMP TABLE IF NOT EXISTS decode_table ( c char, i int );
	TRUNCATE TABLE decode_table;
	INSERT INTO decode_table
	VALUES
	  ( 'A', 0 )
	, ( 'B', 1 )
	, ( 'C', 2 )
	, ( 'D', 3 )
	, ( 'E', 4 )
	, ( 'F', 5 )
	, ( 'G', 6 )
	, ( 'H', 7 )
	, ( 'I', 8 )
	, ( 'M', 9 );

	RETURN QUERY
	WITH w AS ( SELECT n::int, row_number() over () as r FROM regexp_split_to_table( num, '' ) n )
	, dec AS (
		SELECT d.c
		FROM decode_table d
		JOIN w ON w.n = d.i
		ORDER BY w.r
	)
	SELECT string_agg( dec.c, '' )
	FROM dec;



END
$CODE$
LANGUAGE plpgsql;
