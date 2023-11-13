MODULE Ch1;

  IMPORT Out;

  VAR
    A1,A2:ARRAY 6 OF LONGINT;
    
  PROCEDURE Init;
  BEGIN
    A1[0] := 0; A1[1] := 1; A1[2] := 4; A1[3] := 6; A1[4] := 7; A1[5] := 10;
    A2[0] := 4; A2[1] := 5; A2[2] := 6; A2[3] := 7; A2[4] := 8; A2[5] := 9;
  END Init;

  PROCEDURE ArithmeticTriplets(VAR arr:ARRAY OF LONGINT;diff:LONGINT):LONGINT;
    VAR i,j,k,count:LONGINT;
  BEGIN
    count := 0;
    FOR i := 0 TO LEN(arr)-1 DO
      FOR j := i+1 TO LEN(arr)-1 DO
	FOR k := j+1 TO LEN(arr)-1 DO
	  IF (arr[j] - arr[i] = diff) & (arr[k] - arr[j] = diff) THEN INC(count) END
	END
      END
    END;
    RETURN count
  END ArithmeticTriplets;
  
BEGIN
  Init;
  Out.Int(ArithmeticTriplets(A1,3),0); Out.Ln;
  Out.Int(ArithmeticTriplets(A2,2),0); Out.Ln;
END Ch1.

