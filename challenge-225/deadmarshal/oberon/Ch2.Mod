MODULE Ch2;

  IMPORT Out;

  VAR
    A1:ARRAY 4 OF LONGINT;
    A2:ARRAY 1 OF LONGINT;
    A3:ARRAY 5 OF LONGINT;
    
  PROCEDURE Init;
  BEGIN
    A1[0] := 10; A1[1] := 4; A1[2] := 8; A1[3] := 3;
    A2[0] := 1;
    A3[0] := 1; A3[1] := 2; A3[2] := 3; A3[3] := 4; A3[4] := 5;
  END Init;

  PROCEDURE LeftRightSumDiff(VAR arr:ARRAY OF LONGINT);
    VAR
      i:LONGINT;
      left,right:LONGINT;
  BEGIN
    left := 0; right := 0;
    FOR i := 1 TO LEN(arr)-1 DO INC(right, arr[i]) END;
    FOR i := 0 TO LEN(arr)-1 DO
      Out.Int(ABS(left - right),0);
      Out.Char(' ');
      INC(left,arr[i]);
      IF i < LEN(arr)-1 THEN DEC(right,arr[i+1]) END
    END;
    Out.Ln
  END LeftRightSumDiff;

BEGIN 
  Init;
  LeftRightSumDiff(A1);
  LeftRightSumDiff(A2);
  LeftRightSumDiff(A3);
END Ch2.

