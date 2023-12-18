--
-- Perl Weekly Challenge 247
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-247/>
--

CREATE SCHEMA IF NOT EXISTS pwc247;

CREATE OR REPLACE FUNCTION
pwc247.task1_plpgsql( n text[] )
RETURNS TABLE( current_santa text, current_receiver text )
AS $CODE$

DECLARE
	remaining int;
BEGIN
	CREATE TEMPORARY TABLE IF NOT EXISTS santas( santa text );
	CREATE TEMPORARY TABLE IF NOT EXISTS receivers( receiver text );
	TRUNCATE santas;
	TRUNCATE receivers;

	INSERT INTO santas
	SELECT unnest( n );

	INSERT INTO receivers
	SELECT unnest( n );

	SELECT count(*)
	INTO remaining
	FROM santas;

	WHILE remaining > 0 LOOP

		SELECT santa
		INTO current_santa
		FROM santas
		ORDER BY random()
		LIMIT 1;


		SELECT	receiver
		INTO current_receiver
		FROM receivers
		ORDER BY random()
		LIMIT 1;


		IF current_receiver = current_santa THEN
		   CONTINUE;
		END IF;

		RETURN NEXT;

		DELETE FROM santas    WHERE santa = current_santa;
		DELETE FROM receivers WHERE receiver = current_receiver;

		SELECT count(*)
		INTO remaining
		FROM santas;

	END LOOP;

END
$CODE$
LANGUAGE plpgsql;
