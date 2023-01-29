MODULE Ch1;

  IMPORT Out;
    
  VAR
    A1:ARRAY 3 OF INTEGER;
    A2:ARRAY 2 OF INTEGER;
    
  PROCEDURE Init;
  BEGIN
    A1[0] := 0; A1[1] := 1; A1[2] := 3; 
    A2[0] := 0; A2[1] := 1;
  END Init;
  
  PROCEDURE MissingNumbers(VAR arr:ARRAY OF INTEGER);
    VAR
      i:LONGINT;
      hash:ARRAY 10 OF INTEGER;
  BEGIN
    FOR i := 0 TO 9 DO hash[i] := 0 END;
    FOR i := 0 TO LEN(arr)-1 DO hash[arr[i] MOD 10] := 1 END;
    FOR i := 0 TO LEN(arr) DO
      IF hash[i] # 1 THEN Out.Int(i,0); Out.Char(' ') END;
    END;
    Out.Ln;
  END MissingNumbers;

BEGIN
  Init;
  MissingNumbers(A1);
  MissingNumbers(A2);
END Ch1.

