MODULE Ch2;

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

PROCEDURE UniqueZeroSum(n:LONGINT);
VAR i:LONGINT;
BEGIN
  FOR i := 1 TO n DIV 2 DO 
    Out.Int(i,0); Out.Char(' ');
    Out.Int(-i,0); Out.Char(' ')
  END;
  IF n MOD 2 = 1 THEN Out.Int(0,0); Out.Char(' ') END;
  Out.Ln
END UniqueZeroSum;

BEGIN
  UniqueZeroSum(5);
  UniqueZeroSum(3);
  UniqueZeroSum(1);
END Ch2.

