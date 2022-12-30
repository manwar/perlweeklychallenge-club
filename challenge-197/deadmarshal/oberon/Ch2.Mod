MODULE Ch2;

  IMPORT Out;

  VAR
    I:LONGINT;
    A1,A2,A3:ARRAY 6 OF INTEGER;
    
  PROCEDURE Swap(VAR A,B:INTEGER);
    VAR Temp:INTEGER;
  BEGIN
    Temp := A;
    A := B;
    B := Temp;
  END Swap;

  PROCEDURE Init;
  BEGIN
    A1[0] := 1; A1[1] := 5; A1[2] := 1; A1[3] := 1; A1[4] := 6; A1[5] := 4;
    A2[0] := 1; A2[1] := 3; A2[2] := 2; A2[3] := 2; A2[4] := 3; A2[5] := 1;
  END Init;
  
  PROCEDURE WiggleSort(VAR Arr:ARRAY OF INTEGER);
    VAR I:LONGINT;
  BEGIN
    FOR I := 0 TO LEN(Arr)-2 DO
      IF(~(ODD(I)) = (Arr[I] > Arr[I+1])) THEN
	Swap(Arr[I],Arr[I+1]);
      END;
    END;
  END WiggleSort;
 
BEGIN
  Init;
  WiggleSort(A1);
  WiggleSort(A2);
  FOR I := 0 TO LEN(A1)-1 DO
    Out.Int(A1[I],0);
    Out.Char(' ');
  END;
  Out.Ln;
  FOR I := 0 TO LEN(A2)-1 DO
    Out.Int(A2[I],0);
    Out.Char(' ');
  END;
  Out.Ln;
END Ch2.

