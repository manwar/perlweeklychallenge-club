MODULE Ch1 EXPORTS Main;

IMPORT IO,Fmt;

VAR
  A1:ARRAY[0..3] OF INTEGER := ARRAY OF INTEGER{1,2,3,4};
  A2:ARRAY[0..3] OF INTEGER := ARRAY OF INTEGER{1,2,0,5};
  A3:ARRAY[0..3] OF INTEGER := ARRAY OF INTEGER{2,6,3,1};
  A4:ARRAY[0..3] OF INTEGER := ARRAY OF INTEGER{4,5,2,3};  

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

PROCEDURE TwiceLargest(VAR A:ARRAY OF INTEGER):INTEGER =
  BEGIN
    QuickSort(A,FIRST(A),LAST(A));
    IF A[LAST(A)] >= (2 * A[LAST(A)-1]) THEN RETURN 1 END;
    RETURN -1;
  END TwiceLargest;
  
BEGIN
  IO.Put(Fmt.F("%2s\n",Fmt.Int(TwiceLargest(A1))));
  IO.Put(Fmt.F("%2s\n",Fmt.Int(TwiceLargest(A2))));
  IO.Put(Fmt.F("%2s\n",Fmt.Int(TwiceLargest(A3))));
  IO.Put(Fmt.F("%2s\n",Fmt.Int(TwiceLargest(A4))));
END Ch1.

