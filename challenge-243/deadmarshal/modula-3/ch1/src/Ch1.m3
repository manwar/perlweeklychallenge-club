MODULE Ch1 EXPORTS Main;

IMPORT IO;

VAR
  A1:ARRAY[0..4] OF INTEGER := ARRAY OF INTEGER{1,3,2,3,1};
  A2:ARRAY[0..4] OF INTEGER := ARRAY OF INTEGER{2,4,3,5,1};
  
PROCEDURE ReversePairs(VAR Arr:ARRAY OF INTEGER):INTEGER =
    VAR Count:INTEGER := 0;
  BEGIN
    FOR I := FIRST(Arr) TO LAST(Arr)-1 DO
      FOR J := I+1 TO LAST(Arr) DO
	IF Arr[I] > (2 * Arr[J]) THEN INC(Count) END
      END
    END;
    RETURN Count
  END ReversePairs;

BEGIN
  IO.PutInt(ReversePairs(A1)); IO.Put("\n");
  IO.PutInt(ReversePairs(A2)); IO.Put("\n");
END Ch1.

