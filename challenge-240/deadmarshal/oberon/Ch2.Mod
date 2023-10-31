MODULE Ch2;

  IMPORT Out;

  TYPE
    PArr = POINTER TO ARRAY OF LONGINT;
    
  VAR
    A1,A2:ARRAY 6 OF LONGINT;
    Res1,Res2:PArr;
    
  PROCEDURE Init;
  BEGIN
    A1[0] := 0; A1[1] := 2; A1[2] := 1; A1[3] := 5; A1[4] := 3; A1[5] := 4;
    A2[0] := 5; A2[1] := 0; A2[2] := 1; A2[3] := 2; A2[4] := 3; A2[5] := 4;
  END Init;
  
  PROCEDURE BuildArray(VAR arr:ARRAY OF LONGINT):PArr;
    VAR
      i:LONGINT;
      ret:PArr;
  BEGIN
    NEW(ret,LEN(arr));
    FOR i := 0 TO LEN(arr)-1 DO ret[i] := arr[arr[i]] END;
    RETURN ret
  END BuildArray;

  PROCEDURE PrintArray(VAR arr:ARRAY OF LONGINT);
    VAR i:LONGINT;
  BEGIN
    FOR i := 0 TO LEN(arr)-1 DO Out.Int(arr[i],0); Out.Char(' ') END;
    Out.Ln
  END PrintArray;
  
BEGIN
  Init;
  Res1 := BuildArray(A1);
  Res2 := BuildArray(A2);
  PrintArray(Res1^);
  PrintArray(Res2^); 
END Ch2.

