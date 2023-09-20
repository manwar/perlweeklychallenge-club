MODULE Ch2;

  IMPORT Out;

  TYPE
    PArr = POINTER TO ARRAY OF LONGINT;
    
  VAR
    A1:ARRAY 8 OF LONGINT;
    A2:ARRAY 3 OF LONGINT;
    A3:ARRAY 5 OF LONGINT;
    ret1,ret2,ret3:PArr;
    
  PROCEDURE Init;
  BEGIN
    A1[0] := 1; A1[1] := 0; A1[2] := 2; A1[3] := 3;
    A1[4] := 0; A1[5] := 4; A1[6] := 5; A1[7] := 0; 
    A2[0] := 1; A2[1] := 2; A2[2] := 3; 
    A3[0] := 0; A3[1] := 3; A3[2] := 0;
    A3[3] := 4; A3[4] := 5; 
  END Init;

  PROCEDURE DuplicateZeros(VAR arr:ARRAY OF LONGINT):PArr;
    VAR
      ret:PArr;
      i,j:LONGINT;
  BEGIN
    NEW(ret,LEN(arr));
    i := 0; j := 0;
    WHILE j <= LEN(arr)-1 DO
      IF arr[i] = 0 THEN
	ret[j] := 0; INC(j); ret[j] := 0;
	INC(i); INC(j);
      ELSE
	ret[j] := arr[i]; INC(i); INC(j);
      END
    END;
    RETURN ret
  END DuplicateZeros;

  PROCEDURE PrintArray(VAR arr:ARRAY OF LONGINT);
    VAR i:LONGINT;
  BEGIN
    FOR i := 0 TO LEN(arr)-1 DO Out.Int(arr[i],0); Out.Char(' ') END;
    Out.Ln
  END PrintArray;
  
BEGIN
  Init;
  ret1 := DuplicateZeros(A1);
  ret2 := DuplicateZeros(A2);
  ret3 := DuplicateZeros(A3);
  PrintArray(ret1^);
  PrintArray(ret2^);
  PrintArray(ret3^);
END Ch2.

