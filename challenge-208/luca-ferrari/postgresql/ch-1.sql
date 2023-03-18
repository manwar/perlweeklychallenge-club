--
-- Perl Weekly Challenge 208
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-208/>
--

CREATE SCHEMA IF NOT EXISTS pwc208;

CREATE OR REPLACE FUNCTION
pwc208.task1_plpgsql( f text[], s text[] )
RETURNS SETOF TEXT
AS $CODE$
	WITH ta AS (
	   SELECT t, row_number() over() AS v
	   FROM unnest( f ) t
	)
	, tb AS (
	   SELECT t, row_number() over() AS v
	   FROM unnest( s ) t
	)
	, res AS (
	  SELECT ta.t, ta.v + tb.v AS v
	  FROM ta JOIN tb ON ta.t = tb.t
	)
	SELECT res.t
	FROM res
	WHERE res.v = (SELECT min( res.v ) FROM res );
$CODE$
LANGUAGE sql;
