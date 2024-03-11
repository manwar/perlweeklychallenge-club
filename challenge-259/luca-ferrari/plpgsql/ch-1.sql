--
-- Perl Weekly Challenge 259
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-259>
--

CREATE SCHEMA IF NOT EXISTS pwc259;

CREATE OR REPLACE FUNCTION
pwc259.task1_plpgsql( day date, how_many_days int, holidays date[] )
RETURNS date
AS $CODE$
DECLARE
	current_holiday date;
BEGIN

	WHILE how_many_days > 0 LOOP
	      day := day + 1;

	      WHILE extract( dow from day ) IN ( 0, 6 ) LOOP
	      	 day := day + 1;
              END LOOP;

	      FOREACH current_holiday IN ARRAY holidays LOOP
	      	      IF current_holiday = day THEN
		      	 day := day + 1;
		      END IF;
	      END LOOP;

	      how_many_days := how_many_days - 1;
	END LOOP;

	RETURN day;
END
$CODE$
LANGUAGE plpgsql;
