MODULE Ch1;

  IMPORT Out;

  VAR
    A1,A2:ARRAY 5 OF LONGINT;
    
  PROCEDURE Init;
  BEGIN
    A1[0] := 1; A1[1] := 3; A1[2] := 2; A1[3] := 3; A1[4] := 1;
    A2[0] := 2; A2[1] := 4; A2[2] := 3; A2[3] := 5; A2[4] := 1;
  END Init;

  PROCEDURE ReversePairs(VAR arr:ARRAY OF LONGINT):LONGINT;
    VAR i,j,count:LONGINT;
  BEGIN
    count := 0;
    FOR i := 0 TO LEN(arr)-2 DO
      FOR j := i+1 TO LEN(arr)-1 DO
	IF arr[i] > (2 * arr[j]) THEN INC(count) END
      END
    END;
    RETURN count
  END ReversePairs;

BEGIN
  Init;
  Out.Int(ReversePairs(A1),0); Out.Ln;
  Out.Int(ReversePairs(A2),0); Out.Ln;
END Ch1.

