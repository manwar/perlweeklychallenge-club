MODULE Ch2 EXPORTS Main;

IMPORT IO;

TYPE
  TProc = PROCEDURE(A,B:INTEGER):INTEGER;

VAR
  A1:ARRAY[0..3] OF INTEGER := ARRAY OF INTEGER{11,8,27,4};
  
PROCEDURE QuickSort(VAR A:ARRAY OF INTEGER;
                    Left,Right:INTEGER;
                    Compare:TProc) =
  VAR
    I,J,Pivot,Temp:INTEGER;
  BEGIN
    I := Left; J := Right;
    Pivot := A[(Left + Right) DIV 2];
    REPEAT
      WHILE Compare(Pivot,A[I]) > 0 DO INC(I) END;
      WHILE Compare(Pivot,A[J]) < 0 DO DEC(J) END;
      IF I <= J THEN
        Temp := A[I]; A[I] := A[J]; A[J] := Temp;
        INC(I); DEC(J)
      END
    UNTIL I > J;
    IF Left < J THEN QuickSort(A,Left,J,Compare) END;
    IF I < Right THEN QuickSort(A,I,Right,Compare) END;
  END QuickSort;

PROCEDURE CountFactors(N:INTEGER):INTEGER =
  VAR C,Count:INTEGER;
  BEGIN
    Count := 0; C := 2;
    WHILE N > 1 DO
      IF N MOD C = 0 THEN N := N DIV C; INC(Count) ELSE INC(C) END
    END;
    RETURN Count
  END CountFactors;

PROCEDURE Compare(A,B:INTEGER):INTEGER =
  VAR
    Fa,Fb:INTEGER;
  BEGIN
    Fa := CountFactors(A);
    Fb := CountFactors(B);
    IF Fa - Fb = 0 THEN RETURN A - B ELSE RETURN Fa - Fb END
  END Compare;

PROCEDURE PrimeOrder(VAR A:ARRAY OF INTEGER) =
  BEGIN
    QuickSort(A,FIRST(A),LAST(A),Compare)
  END PrimeOrder;
  
PROCEDURE PrintArray(VAR A:ARRAY OF INTEGER) =
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO IO.PutInt(A[I]); IO.PutChar(' ') END;
    IO.Put("\n")
  END PrintArray;

BEGIN
  PrimeOrder(A1);
  PrintArray(A1)
END Ch2.

