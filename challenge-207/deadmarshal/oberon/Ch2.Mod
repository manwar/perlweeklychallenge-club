MODULE Ch2;

  IMPORT Out;

  VAR
    A1,A2:ARRAY 5 OF INTEGER;

  PROCEDURE Init;
  BEGIN
    A1[0] := 10; A1[1] := 8; A1[2] := 5; A1[3] := 4; A1[4] := 3;
    A2[0] := 25; A2[1] := 8; A2[2] := 5; A2[3] := 3; A2[4] := 3;
  END Init;

  PROCEDURE HIndex(VAR A:ARRAY OF INTEGER):INTEGER;
    VAR
      i:LONGINT;
  BEGIN
    FOR i := 0 TO LEN(A)-1 DO
      IF i >= A[i] THEN RETURN SHORT(i) END
    END;
  END HIndex;
    
BEGIN
  Init;
  Out.Int(HIndex(A1),0); Out.Ln;
  Out.Int(HIndex(A2),0); Out.Ln;
END Ch2.

