MODULE Ch1 EXPORTS Main;

IMPORT SIO;

VAR
  A1 := ARRAY[0..4] OF INTEGER{2,8,10,11,15};
  A2 := ARRAY[0..4] OF INTEGER{1,5,6,7,14};
  A3 := ARRAY[0..3] OF INTEGER{8,20,25,28};

PROCEDURE MinGap(VAR A:ARRAY OF INTEGER):INTEGER =
  VAR Min,MGap,Gap:INTEGER;
  BEGIN
    <* ASSERT NUMBER(A) >= 2 *>
    Min := A[0];
    MGap := A[1] - A[0];
    FOR I := FIRST(A)+2 TO LAST(A) DO
      Gap := A[I] - A[I-1];
      IF Gap < MGap THEN
        Min := A[I];
        MGap := Gap
      END
    END;
    RETURN Min
  END MinGap;
  
BEGIN
  SIO.PutInt(MinGap(A1)); SIO.Nl();
  SIO.PutInt(MinGap(A2)); SIO.Nl();
  SIO.PutInt(MinGap(A3)); SIO.Nl()
END Ch1.

