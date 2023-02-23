--
-- Perl Weekly Challenge 205
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-205/>
--

CREATE SCHEMA IF NOT EXISTS pwc205;

CREATE OR REPLACE FUNCTION
pwc205.task1_plpgsql( l int[] )
RETURNS int
AS $CODE$
DECLARE
	has_third_max int := 0;
	third_max     int := 0;
BEGIN
	CREATE TEMPORARY TABLE IF NOT EXISTS t_sort( t int );
	TRUNCATE t_sort;

	INSERT INTO t_sort
	SELECT t
	FROM unnest( l ) t
	GROUP BY t
	HAVING count(*) = 1;

	SELECT count(*)
	INTO has_third_max
	FROM t_sort;

	IF has_third_max > 3 THEN
	   SELECT t
	   INTO   third_max
	   FROM t_sort
	   ORDER BY t DESC
	   OFFSET 3
	   LIMIT 1;
	ELSE
	   SELECT t
	   INTO   third_max
	   FROM t_sort
	   ORDER BY t DESC
	   LIMIT 1;
       END IF;

       RETURN third_max;

END
$CODE$
LANGUAGE plpgsql;
