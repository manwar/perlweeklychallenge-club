MODULE Ch1 EXPORTS Main;

IMPORT SIO;

VAR
  A1 := ARRAY[0..2],[0..1] OF INTEGER{
  ARRAY[0..1] OF INTEGER{2,1},
  ARRAY[0..1] OF INTEGER{2,3},
  ARRAY[0..1] OF INTEGER{2,5}};
  A2 := ARRAY[0..2],[0..1] OF INTEGER{
  ARRAY[0..1] OF INTEGER{1,4},
  ARRAY[0..1] OF INTEGER{3,4},
  ARRAY[0..1] OF INTEGER{10,4}};
  A3 := ARRAY[0..2],[0..1] OF INTEGER{
  ARRAY[0..1] OF INTEGER{0,0},
  ARRAY[0..1] OF INTEGER{1,1},
  ARRAY[0..1] OF INTEGER{2,3}};
  A4 := ARRAY[0..2],[0..1] OF INTEGER{
  ARRAY[0..1] OF INTEGER{1,1},
  ARRAY[0..1] OF INTEGER{1,1},
  ARRAY[0..1] OF INTEGER{1,1}};
  A5 := ARRAY[0..2],[0..1] OF INTEGER{
  ARRAY[0..1] OF INTEGER{1000000,1000000},
  ARRAY[0..1] OF INTEGER{2000000,2000000},
  ARRAY[0..1] OF INTEGER{3000000,3000000}};

  (* Assumes zero-based arrays only: *)
PROCEDURE StraightLine(VAR A:ARRAY OF ARRAY OF INTEGER):BOOLEAN =
  VAR
    X,Y:INTEGER;
    X1 := A[0,0];
    Y1 := A[0,1];
    X2 := A[1,0];
    Y2 := A[1,1];
  BEGIN
    FOR I := 2 TO LAST(A) DO
      X := A[I,0];
      Y := A[I,1];
      IF (X - X1) * (Y2 - Y1) # (Y - Y1) * (X2 - X1) THEN
        RETURN FALSE
      END
    END;
    RETURN TRUE
  END StraightLine;

BEGIN
  SIO.PutBool(StraightLine(A1)); SIO.Nl();
  SIO.PutBool(StraightLine(A2)); SIO.Nl();
  SIO.PutBool(StraightLine(A3)); SIO.Nl();
  SIO.PutBool(StraightLine(A4)); SIO.Nl();
  SIO.PutBool(StraightLine(A5)); SIO.Nl()
END Ch1.

