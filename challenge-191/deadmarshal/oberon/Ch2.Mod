MODULE Ch2;

  IMPORT Out;
    
  VAR
    A:ARRAY 2 OF INTEGER;
    Count:LONGINT;
    
  PROCEDURE Init();
  BEGIN
    A[0] := 1; A[1] := 2;
  END Init;

  PROCEDURE IsCute(VAR Arr:ARRAY OF INTEGER):BOOLEAN;
    VAR
      I:LONGINT;
  BEGIN
    FOR I := 1 TO LEN(Arr) DO
      IF((I MOD Arr[I-1]) # 0) & ((A[I-1] MOD I) # 0) THEN RETURN FALSE END
    END;
    RETURN TRUE;
  END IsCute;

  PROCEDURE Swap(VAR A,B:INTEGER);
    VAR
      Temp:INTEGER;
  BEGIN
    Temp := A;
    A := B;
    B := Temp;
  END Swap;

  PROCEDURE Permute(VAR Arr:ARRAY OF INTEGER;I,SZ:LONGINT;VAR Count:LONGINT);
    VAR
      J:LONGINT;
  BEGIN
    IF SZ = I THEN IF IsCute(A) THEN INC(Count); RETURN END END;
    FOR J := I TO SZ-1 DO
      Swap(Arr[I],Arr[J]);
      Permute(Arr,I+1,SZ,Count);
      Swap(Arr[I],Arr[J]);
    END;
    RETURN;
  END Permute;
 
BEGIN
  Init;
  Count := 0;
  Permute(A,0,LEN(A),Count);
  Out.Int(Count,0); Out.Ln;
END Ch2.

