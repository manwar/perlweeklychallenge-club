MODULE Ch1 EXPORTS Main;

IMPORT IO;

VAR
  A1:ARRAY[0..3] OF CHAR := ARRAY OF CHAR{'e','m','u','g'};
  A2:ARRAY[0..3] OF CHAR := ARRAY OF CHAR{'d','c','e','f'};
  A3:ARRAY[0..2] OF CHAR := ARRAY OF CHAR{'j','a','r'};
  A4:ARRAY[0..3] OF CHAR := ARRAY OF CHAR{'d','c','a','f'};
  A5:ARRAY[0..3] OF CHAR := ARRAY OF CHAR{'t','g','a','l'};
  
PROCEDURE QuickSort(VAR A:ARRAY OF CHAR;Left,Right:INTEGER) = 
  VAR
    I,J:INTEGER;
    Pivot,Temp:CHAR;
  BEGIN
    I := Left;
    J := Right;
    Pivot := A[(Left + Right) DIV 2];
    REPEAT
      WHILE ORD(Pivot) > ORD(A[I]) DO INC(I) END;
      WHILE ORD(Pivot) < ORD(A[J]) DO DEC(J) END;
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

PROCEDURE GreaterCharacter(VAR A:ARRAY OF CHAR;Target:CHAR):CHAR =
  BEGIN
    QuickSort(A, 0, LAST(A));
    FOR I := FIRST(A) TO LAST(A) DO
      IF A[I] > Target THEN RETURN A[I] END;
    END;
    RETURN Target;
  END GreaterCharacter;
  
BEGIN
  IO.PutChar(GreaterCharacter(A1,'b')); IO.Put("\n");
  IO.PutChar(GreaterCharacter(A2,'a')); IO.Put("\n");
  IO.PutChar(GreaterCharacter(A3,'o')); IO.Put("\n");
  IO.PutChar(GreaterCharacter(A4,'a')); IO.Put("\n");
  IO.PutChar(GreaterCharacter(A5,'v')); IO.Put("\n");
END Ch1.

