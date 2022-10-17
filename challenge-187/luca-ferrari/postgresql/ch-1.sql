-- Perl Weekly Challenge 187
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc187;

CREATE OR REPLACE FUNCTION
pwc187.task1_plpgsql( foo_start date, foo_end date, bar_start date, bar_end date )
RETURNS int
AS $CODE$
DECLARE
	day_start date;
	day_end date;
	day_count int := 0;
BEGIN

	IF NOT (foo_start, foo_end) OVERLAPS (bar_start, bar_end) THEN
	   RETURN 0;
	END IF;

	IF foo_start > bar_start THEN
	   day_start := bar_start;
	ELSE
	   day_start := foo_start;
	END IF;

	IF foo_end > bar_start THEN
	   day_end := foo_end;
	ELSE
	  day_end := bar_end;
        END IF;

	WHILE day_start <= day_end LOOP
	      IF day_start >= foo_start AND day_start <= foo_end AND day_start >= bar_start AND day_end <= bar_end THEN
	      	 day_count := day_count + 1 ;
              END IF;
	      day_start := day_start + 1;
	END LOOP;

	RETURN day_count;

END
$CODE$
LANGUAGE plpgsql;
