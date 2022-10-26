MODULE Ch1 EXPORTS Main;

IMPORT IO;

VAR
  A1,A2,A3,A4,A5:REF ARRAY OF INTEGER;
  
PROCEDURE DivisiblePairs(Arr:REF ARRAY OF INTEGER;K:INTEGER):INTEGER =
  VAR Count:INTEGER;
  BEGIN
    Count := 0;
    FOR I := FIRST(Arr^) TO LAST(Arr^) DO
      FOR J := I+1 TO LAST(Arr^) DO
        IF (Arr[I] + Arr[J]) MOD K = 0 THEN INC(Count) END;
      END;
    END;
    RETURN Count;
  END DivisiblePairs;

BEGIN
  A1 := NEW(REF ARRAY OF INTEGER, 4);
  A2 := NEW(REF ARRAY OF INTEGER, 4);
  A3 := NEW(REF ARRAY OF INTEGER, 4);
  A4 := NEW(REF ARRAY OF INTEGER, 4);
  A5 := NEW(REF ARRAY OF INTEGER, 4);
  A1^ := ARRAY OF INTEGER{4,5,1,6};
  A2^ := ARRAY OF INTEGER{1,2,3,4};
  A3^ := ARRAY OF INTEGER{1,3,4,5};
  A4^ := ARRAY OF INTEGER{5,1,2,3};
  A5^ := ARRAY OF INTEGER{7,2,4,5};
  IO.PutInt(DivisiblePairs(A1, 2)); IO.Put("\n");
  IO.PutInt(DivisiblePairs(A2, 2)); IO.Put("\n");
  IO.PutInt(DivisiblePairs(A3, 3)); IO.Put("\n");
  IO.PutInt(DivisiblePairs(A4, 4)); IO.Put("\n");
  IO.PutInt(DivisiblePairs(A5, 4)); IO.Put("\n");
END Ch1.

