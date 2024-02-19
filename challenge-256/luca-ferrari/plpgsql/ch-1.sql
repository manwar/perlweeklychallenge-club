--
-- Perl Weekly Challenge 256
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-256>
--

CREATE SCHEMA IF NOT EXISTS pwc256;

CREATE OR REPLACE FUNCTION
pwc256.task1_plpgsql( words text[] )
RETURNS text
AS $CODE$
	SELECT max( o )
	FROM ( SELECT w, count(*) as o
	       FROM unnest( words ) w, unnest( words ) ww
	       WHERE w = reverse ( ww )
	       GROUP BY w
	      );

$CODE$
LANGUAGE sql;
