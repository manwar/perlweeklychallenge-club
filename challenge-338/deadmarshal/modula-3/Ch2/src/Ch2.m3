MODULE Ch2 EXPORTS Main;

IMPORT SIO;

VAR
  A1 := ARRAY[0..2] OF INTEGER{4,5,7};
  A2 := ARRAY[0..3] OF INTEGER{9,1,3,4};
  A3 := ARRAY[0..3] OF INTEGER{2,3,5,4};
  A4 := ARRAY[0..5] OF INTEGER{3,2,5,5,8,7};
  A5 := ARRAY[0..3] OF INTEGER{2,1,11,3};
  A6 := ARRAY[0..3] OF INTEGER{2,5,10,2};
  A7 := ARRAY[0..2] OF INTEGER{1,2,3};
  A8 := ARRAY[0..2] OF INTEGER{3,2,1};
  A9 := ARRAY[0..3] OF INTEGER{1,0,2,3};
  A10 := ARRAY[0..1] OF INTEGER{5,0};

PROCEDURE MaxDistance(VAR A1,A2:ARRAY OF INTEGER):INTEGER =
  VAR
    Max := FIRST(INTEGER);
  BEGIN
    FOR I := FIRST(A1) TO LAST(A1) DO
      FOR J := FIRST(A2) TO LAST(A2) DO
        WITH Abs = ABS(A1[I] - A2[J]) DO
          IF Abs > Max THEN Max := Abs END
        END
      END
    END;
    RETURN Max
  END MaxDistance;

BEGIN
  SIO.PutInt(MaxDistance(A1,A2)); SIO.Nl();
  SIO.PutInt(MaxDistance(A3,A4)); SIO.Nl();
  SIO.PutInt(MaxDistance(A5,A6)); SIO.Nl();
  SIO.PutInt(MaxDistance(A7,A8)); SIO.Nl();
  SIO.PutInt(MaxDistance(A9,A10)); SIO.Nl()
END Ch2.

