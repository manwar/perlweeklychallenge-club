--
-- Perl Weekly Challenge 275
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-275>
--

CREATE SCHEMA IF NOT EXISTS pwc275;

CREATE OR REPLACE FUNCTION
pwc275.task2_plpgsql( s text )
RETURNS text
AS $CODE$
DECLARE
	output text := '';
	previous text;
	c text;
BEGIN

	FOR c IN SELECT v FROM regexp_split_to_table( s, '' ) v LOOP
	    IF c ~ '[a-z]' THEN
	       previous := c;
	    ELSE
		c := chr( c::int + ascii( 'a' ) );
	    END IF;

	    output := output || c;
	END LOOP;

	return output;
END
$CODE$
LANGUAGE plpgsql;
