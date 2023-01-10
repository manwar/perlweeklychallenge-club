MODULE Ch2 EXPORTS Main;

IMPORT IO;

VAR
  A1:ARRAY[0..5] OF INTEGER := ARRAY OF INTEGER{3,0,1,1,9,7};
  A2:ARRAY[0..4] OF INTEGER := ARRAY OF INTEGER{1,1,2,2,3};

PROCEDURE GoodPairs(VAR A:ARRAY OF INTEGER;X,Y,Z:INTEGER):INTEGER =
  VAR
    Count:INTEGER;
  BEGIN
    Count := 0;
    FOR I := FIRST(A) TO LAST(A) DO
      FOR J := FIRST(A) TO LAST(A) DO
	FOR K := FIRST(A) TO LAST(A) DO
	  IF((ABS(A[I] - A[J]) <= X) AND
	     ((ABS(A[J] - A[K]) <= Y)) AND
	     ((ABS(A[I] - A[K]) <= Z)) AND
	     (0 <= I) AND
	     (I < J) AND
	     (J < K) AND
	     (K <= NUMBER(A)))
	    THEN INC(Count) END;
	END;
      END;
    END;
    RETURN Count;
  END GoodPairs;
  
BEGIN
  IO.PutInt(GoodPairs(A1,7,2,3)); IO.Put("\n");
  IO.PutInt(GoodPairs(A2,0,0,1)); IO.Put("\n");
END Ch2.

