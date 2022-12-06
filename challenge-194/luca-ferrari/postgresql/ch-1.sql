-- Perl Weekly Challenge 194
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc194;

CREATE OR REPLACE FUNCTION
pwc194.task1_plpgsql( what text )
RETURNS int
AS $CODE$
DECLARE
	needle char;
	idx    int := 0;
	prev   char;
BEGIN
	FOREACH needle IN ARRAY regexp_match( what, '^([\d?])([\d?]):([\d?])([\d?])$' ) LOOP
	     IF needle <> '?' THEN
	        idx := idx + 1;
		prev := needle;
	        CONTINUE;
            END IF;

		IF idx = 0 THEN
		   RETURN 2;
		ELSEIF idx = 1 THEN
		    IF prev = '2' THEN
		       RETURN 3;
		    ELSE
		      RETURN 9;
		    END IF;
		ELSEIF idx = 2 THEN
		     RETURN 5;
		ELSE
		    RETURN 9;
		END IF;
	END LOOP;
RETURN NULL;
END
$CODE$
LANGUAGE plpgsql;
