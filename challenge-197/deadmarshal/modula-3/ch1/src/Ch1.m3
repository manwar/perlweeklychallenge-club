MODULE Ch1 EXPORTS Main;

IMPORT IO;

VAR
  A1:ARRAY[0..5] OF INTEGER := ARRAY OF INTEGER{1,0,3,0,0,5};
  A2:ARRAY[0..2] OF INTEGER := ARRAY OF INTEGER{1,6,4};
  A3:ARRAY[0..4] OF INTEGER := ARRAY OF INTEGER{0,1,0,2,0};
  
PROCEDURE PrintArray(VAR Arr:ARRAY OF INTEGER) = 
  BEGIN
    FOR I := FIRST(Arr) TO LAST(Arr) DO
      IO.PutInt(Arr[I]); IO.PutChar(' ');
    END;
    IO.Put("\n");
  END PrintArray;

PROCEDURE MoveZeros(VAR Arr:ARRAY OF INTEGER) = 
  VAR Count:INTEGER := 0;
  BEGIN
    FOR I := FIRST(Arr) TO LAST(Arr) DO
      IF Arr[I] # 0 THEN Arr[Count] := Arr[I]; INC(Count) END;
    END;
    WHILE Count < NUMBER(Arr) DO Arr[Count] := 0; INC(Count) END;
  END MoveZeros;
  
BEGIN
  MoveZeros(A1);
  MoveZeros(A2);
  MoveZeros(A3);
  PrintArray(A1);
  PrintArray(A2);
  PrintArray(A3);
END Ch1.

