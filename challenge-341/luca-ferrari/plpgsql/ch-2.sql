--
-- Perl Weekly Challenge 341
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-341>
--

CREATE SCHEMA IF NOT EXISTS pwc341;

CREATE OR REPLACE FUNCTION
pwc341.task2_plpgsql( word text, p text )
RETURNS text
AS $CODE$
DECLARE
	i int;
	j int;
	tt text[];
	r text := '';
BEGIN
	i := position( p IN word );
	tt := regexp_split_to_array( word, '' );

	j := i;
	WHILE i > 0 LOOP
	      r := r || tt[ i ];
	      i := i - 1;
	END LOOP;

	r := r || array_to_string( tt[ j + 1 : ], '' );

	RETURN r;
END
$CODE$
LANGUAGE plpgsql;
