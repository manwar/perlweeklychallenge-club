MODULE Ch2 EXPORTS Main;

IMPORT IO;

VAR
  I,I2:INTEGER;
  N,N2:REF ARRAY OF INTEGER;
  NTrimmed,N2Trimmed:REF ARRAY OF INTEGER;
  
PROCEDURE TrimList(VAR Arr:REF ARRAY OF INTEGER;
                   I:INTEGER):REF ARRAY OF INTEGER =
VAR
  K,Count:INTEGER := 0;
  Ret:REF ARRAY OF INTEGER;
BEGIN
  FOR J := FIRST(Arr^) TO LAST(Arr^) DO
    IF(Arr[J] > I) THEN INC(Count) END;
  END;
  Ret := NEW(REF ARRAY OF INTEGER, Count);
  FOR J := FIRST(Arr^) TO LAST(Arr^) DO
    IF(Arr[J] > I) THEN
      Ret[K] := Arr[J];
      INC(K);
    END;
  END;
  RETURN Ret;
END TrimList;

BEGIN
  I := 3;
  I2 := 4;
  N := NEW(REF ARRAY OF INTEGER, 5);
  N2 := NEW(REF ARRAY OF INTEGER, 7);
  N^ := ARRAY OF INTEGER{1,4,2,3,5};
  N2^ := ARRAY OF INTEGER{9,0,6,2,3,8,5};
  NTrimmed := TrimList(N, I);
  N2Trimmed := TrimList(N2, I2);
  FOR I := FIRST(NTrimmed^) TO LAST(NTrimmed^) DO
    IO.PutInt(NTrimmed[I]);
    IO.Put(" ");
  END;
  IO.Put("\n");
  FOR I := FIRST(N2Trimmed^) TO LAST(N2Trimmed^) DO
    IO.PutInt(N2Trimmed[I]);
    IO.Put(" ");
  END;
  IO.Put("\n");
END Ch2.
