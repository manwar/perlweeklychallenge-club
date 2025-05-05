MODULE Ch1 EXPORTS Main;

IMPORT SIO;

VAR
  A1 := ARRAY[0..5] OF INTEGER{-3,-2,-1,1,2,3};
  A2 := ARRAY[0..4] OF INTEGER{-2,-1,0,0,1};
  A3 := ARRAY[0..3] OF INTEGER{1,2,3,4};

PROCEDURE MaximumCount(VAR A:ARRAY OF INTEGER):CARDINAL =
  VAR Neg,Pos:CARDINAL;
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO
      IF A[I] # 0 THEN
        IF A[I] < 0 THEN INC(Neg) ELSE INC(Pos) END
      END
    END;
    RETURN MAX(Neg,Pos)
  END MaximumCount;

BEGIN
  SIO.PutInt(MaximumCount(A1)); SIO.Nl();
  SIO.PutInt(MaximumCount(A2)); SIO.Nl();
  SIO.PutInt(MaximumCount(A3)); SIO.Nl()
END Ch1.

