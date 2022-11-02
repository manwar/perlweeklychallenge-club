MODULE Ch1;

  IMPORT Out;

  VAR
    A1,A2,A4,A5:ARRAY 4 OF CHAR;
    A3:ARRAY 3 OF CHAR;

  PROCEDURE Init();
  BEGIN
    A1[0] := 'e'; A1[1] := 'm'; A1[2] := 'u'; A1[3] := 'g';
    A2[0] := 'd'; A2[1] := 'c'; A2[2] := 'e'; A2[3] := 'f';
    A3[0] := 'j'; A3[1] := 'a'; A3[2] := 'r';
    A4[0] := 'd'; A4[1] := 'c'; A4[2] := 'a'; A4[3] := 'f';
    A5[0] := 't'; A5[1] := 'g'; A5[2] := 'a'; A5[3] := 'l';
  END Init;

  PROCEDURE QuickSort(VAR A:ARRAY OF CHAR;Left,Right:LONGINT);
    VAR
      I,J:LONGINT;
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

  PROCEDURE GreaterCharacter(VAR A:ARRAY OF CHAR;Target:CHAR):CHAR;
    VAR
      I:LONGINT;
  BEGIN
    QuickSort(A, 0, LEN(A)-1);
    FOR I := 0 TO LEN(A)-1 DO
      IF A[I] > Target THEN RETURN A[I] END
    END;
    RETURN Target;
  END GreaterCharacter;
  
BEGIN
  Init;
  Out.Char(GreaterCharacter(A1,'b')); Out.Ln;
  Out.Char(GreaterCharacter(A2,'a')); Out.Ln;
  Out.Char(GreaterCharacter(A3,'o')); Out.Ln;
  Out.Char(GreaterCharacter(A4,'a')); Out.Ln;
  Out.Char(GreaterCharacter(A5,'v')); Out.Ln;
END Ch1.

