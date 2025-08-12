MODULE Ch2 EXPORTS Main;

IMPORT SIO;

VAR
  A1 := ARRAY[0..3],[0..1] OF INTEGER{
  ARRAY[0..1] OF INTEGER{1,2},
  ARRAY[0..1] OF INTEGER{3,1},
  ARRAY[0..1] OF INTEGER{2,4},
  ARRAY[0..1] OF INTEGER{2,3}};

  A2 := ARRAY[0..3],[0..1] OF INTEGER{
  ARRAY[0..1] OF INTEGER{3,4},
  ARRAY[0..1] OF INTEGER{2,3},
  ARRAY[0..1] OF INTEGER{1,5},
  ARRAY[0..1] OF INTEGER{2,5}};
  
  A3 := ARRAY[0..2],[0..1] OF INTEGER{
  ARRAY[0..1] OF INTEGER{2,2},
  ARRAY[0..1] OF INTEGER{3,3},
  ARRAY[0..1] OF INTEGER{4,4}};
  
  A4 := ARRAY[0..3],[0..1] OF INTEGER{
  ARRAY[0..1] OF INTEGER{0,1},
  ARRAY[0..1] OF INTEGER{1,0},
  ARRAY[0..1] OF INTEGER{0,2},
  ARRAY[0..1] OF INTEGER{2,0}};
  
  A5 := ARRAY[0..3],[0..1] OF INTEGER{
  ARRAY[0..1] OF INTEGER{5,6},
  ARRAY[0..1] OF INTEGER{6,5},
  ARRAY[0..1] OF INTEGER{5,4},
  ARRAY[0..1] OF INTEGER{4,5}};

PROCEDURE NearestValidPoint(VAR A:ARRAY OF ARRAY OF INTEGER;
                            READONLY X,Y:INTEGER):INTEGER =
  VAR
    Res := -1;
    Min := LAST(INTEGER);
    D:INTEGER;
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO
      WITH X1 = A[I,FIRST(A)],Y1 = A[I,FIRST(A)+1] DO
        IF X1 = X OR Y1 = Y THEN
          D := ABS(X1 - X) + ABS(Y1 - Y);
          IF D < Min THEN
            Min := D;
            Res := I
          END
        END
      END
    END;
    RETURN Res
  END NearestValidPoint;

BEGIN
  SIO.PutInt(NearestValidPoint(A1,3,4)); SIO.Nl();
  SIO.PutInt(NearestValidPoint(A2,2,5)); SIO.Nl();
  SIO.PutInt(NearestValidPoint(A3,1,1)); SIO.Nl();
  SIO.PutInt(NearestValidPoint(A4,0,0)); SIO.Nl();
  SIO.PutInt(NearestValidPoint(A5,5,5)); SIO.Nl()
END Ch2.

