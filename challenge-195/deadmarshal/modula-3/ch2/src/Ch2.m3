MODULE Ch2 EXPORTS Main;

IMPORT IO;

VAR
  A1:ARRAY[0..4] OF INTEGER := ARRAY OF INTEGER{1,1,2,6,2};
  A2:ARRAY[0..3] OF INTEGER := ARRAY OF INTEGER{1,3,5,7};
  A3:ARRAY[0..4] OF INTEGER := ARRAY OF INTEGER{6,4,4,6,1};

PROCEDURE AllOdd(VAR Arr:ARRAY OF INTEGER):BOOLEAN =
  BEGIN
    FOR I := FIRST(Arr) TO LAST(Arr) DO
      IF Arr[I] MOD 2 = 0 THEN RETURN FALSE END;
    END;
    RETURN TRUE;
  END AllOdd;

PROCEDURE MostFrequentEven(VAR Arr:ARRAY OF INTEGER):INTEGER =
  VAR
    MaxKey:INTEGER;
    Counts:ARRAY[0..9] OF INTEGER;
  BEGIN
    IF AllOdd(Arr) THEN RETURN -1 END;
    FOR I := FIRST(Counts) TO LAST(Counts) DO Counts[I] := 0 END;
    FOR I := FIRST(Arr) TO LAST(Arr) DO
      IF Arr[I] MOD 2 = 0 THEN
        INC(Counts[Arr[I]])
      END
    END;
    MaxKey := Counts[0];
    FOR I := 1 TO LAST(Counts) DO
      IF Counts[I] > MaxKey THEN
        MaxKey := I
      END
    END;
    RETURN MaxKey;
  END MostFrequentEven;
  
BEGIN
  IO.PutInt(MostFrequentEven(A1)); IO.Put("\n");
  IO.PutInt(MostFrequentEven(A2)); IO.Put("\n");
  IO.PutInt(MostFrequentEven(A3)); IO.Put("\n");
END Ch2.  

