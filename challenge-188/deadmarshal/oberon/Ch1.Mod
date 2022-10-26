MODULE Ch1;

  IMPORT Out;

  VAR
    A1,A2,A3,A4,A5:ARRAY 4 OF INTEGER;
    
  PROCEDURE Init();
  BEGIN
    A1[0] := 4; A1[1] := 5; A1[2] := 1; A1[3] := 6;
    A2[0] := 1; A2[1] := 2; A2[2] := 3; A2[3] := 4;
    A3[0] := 1; A3[1] := 3; A3[2] := 4; A3[3] := 5;
    A4[0] := 5; A4[1] := 1; A4[2] := 2; A4[3] := 3;
    A5[0] := 7; A5[1] := 2; A5[2] := 4; A5[3] := 2;
  END Init;

  PROCEDURE DivisiblePairs(VAR A:ARRAY OF INTEGER; K:INTEGER):LONGINT;
    VAR
      I,J,Count:LONGINT;
  BEGIN
    Count := 0;
    FOR I := 0 TO LEN(A)-1 DO
      FOR J := I+1 TO LEN(A)-1 DO
	IF (A[I] + A[J]) MOD K = 0 THEN INC(Count) END
      END
    END;
    RETURN Count;
  END DivisiblePairs;
  
BEGIN
  Init();
  Out.Int(DivisiblePairs(A1,2),0); Out.Ln;
  Out.Int(DivisiblePairs(A2,2),0); Out.Ln;
  Out.Int(DivisiblePairs(A3,3),0); Out.Ln;
  Out.Int(DivisiblePairs(A4,4),0); Out.Ln;
  Out.Int(DivisiblePairs(A5,4),0); Out.Ln;
END Ch1.

