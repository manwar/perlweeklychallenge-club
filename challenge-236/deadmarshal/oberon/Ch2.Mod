MODULE Ch2;

  IMPORT Out;

  VAR
    A1,A2,A3:ARRAY 20 OF LONGINT;
    
  PROCEDURE Init;
  BEGIN
    A1[0] := 4; A1[1] := 6; A1[2] := 3; A1[3] := 8; A1[4] := 15;
    A1[5] := 0; A1[6] := 13; A1[7] := 18; A1[8] := 7; A1[9] := 16;
    A1[10] := 14; A1[11] := 19; A1[12] := 17; A1[13] := 5; A1[14] := 11;
    A1[15] := 1; A1[16] := 12; A1[17] := 2; A1[18] := 9; A1[19] := 10;
    A2[0] := 0; A2[1] := 1; A2[2] := 13; A2[3] := 7; A2[4] := 6;
    A2[5] := 8; A2[6] := 10; A2[7] := 11; A2[8] := 2; A2[9] := 14;
    A2[10] := 16; A2[11] := 4; A2[12] := 12; A2[13] := 9; A2[14] := 17;
    A2[15] := 5; A2[16] := 3; A2[17] := 18; A2[18] := 15; A2[19] := 19;
    A3[0] := 9; A3[1] := 8; A3[2] := 3; A3[3] := 11; A3[4] := 5; A3[5] := 7;
    A3[6] := 13; A3[7] := 19; A3[8] := 12; A3[9] := 4; A3[10] := 14;
    A3[11] := 10; A3[12] := 18; A3[13] := 2; A3[14] := 16; A3[15] := 1;
    A3[16] := 0; A3[17] := 15; A3[18] := 6; A3[19] := 17; 
  END Init;
  
  PROCEDURE ArrayLoops(VAR arr:ARRAY OF LONGINT):LONGINT;
    VAR
      i,count:LONGINT;
      indices:POINTER TO ARRAY OF LONGINT;
  BEGIN
    count := 0;
    NEW(indices,LEN(arr));
    FOR i := 0 TO LEN(indices^)-1 DO indices[i] := -1 END;
    FOR i := 0 TO LEN(arr)-1 DO
      IF indices[i] = -1 THEN
	INC(count);
	WHILE indices[i] = -1 DO
	  indices[i] := 1;
	  i := arr[i];
	END
      END;
    END;
    RETURN count
  END ArrayLoops;

BEGIN
  Init;
  Out.Int(ArrayLoops(A1),0); Out.Ln;
  Out.Int(ArrayLoops(A2),0); Out.Ln;
  Out.Int(ArrayLoops(A3),0); Out.Ln;
END Ch2.

