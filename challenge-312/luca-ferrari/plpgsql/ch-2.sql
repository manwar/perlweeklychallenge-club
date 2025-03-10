--
-- Perl Weekly Challenge 312
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-312>
--

CREATE SCHEMA IF NOT EXISTS pwc312;

CREATE OR REPLACE FUNCTION
pwc312.task2_plpgsql( boxes text )
RETURNS int
AS $CODE$
DECLARE
	current_color char;
	current_box   int;
	parts         text[];
	result        int;
BEGIN

	CREATE TEMPORARY TABLE IF NOT EXISTS boxes( n int, r bool, g bool, b bool, PRIMARY KEY( n ) );
	TRUNCATE boxes;

	SELECT regexp_split_to_array( boxes, '' )
	INTO parts;

	FOR i IN 1 .. length( boxes ) / 2 LOOP
	    current_color := parts[ i + ( i - 1 )  ];
	    current_box   := parts[ i + 1 + ( i - 1 ) ];

	    PERFORM n
	    FROM boxes
	    WHERE n = current_box;

	    IF NOT FOUND THEN
	       INSERT INTO boxes
	       SELECT current_box
	    	   , case current_color when 'R' then true else false end
		   , case current_color when 'G' then true else false end
		   , case current_color when 'B' then true else false end
	      ;
	   ELSE
		UPDATE boxes
		SET
			  r = r OR case current_color when 'R' then true else false end
			, g = g OR case current_color when 'G' then true else false end
			, b = b OR case current_color when 'B' then true else false end
		WHERE n = current_box;

	   END IF;


	END LOOP;

	SELECT count(*)
	INTO result
	FROM boxes
	WHERE r AND g and b;

	RETURN result;
END
$CODE$
LANGUAGE plpgsql;
