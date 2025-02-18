MODULE Ch2 EXPORTS Main;

IMPORT SIO,IntArraySort;

VAR
  A1 := ARRAY[0..3] OF INTEGER{1,5,8,9};
  A2 := ARRAY[0..3] OF INTEGER{9,4,1,7};

PROCEDURE MinDiff(VAR A:ARRAY OF INTEGER):INTEGER =
  VAR
    Diff:INTEGER;
    Min:INTEGER := LAST(INTEGER);
  BEGIN
    IntArraySort.Sort(A);
    FOR I := FIRST(A)+1 TO LAST(A) DO
      Diff := ABS(A[I] - A[I-1]);
      IF Diff < Min THEN Min := Diff END
    END;
    RETURN Min
  END MinDiff;

BEGIN
  SIO.PutInt(MinDiff(A1)); SIO.Nl();
  SIO.PutInt(MinDiff(A2)); SIO.Nl()
END Ch2.

