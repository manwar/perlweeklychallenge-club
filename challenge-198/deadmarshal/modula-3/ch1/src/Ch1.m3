MODULE Ch1 EXPORTS Main;

IMPORT IO;

VAR
  A1:ARRAY[0..3] OF INTEGER := ARRAY OF INTEGER{2,5,8,1};
  A2:ARRAY[0..0] OF INTEGER := ARRAY OF INTEGER{3};
    
PROCEDURE QuickSort(VAR A:ARRAY OF INTEGER;Left,Right:INTEGER) = 
  VAR
    I,J:INTEGER;
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
  
PROCEDURE MaxGap(VAR Arr:ARRAY OF INTEGER):INTEGER = 
  VAR
    Temp,Count,Max:INTEGER;
  BEGIN
    IF NUMBER(Arr) < 2 THEN RETURN 0 END;
    Count := 0;
    Max := 0;
    QuickSort(Arr,0,LAST(Arr));
    FOR I := FIRST(Arr) TO LAST(Arr) BY 2 DO
      Temp := ABS(Arr[I] - Arr[I+1]);
      IF Temp > Max THEN Max := Temp END;
    END;
    FOR I := FIRST(Arr) TO LAST(Arr)-1 DO
      IF ABS(Arr[I] - Arr[I+1]) = Max THEN INC(Count) END;
    END;
    RETURN Count;
  END MaxGap;
  
BEGIN
  IO.PutInt(MaxGap(A1)); IO.Put("\n");
  IO.PutInt(MaxGap(A2)); IO.Put("\n");
END Ch1.

