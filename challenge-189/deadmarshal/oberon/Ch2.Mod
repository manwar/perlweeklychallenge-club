MODULE Ch2;

  IMPORT Out;

  VAR
    A1,A2:ARRAY 4 OF INTEGER;
    A3,A4,A5:ARRAY 5 OF INTEGER;
    
  PROCEDURE Init();
  BEGIN
    A1[0] := 1; A1[1] := 3; A1[2] := 3; A1[3] := 2;
    A2[0] := 1; A2[1] := 2; A2[2] := 1; A2[3] := 3;
    A3[0] := 1; A3[1] := 3; A3[2] := 2; A3[3] := 1; A3[4] := 2;
    A4[0] := 1; A4[1] := 1; A4[2] := 2; A4[3] := 3; A4[4] := 2;
    A5[0] := 2; A5[1] := 1; A5[2] := 2; A5[3] := 1; A5[4] := 1;
  END Init;
  
  PROCEDURE ArrayDegree(VAR Arr:ARRAY OF INTEGER);
    VAR
      Left,Count:ARRAY 10 OF INTEGER;
      I,X,Min,Max,Index:LONGINT;
  BEGIN
    Min := 0; Max := 0; Index := 0;
    FOR I := 0 TO LEN(Left)-1 DO Left[I] := 0 END;
    FOR I := 0 TO LEN(Count)-1 DO Count[I] := 0 END;
    FOR I := 0 TO LEN(Arr)-1 DO
      X := Arr[I];
      IF Count[X] = 0 THEN
	Left[X] := SHORT(I);
	Count[X] := 1;
      ELSE
	Count[X] := Count[X] + 1;
      END;
      IF Count[X] > Max THEN
	Max := Count[X];
	Min := I - Left[X] + 1;
	Index := Left[X];
      ELSIF((Count[X] = Max) & (I - Left[X] + 1 < Min)) THEN
	Min := I - Left[X] + 1;
	Index := Left[X];
      END;
    END;

    FOR I := Index TO (Index+Min)-1 DO
      Out.Int(Arr[I],0);
      Out.Char(' ');
    END;
    Out.Ln;
  END ArrayDegree;
  
BEGIN
  Init;
  ArrayDegree(A1);
  ArrayDegree(A2);
  ArrayDegree(A3);
  ArrayDegree(A4);
  ArrayDegree(A5);
END Ch2.

