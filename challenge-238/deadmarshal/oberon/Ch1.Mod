MODULE Ch1;

  IMPORT Out;

  VAR
    A1,A2:ARRAY 5 OF LONGINT;
    A3:ARRAY 4 OF LONGINT;
    
  PROCEDURE Init;
  BEGIN
    A1[0] := 1; A1[1] := 2; A1[2] := 3; A1[3] := 4; A1[4] := 5;
    A2[0] := 1; A2[1] := 1; A2[2] := 1; A2[3] := 1; A2[4] := 1;
    A3[0] := 0; A3[1] := -1; A3[2] := 1; A3[3] := 2;
  END Init;

  PROCEDURE RunningSum(VAR arr:ARRAY OF LONGINT);
    VAR sum,i:LONGINT;
  BEGIN
    sum := 0;
    FOR i := 0 TO LEN(arr)-1 DO
      INC(sum,arr[i]);
      Out.Int(sum,0); Out.Char(' ')
    END;
    Out.Ln
  END RunningSum;
  
BEGIN
  Init;
  RunningSum(A1);
  RunningSum(A2);
  RunningSum(A3);
END Ch1.

