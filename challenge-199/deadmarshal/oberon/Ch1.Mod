MODULE Ch1;

  IMPORT Out;

  VAR
    A1:ARRAY 6 OF INTEGER;
    A2:ARRAY 3 OF INTEGER;
    A3:ARRAY 4 OF INTEGER;
    
  PROCEDURE Init;
  BEGIN
    A1[0] := 1; A1[1] := 2; A1[2] := 3; A1[3] := 1; A1[4] := 1; A1[5] := 3;
    A2[0] := 1; A2[1] := 2; A2[2] := 3;
    A3[0] := 1; A3[1] := 1; A3[2] := 1; A3[3] := 1;
  END Init;

  PROCEDURE GoodPairs(VAR Arr:ARRAY OF INTEGER):LONGINT;
    VAR
      I,J,Count:LONGINT;
  BEGIN
    Count := 0;
    FOR I := 0 TO LEN(Arr)-1 DO
      FOR J := I+1 TO LEN(Arr)-1 DO
	IF Arr[I] = Arr[J] THEN INC(Count) END;
      END
    END;
    RETURN Count;
  END GoodPairs;
  
BEGIN
  Init;
  Out.Int(GoodPairs(A1),0); Out.Ln;
  Out.Int(GoodPairs(A2),0); Out.Ln;
  Out.Int(GoodPairs(A3),0); Out.Ln;
END Ch1.

