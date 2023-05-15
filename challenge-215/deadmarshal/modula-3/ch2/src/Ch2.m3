MODULE Ch2 EXPORTS Main;

IMPORT SIO;

VAR
  A1:ARRAY[0..4] OF INTEGER := ARRAY OF INTEGER{1,0,0,0,1};
  A2:ARRAY[0..4] OF INTEGER := ARRAY OF INTEGER{1,0,0,0,1};
  A3:ARRAY[0..8] OF INTEGER := ARRAY OF INTEGER{1,0,0,0,0,0,0,0,1};

PROCEDURE NumberPlacement(READONLY A:ARRAY OF INTEGER;
                          READONLY Count:INTEGER):BOOLEAN =
  VAR
    C:INTEGER := 0;
  BEGIN
    FOR I := 1 TO LAST(A)-1 DO
      IF (A[I-1] = 0) AND (A[I+1] = 0) THEN INC(C) END
    END;
    RETURN C >= Count
  END NumberPlacement;

BEGIN
  SIO.PutBool(NumberPlacement(A1,1)); SIO.Nl();
  SIO.PutBool(NumberPlacement(A2,2)); SIO.Nl();
  SIO.PutBool(NumberPlacement(A3,3)); SIO.Nl();
END Ch2.

