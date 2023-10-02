--
-- Perl Weekly Challenge 237
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-237/>
--

CREATE SCHEMA IF NOT EXISTS pwc237;

CREATE OR REPLACE FUNCTION
pwc237.task1_plpgsql( y int, m int, d int, w int )
RETURNS text
AS $CODE$
DECLARE
	current_date date;
	current_week int := 0;
	current_result text;
	current_temp text;
BEGIN
	SELECT make_date( y, m, 1 )
	INTO current_date;


	CREATE TEMPORARY TABLE IF NOT EXISTS ord( o int, t text );
	TRUNCATE ord;
	INSERT INTO ord
	VALUES( 1, 'first' ), ( 2, 'second' ), (3, 'third' );
	FOR i IN 4 .. 31 LOOP
	    INSERT INTO ord
	    SELECT i, i || 'th';
	END LOOP;

	CREATE TEMPORARY TABLE IF NOT EXISTS dname( o int, t text );
	TRUNCATE dname;
	INSERT INTO dname
	VALUES
	(1, 'Monday'), (2, 'Tuesday'),(3,'Wednsday'),(4,'Thursday'),(5,'Friday'),(6,'Saturday'),(7,'Sunday');


	WHILE extract( month FROM current_date ) = m AND extract( year FROM current_date ) = y LOOP

	   IF extract( dow FROM current_date ) = 1 THEN
	      current_week := current_week + 1;
	   END IF;

	   RAISE INFO 'Date is %', current_date;

	   IF current_week = w AND extract( dow FROM current_date ) = d THEN
	      -- found
	      RAISE INFO 'Found on %', current_date;
	      SELECT t
	      INTO current_temp
	      FROM ord
	      WHERE o = w;

 	      current_result := 'The ' || current_temp;

	      SELECT t
	      INTO current_temp
	      FROM dname
	      WHERE o = extract( dow FROM current_date );

	      current_result := current_result || ' ' || current_temp || ' of year ' || y || ' is ' || extract(day from current_date);
	      RETURN current_result;
	   END IF;

	   SELECT current_date + 1
	   INTO current_date;


	END LOOP;

	RETURN 'Date not found';
END
$CODE$
LANGUAGE plpgsql;
