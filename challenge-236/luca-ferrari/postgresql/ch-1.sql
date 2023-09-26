--
-- Perl Weekly Challenge 236
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-236/>
--

CREATE SCHEMA IF NOT EXISTS pwc236;

CREATE OR REPLACE FUNCTION
pwc236.task1_plpgsql( cashing int[] )
RETURNS boolean
AS $CODE$
DECLARE
	current_cash int;
	available_qty_10 int;
	available_qty_5 int;
BEGIN

	CREATE TEMPORARY TABLE IF NOT EXISTS remainder( cash int, quantity int default 1 );
	TRUNCATE TABLE remainder;
	INSERT INTO remainder( cash, quantity )
	VALUES
	(5, 0 ), ( 10, 0 ), ( 15, 0 );

	FOREACH current_cash IN ARRAY cashing LOOP
		UPDATE remainder
		SET quantity = quantity + 1
		WHERE cash = current_cash;

		IF current_cash = 5 THEN
		   CONTINUE;
		END IF;

		IF current_cash = 10 THEN
		   SELECT quantity
		   INTO available_qty_5
		   FROM remainder
		   WHERE cash = 5;

		   IF available_qty_5 > 0 THEN
		      UPDATE remainder
		      SET quantity = quantity - 1
		      WHERE cash = 5;
		   ELSE
		      RETURN false;
		   END IF;
		END IF;


		IF current_cash = 20 THEN
		   SELECT quantity
		   INTO available_qty_10
		   FROM remainder
		   WHERE cash = 10;

		   SELECT quantity
		   INTO available_qty_5
		   FROM remainder
		   WHERE cash = 5;

		   IF available_qty_10 > 0 AND available_qty_5 > 0 THEN
		      UPDATE remainder
		      SET quantity = quantity - 1
		      WHERE cash IN ( 5, 10 );
		   ELSIF available_qty_10 = 0 and available_qty_5 >= 3 THEN
		      UPDATE remainder
		      SET quantity = quantity - 3
		      WHERE cash = 5;
		   ELSE
		     RETURN false;
		   END IF;
		END IF;
	END LOOP;

	return true;
END
$CODE$
LANGUAGE plpgsql;
