--
-- Perl Weekly Challenge 227
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-227/>
--

CREATE SCHEMA IF NOT EXISTS pwc227;


CREATE  TABLE IF NOT EXISTS pwc227.roman( r text, n int );

TRUNCATE TABLE pwc227.roman;

INSERT INTO pwc227.roman
VALUES
('I', 1 )
,( 'IV', 4 )
,( 'V', 5 )
,( 'IX', 9 )
,( 'X', 10 )
,( 'XL', 40 )
,( 'L', 50 )
,( 'XC', 90 )
,( 'C', 100 )
,( 'CD', 400 )
,( 'D', 500 )
,( 'CM', 900 )
,( 'M', 1000 );




CREATE OR REPLACE FUNCTION
pwc227.to_roman( n int )
RETURNS text
AS $CODE$

DECLARE
	roman_value text := '';
        current_record pwc227.roman%rowtype;
BEGIN
	IF n <= 0 THEN
	   RETURN NULL;
	END IF;

	IF n = 1 THEN
	   RETURN 'I';
	END IF;

	FOR current_record IN SELECT * FROM pwc227.roman ORDER BY n DESC LOOP

	    WHILE n >= current_record.n LOOP
	       roman_value := roman_value || current_record.r;
	       n := n - current_record.n;
	    END LOOP;
	END LOOP;

	RETURN roman_value;
END
$CODE$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION
pwc227.from_roman( r text )
RETURNS int
AS $CODE$
DECLARE
	v int := 0;
	current_record pwc227.roman%rowtype;
BEGIN
	FOR current_record IN SELECT * FROM pwc227.roman ORDER BY n DESC LOOP
	    WHILE r ~ ( '^' || current_record.r)	   LOOP
	       v := v + current_record.n;
	       r := regexp_replace( r, '^' || current_record.r, '' );
	    END LOOP;
	END LOOP;

	RETURN v;
END
$CODE$
LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION
pwc227.task2_plpgsql( a text, op text, b text )
RETURNS text
AS $CODE$
DECLARE
	v int;
BEGIN
	IF op = '+' THEN
	   v := pwc227.from_roman( a ) + pwc227.from_roman( b );
	ELSIF op = '-' THEN
	   v := pwc227.from_roman( a ) - pwc227.from_roman( b );
	ELSIF op = '*' THEN
	  v := pwc227.from_roman( a ) * pwc227.from_roman( b );
	ELSIF op = '/' THEN
   	  v := pwc227.from_roman( a ) / pwc227.from_roman( b );
	END IF;

	RETURN pwc227.to_roman( v );

END
$CODE$
LANGUAGE plpgsql;
