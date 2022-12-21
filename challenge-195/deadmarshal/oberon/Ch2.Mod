MODULE Ch2;

  IMPORT Out;
    
  VAR
    A1,A3:ARRAY 5 OF INTEGER;
    A2:ARRAY 4 OF INTEGER;
    
  PROCEDURE Init();
  BEGIN
    A1[0] := 1; A1[1] := 1; A1[2] := 2; A1[3] := 6; A1[4] := 2;
    A2[0] := 1; A2[1] := 3; A2[2] := 5; A2[3] := 7;
    A3[0] := 6; A3[1] := 4; A3[2] := 4; A3[3] := 6; A3[4] := 1;
  END Init;

  PROCEDURE AllOdd(VAR Arr:ARRAY OF INTEGER):BOOLEAN;
    VAR I:LONGINT;
  BEGIN
    FOR I := 0 TO LEN(Arr)-1 DO 
      IF ~ODD(Arr[I]) THEN RETURN FALSE END
    END;
    RETURN TRUE;
  END AllOdd;
  
  PROCEDURE MostFrequentEven(VAR Arr:ARRAY OF INTEGER):INTEGER;
    VAR
      I,J:LONGINT;
      Counts:ARRAY 10 OF INTEGER;
      MaxKey:INTEGER;
  BEGIN
    IF AllOdd(Arr) THEN RETURN -1 END;
    FOR I := 0 TO LEN(Counts)-1 DO Counts[I] := 0 END;
    FOR I := 0 TO LEN(Arr)-1 DO
      IF ~ODD(Arr[I]) THEN
	INC(Counts[Arr[I]])
      END
    END;
    MaxKey := Counts[0];
    FOR I := 1 TO LEN(Counts)-1 DO
      IF Counts[I] > MaxKey THEN
	MaxKey := SHORT(I);
      END
    END;
    RETURN MaxKey;
  END MostFrequentEven;
  
BEGIN
  Init;
  Out.Int(MostFrequentEven(A1),0); Out.Ln;
  Out.Int(MostFrequentEven(A2),0); Out.Ln;
  Out.Int(MostFrequentEven(A3),0); Out.Ln;
END Ch2.

