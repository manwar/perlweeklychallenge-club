--
-- Perl Weekly Challenge 248
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-248/>
--

CREATE SCHEMA IF NOT EXISTS pwc248;

CREATE OR REPLACE FUNCTION
pwc248.task1_plpgsql( s text, c char )
RETURNS TABLE ( cc char, distance int )
AS $CODE$
DECLARE
BEGIN
	CREATE TEMPORARY TABLE IF NOT EXISTS distances( cc char, ind int );
	TRUNCATE distances;

	INSERT INTO distances
	SELECT v, row_number() over ()
	FROM regexp_split_to_table( s, '' ) v;


	RETURN QUERY
	SELECT d.cc, ( SELECT min( abs( d2.ind - d.ind ) )
	       	     FROM distances d2
		     WHERE d2.cc = c )
	FROM distances d;
END
$CODE$
LANGUAGE plpgsql;
