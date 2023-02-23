MODULE Ch2;

  IMPORT Out,SYSTEM;
    
  VAR
    A1:ARRAY 7 OF LONGINT;
    A2:ARRAY 4 OF LONGINT;
    A3:ARRAY 5 OF LONGINT;
    
  PROCEDURE Init;
  BEGIN
    A1[0] := 1;  A1[1] := 2; A1[2] := 3; A1[3] := 4;
    A1[4] := 5;  A1[5] := 6; A1[6] := 7;
    A2[0] := 2;  A2[1] := 4; A2[2] := 1; A2[3] := 3;
    A3[0] := 10; A3[1] := 5; A3[2] := 7; A3[3] := 12; A3[4] := 8;
  END Init;

  PROCEDURE Xor(a,b:LONGINT):LONGINT;
    VAR
      x,y:SET;
  BEGIN
    x := SYSTEM.VAL(SET,a);
    y := SYSTEM.VAL(SET,b);
    RETURN SYSTEM.VAL(LONGINT,x/y);
  END Xor;

  PROCEDURE MaximumXor(VAR arr:ARRAY OF LONGINT):LONGINT;
    VAR
      i,j,max:LONGINT;
  BEGIN
    max := 0;
    FOR i := 0 TO LEN(arr)-1 DO
      FOR j := 0 TO LEN(arr)-1 DO
	IF max < Xor(arr[i],arr[j]) THEN max := Xor(arr[i],arr[j]) END
      END
    END;
    RETURN max;
  END MaximumXor;
  
BEGIN
  Init;
  Out.Int(MaximumXor(A1),0); Out.Ln;
  Out.Int(MaximumXor(A2),0); Out.Ln;
  Out.Int(MaximumXor(A3),0); Out.Ln;
END Ch2.

