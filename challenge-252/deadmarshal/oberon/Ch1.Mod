MODULE Ch1;

IMPORT Out;

VAR 
  A1:ARRAY 4 OF LONGINT;
  A2:ARRAY 6 OF LONGINT;

PROCEDURE Init;
BEGIN
  A1[0] := 1; A1[1] := 2; A1[2] := 3; A1[3] := 4;
  A2[0] := 2; A2[1] := 7; A2[2] := 1; A2[3] := 19;
  A2[4] := 18; A2[5] := 3;
END Init;

PROCEDURE SpecialNumbers(VAR arr:ARRAY OF LONGINT):LONGINT;
VAR i,sum:LONGINT;
BEGIN
  sum := 0;
  FOR i := 0 TO LEN(arr)-1 DO 
    IF LEN(arr) MOD (i+1) = 0 THEN INC(sum,arr[i]*arr[i]) END
  END;
  RETURN sum
END SpecialNumbers;

BEGIN
  Init;
  Out.Int(SpecialNumbers(A1),0); Out.Ln;
  Out.Int(SpecialNumbers(A2),0); Out.Ln
END Ch1.

