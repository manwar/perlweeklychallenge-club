CREATE OR REPLACE FUNCTION
  f_long_primes( l int default 5 )
  RETURNS SETOF bigint
AS $CODE$
  DECLARE
  current_value numeric;
  i int;
  is_prime bool;
  rational_part text;
  done int := 0;
  repeating_part_size int := 0;
  repeating_part      text;
  result_as_text      text;
  text_array          text[];

BEGIN

  for current_value IN 1 .. 99999 LOOP
    is_prime := true;

    -- check if this is prime
    for i in 2 .. ( current_value - 1 ) LOOP
      if current_value % i = 0 THEN
        is_prime := false;
        exit; -- terminate this loop
        END IF;
    END LOOP;

    -- avoid inspecting this number if it is not prime
    if is_prime = false THEN
      continue;
    END IF;

    result_as_text := ( 1 / current_value::numeric )::text;
    i := strpos( result_as_text, '.' );
    rational_part := substr( result_as_text, i + 1 );
    repeating_part_size :=  current_value - 1;
    repeating_part      := substr( rational_part, 1, repeating_part_size );

    RAISE DEBUG 'Inspecting % -> % {%} => % ( %, % )',
      current_value,
      rational_part,
      repeating_part_size,
      repeating_part,
      i,
      ( 1 / current_value )::text;


    text_array := regexp_split_to_array( rational_part, repeating_part  );
    is_prime   := true;
    FOREACH result_as_text IN ARRAY text_array LOOP
      IF result_as_text <> '' AND substr( repeating_part, 1, length( result_as_text ) ) <> result_as_text THEN
        is_prime := false;
        exit;
      END IF;
    END LOOP;

    IF is_prime THEN
      RETURN NEXT current_value;
      done := done + 1;
    END IF;

    IF done > l THEN
      EXIT;
    END IF;
  END LOOP;

  RETURN;
END
  $CODE$
  LANGUAGE plpgsql;
