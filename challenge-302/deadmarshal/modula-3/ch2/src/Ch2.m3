MODULE Ch2 EXPORTS Main;

IMPORT SIO;

VAR
  A1 := ARRAY[0..4] OF INTEGER{-3,2,-3,4,2};
  A2 := ARRAY[0..1] OF INTEGER{1,2};
  A3 := ARRAY[0..2] OF INTEGER{1,-2,-3};

PROCEDURE StepByStep(VAR A:ARRAY OF INTEGER):INTEGER =
  VAR
    S := 0;
    T := LAST(INTEGER);
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO
      INC(S,A[I]);
      T := MIN(T,S)
    END;
    RETURN MAX(1,1-T)
  END StepByStep;

BEGIN
  SIO.PutInt(StepByStep(A1)); SIO.Nl();
  SIO.PutInt(StepByStep(A2)); SIO.Nl();
  SIO.PutInt(StepByStep(A3)); SIO.Nl()
END Ch2.

