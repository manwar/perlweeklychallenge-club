MODULE Ch1 EXPORTS Main;

IMPORT IO;

VAR
  A1:ARRAY[0..5] OF INTEGER := ARRAY OF INTEGER{1,2,3,1,1,3};
  A2:ARRAY[0..2] OF INTEGER := ARRAY OF INTEGER{1,2,3};
  A3:ARRAY[0..3] OF INTEGER := ARRAY OF INTEGER{1,1,1,1};
    
PROCEDURE GoodPairs(VAR Arr:ARRAY OF INTEGER):INTEGER =
  VAR
    Count:INTEGER;
  BEGIN
    Count := 0;
    FOR I := FIRST(Arr) TO LAST(Arr) DO
      FOR J := I+1 TO LAST(Arr) DO
	IF Arr[I] = Arr[J] THEN INC(Count) END;
      END
    END;
    RETURN Count;
  END GoodPairs;
  
BEGIN
  IO.PutInt(GoodPairs(A1)); IO.Put("\n");
  IO.PutInt(GoodPairs(A2)); IO.Put("\n");
  IO.PutInt(GoodPairs(A3)); IO.Put("\n");
END Ch1.

