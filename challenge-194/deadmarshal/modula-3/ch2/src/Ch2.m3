MODULE Ch2 EXPORTS Main;

IMPORT SIO,Text;

PROCEDURE QuickSort(VAR A:ARRAY OF INTEGER;Left,Right:INTEGER) = 
  VAR
    I,J:INTEGER;
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

PROCEDURE FrequencyEqualizer(Str:TEXT):BOOLEAN = 
  VAR
    Freq:ARRAY[0..25] OF INTEGER;
    Arr:REF ARRAY OF INTEGER;
    J,Count:INTEGER;
  BEGIN
    J := 0;
    Count := 0;
    FOR I := FIRST(Freq) TO LAST(Freq) DO Freq[I] := 0 END;
    FOR I := 0 TO Text.Length(Str)-1 DO
      INC(Freq[ORD(Text.GetChar(Str,I)) - ORD('a')])
    END;
    FOR I := FIRST(Freq) TO LAST(Freq) DO IF Freq[I] # 0 THEN INC(Count) END END;
    Arr := NEW(REF ARRAY OF INTEGER,Count);
    <*ASSERT Arr # NIL *>
    FOR I := FIRST(Freq) TO LAST(Freq) DO
      IF Freq[I] # 0 THEN
        Arr[J] := Freq[I];
        INC(J);
      END
    END;
    QuickSort(Arr^,FIRST(Arr^),LAST(Arr^));
    IF(Arr[0] = Arr[1]+1) AND (Arr[LAST(Arr^)] = Arr[1]) THEN
      RETURN TRUE
    END;
    RETURN FALSE;
  END FrequencyEqualizer;
  
BEGIN
  SIO.PutBool(FrequencyEqualizer("abbc")); SIO.Nl();
  SIO.PutBool(FrequencyEqualizer("xyzyyxz")); SIO.Nl();
  SIO.PutBool(FrequencyEqualizer("xzxz")); SIO.Nl();
END Ch2.

