MODULE Ch1;

  IMPORT Out;

  VAR
    A1:ARRAY 5 OF LONGINT;
    A2:ARRAY 4 OF LONGINT;
    A3:ARRAY 3 OF LONGINT;
    
  PROCEDURE Init;
  BEGIN
    A1[0] := 0; A1[1] := 2; A1[2] := 9; A1[3] := 4; A1[4] := 5;
    A2[0] := 5; A2[1] := 1; A2[2] := 3; A2[3] := 2;
    A3[0] := 2; A3[1] := 2; A3[2] := 3;
  END Init;

  PROCEDURE RemoveOne(VAR arr:ARRAY OF LONGINT):LONGINT;
    VAR
      i,c1,c2,idx1,idx2:LONGINT;
  BEGIN
    c1 := 0; c2 := 0;
    idx1 := -1; idx2 := -1;
    FOR i := 1 TO LEN(arr)-1 DO
      IF arr[i] <= arr[i-1] THEN INC(c1); idx1 := i-1 END
    END;
    FOR i := LEN(arr)-2 TO 1 BY -1 DO
      IF arr[i] >= arr[i+1] THEN INC(c2); idx2 := i+1 END
    END;
    IF (c1 = 1) & (c2 = 1) & ((idx2 - idx1 + 1) = 2) THEN RETURN 1 END;
    IF (c1 > 1) OR (c2 > 1) THEN RETURN 0 END;
    RETURN 1
  END RemoveOne;

BEGIN
  Init;
  Out.Int(RemoveOne(A1),0); Out.Ln;
  Out.Int(RemoveOne(A2),0); Out.Ln;
  Out.Int(RemoveOne(A3),0); Out.Ln;
END Ch1.

