MODULE Ch2;

  IMPORT Out;

  VAR
    A1:ARRAY 6 OF INTEGER;
    A2:ARRAY 5 OF INTEGER;

  PROCEDURE Init;
  BEGIN
    A1[0] := 3; A1[1] := 0; A1[2] := 1; A1[3] := 1; A1[4] := 9; A1[5] := 7;
    A2[0] := 1; A2[1] := 1; A2[2] := 2; A2[3] := 2; A2[4] := 3; 
  END Init;

  PROCEDURE GoodPairs(VAR A:ARRAY OF INTEGER;X,Y,Z:INTEGER):INTEGER;
    VAR
      I,J,K:LONGINT;
      Count:INTEGER;
  BEGIN
    Count := 0;
    FOR I := 0 TO LEN(A)-1 DO
      FOR J := 0 TO LEN(A)-1 DO
	FOR K := 0 TO LEN(A)-1 DO
	  IF((ABS(A[I] - A[J]) <= X) &
	     ((ABS(A[J] - A[K]) <= Y)) &
	     ((ABS(A[I] - A[K]) <= Z)) &
	     (0 <= I) &
	     (I < J) &
	     (J < K) &
	     (K <= LEN(A)))
	    THEN INC(Count) END;
	END;
      END;
    END;
    RETURN Count;
  END GoodPairs;
  
BEGIN
  Init;
  Out.Int(GoodPairs(A1,7,2,3),0); Out.Ln;
  Out.Int(GoodPairs(A2,0,0,1),0); Out.Ln;
END Ch2.

