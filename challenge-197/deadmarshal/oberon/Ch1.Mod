MODULE Ch1;

  IMPORT Out;

  VAR
    A1:ARRAY 6 OF INTEGER;
    A2:ARRAY 3 OF INTEGER;
    A3:ARRAY 5 OF INTEGER;
    
  PROCEDURE Init;
  BEGIN
    A1[0] := 1; A1[1] := 0; A1[2] := 3;
    A1[3] := 0; A1[4] := 0; A1[5] := 5;
    A2[0] := 1; A2[1] := 6; A2[2] := 4;
    A3[0] := 0; A3[1] := 1; A3[2] := 0;
    A3[3] := 2; A3[4] := 0;
  END Init;
  
  PROCEDURE PrintArray(VAR Arr:ARRAY OF INTEGER);
    VAR I:LONGINT;
  BEGIN
    FOR I := 0 TO LEN(Arr)-1 DO
      Out.Int(Arr[I],0);
      Out.Char(' ');
    END;
    Out.Ln;
  END PrintArray;

  PROCEDURE MoveZero(VAR Arr:ARRAY OF INTEGER);
    VAR I,Count:LONGINT;
  BEGIN
    Count := 0;
    FOR I := 0 TO LEN(Arr)-1 DO
      IF Arr[I] # 0 THEN Arr[Count] := Arr[I]; INC(Count) END;
    END;
    WHILE Count < LEN(Arr) DO Arr[Count] := 0; INC(Count) END;
  END MoveZero;
  
BEGIN
  Init;
  MoveZero(A1);
  MoveZero(A2);
  MoveZero(A3);
  PrintArray(A1);
  PrintArray(A2);
  PrintArray(A3);
END Ch1.

