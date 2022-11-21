MODULE Ch2 EXPORTS Main;

IMPORT IO;
    
VAR
  A:ARRAY [0..1] OF INTEGER := ARRAY OF INTEGER{1,2};
  Count:INTEGER;
    
PROCEDURE IsCute(VAR Arr:ARRAY OF INTEGER):BOOLEAN = 
  BEGIN
    FOR I := 1 TO NUMBER(Arr) DO
      IF((I MOD Arr[I-1]) # 0) AND ((A[I-1] MOD I) # 0) THEN RETURN FALSE END
    END;
    RETURN TRUE;
  END IsCute;
  
PROCEDURE Swap(VAR A,B:INTEGER) = 
  VAR
    Temp:INTEGER;
  BEGIN
    Temp := A;
    A := B;
    B := Temp;
  END Swap;

PROCEDURE Permute(VAR Arr:ARRAY OF INTEGER;I,SZ:INTEGER;VAR Count:INTEGER) = 
  BEGIN
    IF SZ = I THEN IF IsCute(A) THEN INC(Count); RETURN END END;
    FOR J := I TO (SZ-1) DO
      Swap(Arr[I],Arr[J]);
      Permute(Arr,I+1,SZ,Count);
      Swap(Arr[I],Arr[J]);
    END;
    RETURN;
  END Permute;
 
BEGIN
  Count := 0;
  Permute(A,0,NUMBER(A),Count);
  IO.PutInt(Count); IO.Put("\n");
END Ch2.

