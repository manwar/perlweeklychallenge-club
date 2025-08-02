MODULE Ch1 EXPORTS Main;

IMPORT SIO;

VAR
  A1:ARRAY[0..6] OF INTEGER := ARRAY OF INTEGER{-3,1,2,-1,3,-2,4};
  A2:ARRAY[0..3] OF INTEGER := ARRAY OF INTEGER{-1,-2,-3,1};
  A3:ARRAY[0..1] OF INTEGER := ARRAY OF INTEGER{1,2};

PROCEDURE MaxPositiveNegative(VAR A:ARRAY OF INTEGER):INTEGER =
  VAR Neg,Pos:INTEGER := 0;
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO
      IF A[I] < 0 THEN INC(Neg) ELSE INC(Pos) END
    END;
    RETURN MAX(Neg,Pos)
  END MaxPositiveNegative;

BEGIN
  SIO.PutInt(MaxPositiveNegative(A1)); SIO.Nl();
  SIO.PutInt(MaxPositiveNegative(A2)); SIO.Nl();
  SIO.PutInt(MaxPositiveNegative(A3)); SIO.Nl();
END Ch1.

