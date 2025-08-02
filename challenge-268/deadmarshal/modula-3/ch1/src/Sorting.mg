GENERIC MODULE Sorting(Elem);

PROCEDURE Swap(VAR A,B:Elem.T) =
  VAR Temp:Elem.T := A;
  BEGIN
    A := B;
    B := Temp
  END Swap;
  
PROCEDURE QuickSort(VAR A:ARRAY OF Elem.T;Left,Right:INTEGER) =
  VAR
    I,J:INTEGER;
    Pivot:Elem.T;
  BEGIN
    I := Left; J := Right;
    Pivot := A[(Left+Right) DIV 2];
    REPEAT
      WHILE Elem.Compare(Pivot,A[I]) > 0 DO INC(I) END;
      WHILE Elem.Compare(Pivot,A[J]) < 0 DO DEC(J) END;
      IF I <= J THEN
        Swap(A[I],A[J]);
        INC(I); DEC(J)
      END;
    UNTIL I > J;
    IF Left < J THEN QuickSort(A,Left,J) END;
    IF I < Right THEN QuickSort(A,I,Right) END
  END QuickSort;
   
BEGIN
END Sorting.

