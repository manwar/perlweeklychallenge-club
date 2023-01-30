MODULE Ch1 EXPORTS Main;

IMPORT IO;

VAR
  A1:ARRAY[0..2] OF INTEGER := ARRAY OF INTEGER{0,1,3};
  A2:ARRAY[0..1] OF INTEGER := ARRAY OF INTEGER{0,1};
  
PROCEDURE MissingNumbers(VAR Arr:ARRAY OF INTEGER) =
  VAR
    Hash:ARRAY[0..9] OF INTEGER;
  BEGIN
    FOR I := 0 TO 9 DO Hash[I] := 0 END;
    FOR I := FIRST(Arr) TO LAST(Arr) DO Hash[Arr[I] MOD 10] := 1 END;
    FOR I := FIRST(Arr) TO NUMBER(Arr) DO
      IF Hash[I] # 1 THEN IO.PutInt(I); IO.PutChar(' ') END;
    END;
    IO.Put("\n");
  END MissingNumbers;
  
BEGIN
  MissingNumbers(A1);
  MissingNumbers(A2);
END Ch1.

