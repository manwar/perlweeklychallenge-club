MODULE Ch2 EXPORTS Main;

IMPORT IO;

TYPE
  TProc = PROCEDURE(A,B:INTEGER):INTEGER;
  
VAR
  A1:ARRAY[0..3] OF INTEGER := ARRAY OF INTEGER{15,99,1,34};
  A2:ARRAY[0..3] OF INTEGER := ARRAY OF INTEGER{50,25,33,22};
  
PROCEDURE Helper(N:INTEGER):INTEGER = 
  VAR Sum:INTEGER := 0;
  PROCEDURE Product(N:INTEGER):INTEGER = 
    VAR P:INTEGER;
    BEGIN
      P := 1;
      WHILE N # 0 DO P := P * (N MOD 10); N := N DIV 10 END;
      RETURN P
    END Product;
  BEGIN
    REPEAT INC(Sum); N := Product(N) UNTIL N < 10;
    RETURN Sum
  END Helper; 
  
PROCEDURE Compare(A,B:INTEGER):INTEGER =
  VAR Ha,Hb:INTEGER;
  BEGIN
    Ha := Helper(A);
    Hb := Helper(B);
    IF Ha # Hb THEN
      IF Ha < Hb THEN RETURN -1 ELSE RETURN 1 END
    END;
    IF A < B THEN RETURN -1
    ELSIF A > B THEN RETURN 1
    ELSE RETURN 0
    END;
  END Compare;
  
PROCEDURE QuickSort(VAR A:ARRAY OF INTEGER;Left,Right:INTEGER;Comp:TProc) = 
  VAR
    I,J,Pivot,Temp:INTEGER;
  BEGIN
    I := Left; J := Right;
    Pivot := A[(Left + Right) DIV 2];
    REPEAT
      WHILE Comp(Pivot,A[I]) = 1 DO INC(I) END;
      WHILE Comp(Pivot,A[J]) = -1 DO DEC(J) END;
      IF I <= J THEN
        Temp := A[I];
        A[I] := A[J];
        A[J] := Temp;
        INC(I);
        DEC(J);
      END;
    UNTIL I > J;
    IF Left < J THEN QuickSort(A,Left,J,Comp) END;
    IF I < Right THEN QuickSort(A,I,Right,Comp) END;
  END QuickSort;
  
PROCEDURE PersistenceSort(VAR A:ARRAY OF INTEGER) =
  BEGIN
    QuickSort(A,FIRST(A),LAST(A),Compare);
  END PersistenceSort;

PROCEDURE PrintArray(VAR A:ARRAY OF INTEGER) = 
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO IO.PutInt(A[I]); IO.Put(" ") END;
    IO.Put("\n")
  END PrintArray;

BEGIN
  PersistenceSort(A1);
  PersistenceSort(A2);
  PrintArray(A1);
  PrintArray(A2);
END Ch2.

