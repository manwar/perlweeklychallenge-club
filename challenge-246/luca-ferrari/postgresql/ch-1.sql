--
-- Perl Weekly Challenge 246
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-246/>
--

CREATE SCHEMA IF NOT EXISTS pwc246;

CREATE OR REPLACE FUNCTION
pwc246.task1_plpgsql()
RETURNS SETOF INT
AS $CODE$
DECLARE
	counting int;
	current_value int;
BEGIN
	CREATE TEMPORARY TABLE IF NOT EXISTS lottery( v int, CHECK( v <= 49 ), PRIMARY KEY( v ) );
	TRUNCATE lottery;

	counting := 0;
	WHILE counting < 6 LOOP
	      current_value := ( random() * 100 )::int;

	      IF current_value <= 49 THEN
	      	      INSERT INTO lottery( v )
	      	      VALUES( current_value )
		      ON CONFLICT ( v ) DO NOTHING;
	      END IF;


	      SELECT count(*)
	      INTO counting
	      FROM lottery;

	END LOOP;

	RETURN QUERY
	SELECT * FROM lottery;
END
$CODE$
LANGUAGE plpgsql;
