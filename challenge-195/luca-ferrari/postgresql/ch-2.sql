-- Perl Weekly Challenge 195
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc195;

CREATE OR REPLACE FUNCTION
pwc195.task2_plpgsql( list int[] )
RETURNS int
AS $CODE$
DECLARE
	current int;
BEGIN
	CREATE TEMPORARY TABLE IF NOT EXISTS nums( v int, f int default 1, primary key( v ) );
	TRUNCATE TABLE nums;

	FOREACH current IN ARRAY list LOOP
		INSERT INTO nums AS frequency
		SELECT current, 1
		ON CONFLICT (v)
		DO UPDATE SET f = frequency.f + 1;
	END LOOP;

	SELECT v
	INTO current
	FROM nums
	WHERE v % 2 = 0
	ORDER BY f DESC, v ASC
	LIMIT 1;

	RETURN current;
END
$CODE$
LANGUAGE plpgsql;
