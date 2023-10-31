MODULE Ch1 EXPORTS Main;

IMPORT IO;

VAR
  A1:ARRAY[0..5] OF INTEGER := ARRAY OF INTEGER{0,1,4,6,7,10};
  A2:ARRAY[0..5] OF INTEGER := ARRAY OF INTEGER{4,5,6,7,8,9};

PROCEDURE ArithmeticTriplets(VAR A:ARRAY OF INTEGER;Diff:INTEGER):INTEGER =
  VAR Count:INTEGER := 0;
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO
      FOR J := I+1 TO LAST(A) DO
        FOR K := J+1 TO LAST(A) DO
          IF (A[J] - A[I] = Diff) AND (A[K] - A[J] = Diff) THEN INC(Count) END
        END
      END
    END;
    RETURN Count
  END ArithmeticTriplets;

BEGIN
  IO.PutInt(ArithmeticTriplets(A1,3)); IO.Put("\n");
  IO.PutInt(ArithmeticTriplets(A2,2)); IO.Put("\n"); 
END Ch1.

