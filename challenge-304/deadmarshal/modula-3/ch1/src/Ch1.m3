MODULE Ch1 EXPORTS Main;

IMPORT SIO;

VAR
  A := ARRAY[0..4] OF INTEGER{1,0,0,0,1};
  
PROCEDURE ArrangeBinary(VAR A:ARRAY OF INTEGER;
                        READONLY N:INTEGER):BOOLEAN =
  VAR Count:INTEGER;
  BEGIN
    FOR I := FIRST(A) TO LAST(A)-1 DO
      IF A[I] = 0 AND A[I+1] = 0 THEN INC(Count) END
    END;
    RETURN Count > N
  END ArrangeBinary;

BEGIN
  SIO.PutBool(ArrangeBinary(A,1)); SIO.Nl();
  SIO.PutBool(ArrangeBinary(A,2)); SIO.Nl()
END Ch1.

