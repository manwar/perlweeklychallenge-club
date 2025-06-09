MODULE Ch1 EXPORTS Main;

IMPORT SIO;

VAR
  A1 := ARRAY[0..6] OF INTEGER{0,1,1,0,1,1,1};
  A2 := ARRAY[0..3] OF INTEGER{0,0,0,0};
  A3 := ARRAY[0..5] OF INTEGER{1,0,1,0,1,1};

PROCEDURE ConsecutiveOne(VAR A:ARRAY OF INTEGER):CARDINAL =
  VAR Count,Res:CARDINAL;
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO
      IF A[I] = 1 THEN INC(Count)
      ELSE
        Res := MAX(Res,Count);
        Count := 0
      END
    END;
    RETURN MAX(Count,Res)
  END ConsecutiveOne;

BEGIN
  SIO.PutInt(ConsecutiveOne(A1)); SIO.Nl();
  SIO.PutInt(ConsecutiveOne(A2)); SIO.Nl();
  SIO.PutInt(ConsecutiveOne(A3)); SIO.Nl()
END Ch1.

