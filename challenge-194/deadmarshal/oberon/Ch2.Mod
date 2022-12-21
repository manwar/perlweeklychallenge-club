MODULE Ch2;

  IMPORT Out;
  
  PROCEDURE QuickSort(VAR A:ARRAY OF INTEGER;Left,Right:LONGINT);
    VAR
      I,J:LONGINT;
      Pivot,Temp:INTEGER;
  BEGIN
    I := Left;
    J := Right;
    Pivot := A[(Left + Right) DIV 2];
    REPEAT
      WHILE Pivot < A[I] DO INC(I) END;
      WHILE Pivot > A[J] DO DEC(J) END;
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

  PROCEDURE FrequencyEqualizer(Str:ARRAY OF CHAR):LONGINT;
    VAR
      Freq:ARRAY 26 OF INTEGER;
      Arr:POINTER TO ARRAY OF INTEGER;
      Res,I,J,Count:LONGINT;
  BEGIN
    J := 0;
    Count := 0;
    FOR I := 0 TO LEN(Freq)-1 DO Freq[I] := 0 END;
    FOR I := 0 TO LEN(Str)-1 DO INC(Freq[ORD(Str[I]) - ORD('a')]) END;
    FOR I := 0 TO LEN(Freq)-1 DO IF Freq[I] # 0 THEN INC(Count) END END;
    NEW(Arr,Count);
    ASSERT(Arr # NIL);
    FOR I := 0 TO LEN(Freq)-1 DO
      IF Freq[I] # 0 THEN
	Arr[J] := Freq[I];
	INC(J);
      END
    END;
    QuickSort(Arr^,0,LEN(Arr^)-1);
    IF(Arr[0] = Arr[1]+1) & (Arr[LEN(Arr^)-1] = Arr[1]) THEN
      Res := 1
    ELSE
      Res := 0
    END;
    RETURN Res;
  END FrequencyEqualizer;
  
BEGIN
  Out.Int(FrequencyEqualizer('abbc'),0); Out.Ln;
  Out.Int(FrequencyEqualizer('xyzyyxz'),0); Out.Ln;
  Out.Int(FrequencyEqualizer('xzxz'),0); Out.Ln;
END Ch2.

