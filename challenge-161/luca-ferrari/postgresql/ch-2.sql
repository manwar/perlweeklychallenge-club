-- Perl Weekly Challenge 161


CREATE SCHEMA IF NOT EXISTS pwc161;

CREATE OR REPLACE FUNCTION
pwc161.pangrams_plpgsql()
RETURNS SETOF TEXT
AS $CODE$
DECLARE
        start_letter int;
        end_letter   int;
        letter char;
        current_word pwc161.dictionary%rowtype;
        found_words text;
BEGIN
  start_letter := ascii( 'a' );
  end_letter   := ascii( 'z' );
  FOR l IN start_letter .. end_letter LOOP
      letter := chr( l );

      IF found_words LIKE '%' || letter || '%' THEN
         CONTINUE;
      END IF;

      SELECT word
      INTO   current_word
      FROM pwc161.dictionary
      WHERE word like '%' || letter || '%'
      ORDER BY RANDOM()
      LIMIT 1;



      found_words := found_words || ' ' || current_word;
      RETURN NEXT current_word.word;

  END LOOP;

RETURN;
END
$CODE$
LANGUAGE plpgsql;
