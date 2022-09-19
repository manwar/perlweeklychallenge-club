MODULE Ch2 EXPORTS Main;

IMPORT IO;

VAR
  I:INTEGER := 1;
  
PROCEDURE ReverseNum(N:INTEGER):INTEGER =
  VAR
    Result:INTEGER;
  BEGIN
    Result := 0;
    WHILE N # 0 DO
      Result := (Result * 10) + (N MOD 10);
      N := N DIV 10;
    END;
    RETURN Result;
  END ReverseNum;

PROCEDURE SplitNum(N:INTEGER):REF ARRAY OF INTEGER =
VAR
  I,Count:INTEGER := 0;
  Copy:INTEGER := N;
  Arr:REF ARRAY OF INTEGER;
BEGIN
  WHILE Copy # 0 DO INC(Count); Copy := Copy DIV 10; END;
  Arr := NEW(REF ARRAY OF INTEGER, Count);
  WHILE N # 0 DO
    Arr[I] := N MOD 10;
    INC(I);
    N := N DIV 10;
  END;
  RETURN Arr;
END SplitNum;
 
PROCEDURE IsReversibleNumber(N:INTEGER):BOOLEAN =
  VAR
    Sum:INTEGER := 0;
    Arr:REF ARRAY OF INTEGER;
  BEGIN
    Sum := N + ReverseNum(N);
    Arr := SplitNum(Sum);
    FOR I := FIRST(Arr^) TO LAST(Arr^) DO
      IF Arr[I] MOD 2 = 0 THEN RETURN FALSE; END;
    END;
    RETURN TRUE;
  END IsReversibleNumber;
  
BEGIN 
  WHILE I < 100 DO
    IF IsReversibleNumber(I) THEN
      IO.PutInt(I);
      IO.Put(" ");
    END;
    INC(I);
  END;
END Ch2.
