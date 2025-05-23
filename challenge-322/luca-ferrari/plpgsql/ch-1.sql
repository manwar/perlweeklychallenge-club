--
-- Perl Weekly Challenge 322
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-322>
--

CREATE SCHEMA IF NOT EXISTS pwc322;

CREATE OR REPLACE FUNCTION
pwc322.task1_plpgsql( s text, l int )
RETURNS text
AS $CODE$
DECLARE
	q_match  text;
	q_result text;
BEGIN
	q_match := '(\w{' || l || '})';

	q_match := $$ SELECT reverse( regexp_replace( reverse( regexp_replace( '$$ || s || $$', '-', '', 'g' ) ), '$$ || q_match || $$', '\1-', 'g' ) )$$;

	raise info '[%]', q_match;
	EXECUTE q_match
	INTO q_result;


	RETURN q_result;

END
$CODE$
LANGUAGE plpgsql;
