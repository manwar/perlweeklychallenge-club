--
-- Perl Weekly Challenge 295
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-295>
--

CREATE SCHEMA IF NOT EXISTS pwc295;

CREATE OR REPLACE FUNCTION
pwc295.task1_plpgsql( sentence text, words text[] )
RETURNS bool
AS $CODE$
DECLARE
    word text;
BEGIN

    FOREACH word IN ARRAY words LOOP
    	IF NOT sentence ~ word THEN
    	   RETURN false;
    	END IF;

    	SELECT regexp_replace( sentence, word, '', 'g' )
    	INTO sentence;
    END LOOP;

    RETURN length( sentence ) = 0;

END
$CODE$
LANGUAGE plpgsql;
