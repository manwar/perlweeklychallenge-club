CREATE OR REPLACE FUNCTION
  f_jort_sort( n int[] )
  RETURNS int
AS $CODE$
  DECLARE
  n_ordered int[];
BEGIN
  SELECT ( ARRAY( SELECT unnest( n ) ORDER BY 1 ) )
    INTO n_ordered;

  IF array_to_string( n, '|' ) = array_to_string( n_ordered, '|' ) THEN
    RETURN 1;
  ELSE
    RETURN 0;
  END IF;
END
  $CODE$
  LANGUAGE plpgsql;
