--
-- Perl Weekly Challenge 347
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-347>
--

CREATE SCHEMA IF NOT EXISTS pwc347;

CREATE OR REPLACE FUNCTION
pwc347.task1_plpgsql( d text )
RETURNS date
AS $CODE$
DECLARE
	x text[];
	r text;

BEGIN
	CREATE TEMPORARY TABLE IF NOT EXISTS months( i int, m text );
	TRUNCATE TABLE months;

	INSERT INTO months( i, m )
	VALUES
	  ( 1, 'Jan' )
	, ( 2, 'Feb' )
	, ( 3, 'Mar' )
	, ( 4, 'Apr' )
	, ( 5, 'May' )
	, ( 6, 'Jun' )
	, ( 7, 'Jul' )
	, ( 8, 'Aug' )
	, ( 9, 'Sep' )
	, ( 10, 'Oct' )
	, ( 11, 'Nov' )
	, ( 12, 'Dec' );

	r := '';
	x := regexp_matches( d, '(\d+).{2}\s+(\D{3})\s+(\d{4})' );

	SELECT x[ 3 ] || '-' || m.i || '-' || x[ 1 ]
	INTO r
	FROM months m
	WHERE m = x[ 2 ];


	RETURN r;

END
$CODE$
LANGUAGE plpgsql;
