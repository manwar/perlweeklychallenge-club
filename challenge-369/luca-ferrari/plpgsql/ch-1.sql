--
-- Perl Weekly Challenge 369
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-369>
--

CREATE SCHEMA IF NOT EXISTS pwc369;

CREATE OR REPLACE FUNCTION
pwc369.task1_plpgsql( title text )
RETURNS text
AS $CODE$
DECLARE
	current_word text;
	current_tag text;
BEGIN
	current_tag := '#';

	for current_word in select v from regexp_split_to_table( title, '\s+' ) v loop
	    if array_length( regexp_matches( current_word, '[^a-zA-Z\-]'), 1 ) = 1 then
	       continue;
	    end if;

	    current_word := regexp_replace( current_word, '[-]', '', 'g' );
	    current_word := initcap( lower( current_word ) );
	    current_tag := current_tag || current_word;

	end loop;

	return current_tag;

END
$CODE$
LANGUAGE plpgsql;
