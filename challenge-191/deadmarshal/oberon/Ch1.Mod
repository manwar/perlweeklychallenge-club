MODULE Ch1;

  IMPORT Out;
    
  VAR
    A1,A2,A3,A4:ARRAY 4 OF INTEGER;
    
  PROCEDURE Init();
  BEGIN
    A1[0] := 1; A1[1] := 2; A1[2] := 3; A1[3] := 4;
    A2[0] := 1; A2[1] := 2; A2[2] := 0; A2[3] := 5;
    A3[0] := 2; A3[1] := 6; A3[2] := 3; A3[3] := 1;
    A4[0] := 4; A4[1] := 5; A4[2] := 2; A4[3] := 3;
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

  PROCEDURE TwiceLargest(VAR A:ARRAY OF INTEGER):INTEGER;
  BEGIN
    QuickSort(A,0,LEN(A)-1);
    IF A[LEN(A)-1] >= (2 * A[LEN(A)-2]) THEN RETURN 1 END;
    RETURN -1;
  END TwiceLargest;
  
BEGIN
  Init;
  Out.Int(TwiceLargest(A1),2); Out.Ln;
  Out.Int(TwiceLargest(A2),2); Out.Ln;
  Out.Int(TwiceLargest(A3),2); Out.Ln;
  Out.Int(TwiceLargest(A4),2); Out.Ln;
END Ch1.

