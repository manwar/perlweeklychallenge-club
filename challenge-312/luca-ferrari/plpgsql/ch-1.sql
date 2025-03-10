--
-- Perl Weekly Challenge 312
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-312>
--

CREATE SCHEMA IF NOT EXISTS pwc312;

CREATE OR REPLACE FUNCTION
pwc312.task1_plpgsql( typing text )
RETURNS int
AS $CODE$
DECLARE
	secs int := 0;
	position int := 1;
	next_position int := 1;
	l int;
	r int;
	letter char;
BEGIN

	CREATE TEMPORARY TABLE IF NOT EXISTS letters( c char, clock int, anti int );
	TRUNCATE letters;
	INSERT INTO letters( c, clock, anti )
	SELECT chr( v ), row_number() over (), 25 + 1 - row_number() over ()
	FROM generate_series( 97, 97 + 25 ) v;


	FOR letter IN SELECT v FROM regexp_split_to_table( typing, '' ) v LOOP
	    SELECT abs( clock - position ), abs( 26 - clock - anti - position ), clock
	    INTO l, r, next_position
	    FROM letters
	    WHERE c = letter;


	    IF l > r THEN
	       secs := secs + r;
	    ELSE
	      secs := secs + l;
	    END IF;

	    secs := secs + 1;

	    position := next_position;

	END LOOP;


	RETURN secs;

END
$CODE$
LANGUAGE plpgsql;
