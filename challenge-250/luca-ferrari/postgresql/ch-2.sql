--
-- Perl Weekly Challenge 250
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-250/>
--

CREATE SCHEMA IF NOT EXISTS pwc250;

CREATE OR REPLACE FUNCTION
pwc250.task2_plpgsql( words text[] )
RETURNS int
AS $CODE$
DECLARE
	final int;
BEGIN
	CREATE TEMPORARY TABLE IF NOT EXISTS t_values( w text, l int, v int DEFAULT 0 );
	TRUNCATE t_values;

	INSERT INTO t_values( w, l, v )
	SELECT vv, length( vv ), length( vv )
	FROM unnest( words ) vv;

	UPDATE t_values
	SET v = w::int
	WHERE w IN ( SELECT w FROM t_values
	      	     WHERE regexp_match( w, '^\d+$' ) IS NOT NULL );

	SELECT max( v )
	INTO final
	FROM t_values;

	RETURN final;
END
$CODE$
LANGUAGE plpgsql;
