--
-- Perl Weekly Challenge 329
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-329>
--

CREATE SCHEMA IF NOT EXISTS pwc329;

CREATE OR REPLACE FUNCTION
pwc329.task2_plpgsql( s text )
RETURNS text
AS $CODE$
DECLARE
	current text;
	i int;
	chars text[];
	result text;
	tmp text;
	needle text;
BEGIN

	SELECT regexp_split_to_array( s, '' )
	INTO chars;

	result := '';

	FOR i in 1 .. length( s ) LOOP
	    current := chars[ i ];
	    needle  := upper( current );

	    IF current ~ '[A-Z]' THEN
	       needle := lower( current );
	    END IF;

	    tmp := '';
	    FOR j IN i .. length( s ) LOOP
	    	IF chars[ j ] = needle THEN
		   tmp := array_to_string( chars[ i : j ], '' );
		   IF length( tmp ) > length( result ) THEN
		      result := tmp;
		   END IF;
	       END IF;
	    END LOOP;

	END LOOP;

	RETURN result;
END
$CODE$
LANGUAGE plpgsql;
