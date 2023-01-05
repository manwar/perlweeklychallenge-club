MODULE Ch1;

  IMPORT Out;

  VAR
    A1:ARRAY 4 OF INTEGER;
    A2:ARRAY 1 OF INTEGER;
    
  PROCEDURE Init;
  BEGIN
    A1[0] := 2; A1[1] := 5; A1[2] := 8; A1[3] := 1;
    A2[0] := 3;
  END Init;
    
  PROCEDURE QuickSort(VAR A:ARRAY OF INTEGER;Left,Right:LONGINT);
    VAR
      I,J:LONGINT;
      Pivot,Temp:INTEGER;
  BEGIN
    I := Left;
    J := Right;
    Pivot := A[(Left + Right) DIV 2];
    REPEAT
      WHILE Pivot > A[I] DO INC(I) END;
      WHILE Pivot < A[J] DO DEC(J) END;
      IF I <= J THEN
	Temp := A[I];
	A[I] := A[J];
	A[J] := Temp;
	INC(I);
	DEC(J);
      END;
    UNTIL I > J;
    IF Left < J THEN QuickSort(A, Left, J) END;
    IF I < Right THEN QuickSort(A, I, Right) END;
  END QuickSort;

  PROCEDURE MaxGap(VAR Arr:ARRAY OF INTEGER):INTEGER;
    VAR
      I:LONGINT;
      Temp,Count,Max:INTEGER;
  BEGIN
    IF LEN(Arr) < 2 THEN RETURN 0 END;
    Count := 0;
    Max := 0;
    QuickSort(Arr,0,LEN(Arr)-1);
    FOR I := 0 TO LEN(Arr)-1 BY 2 DO
      Temp := ABS(Arr[I] - Arr[I+1]);
      IF Temp > Max THEN Max := Temp END;
    END;
    FOR I := 0 TO LEN(Arr)-2 DO
      IF ABS(Arr[I] - Arr[I+1]) = Max THEN INC(Count) END;
    END;
    RETURN Count;
  END MaxGap;
  
BEGIN
  Init;
  Out.Int(MaxGap(A1),0); Out.Ln; 
  Out.Int(MaxGap(A2),0); Out.Ln;
END Ch1.

