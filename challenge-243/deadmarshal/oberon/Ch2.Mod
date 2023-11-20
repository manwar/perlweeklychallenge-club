MODULE Ch2;

  IMPORT Out;

  VAR
    A1:ARRAY 3 OF LONGINT;
    A2:ARRAY 7 OF LONGINT;
    
  PROCEDURE Init;
  BEGIN
    A1[0] := 2; A1[1] := 5; A1[2] := 9;
    A2[0] := 7; A2[1] := 7; A2[2] := 7;
    A2[3] := 7; A2[4] := 7; A2[5] := 7;
    A2[6] := 7;
  END Init;

  PROCEDURE FloorSum(VAR arr:ARRAY OF LONGINT):LONGINT;
    VAR i,j,sum:LONGINT;
  BEGIN
    sum := 0;
    FOR i := 0 TO LEN(arr)-1 DO
      FOR j := 0 TO LEN(arr)-1 DO INC(sum,arr[i] DIV arr[j]) END
    END;
    RETURN sum
  END FloorSum;
  
BEGIN
  Init;
  Out.Int(FloorSum(A1),0); Out.Ln;
  Out.Int(FloorSum(A2),0); Out.Ln
END Ch2.

