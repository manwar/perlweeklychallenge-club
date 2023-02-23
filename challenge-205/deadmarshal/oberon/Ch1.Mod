MODULE Ch1;

  IMPORT Out;

  TYPE
    PArr = POINTER TO ARRAY OF INTEGER;
    
  VAR
    A1:ARRAY 3 OF INTEGER;
    A2:ARRAY 2 OF INTEGER;
    A3:ARRAY 4 OF INTEGER;
    
  PROCEDURE Init;
  BEGIN
    A1[0] := 5; A1[1] := 3; A1[2] := 4; 
    A2[0] := 5; A2[1] := 6; 
    A3[0] := 5; A3[1] := 4; A3[2] := 4; A3[3] := 3; 
  END Init;
   
  PROCEDURE QuickSort(VAR A:ARRAY OF INTEGER;Left,Right:LONGINT);
    VAR
      I,J:LONGINT;
      Pivot,Temp:INTEGER;
  BEGIN
    I := Left;
    J := Right;
    Pivot := A[(Left + Right) DIV 2];
    REPEAT
      WHILE Pivot < A[I] DO INC(I) END;
      WHILE Pivot > A[J] DO DEC(J) END;
      IF I <= J THEN
	Temp := A[I];
	A[I] := A[J];
	A[J] := Temp;
	INC(I);
	DEC(J);
      END;
    UNTIL I > J;
    IF Left < J THEN QuickSort(A, Left, J) END;
    IF I < Right THEN QuickSort(A, I, Right) END;
  END QuickSort;

  PROCEDURE Uniq(VAR arr:ARRAY OF INTEGER):PArr;
    VAR
      i,j,count:LONGINT;
      hash:ARRAY 10 OF INTEGER;
      ret:PArr;
  BEGIN
    count := 0;
    FOR i := 0 TO LEN(arr)-1 DO
      hash[arr[i] MOD 10] := 1;
    END;
    FOR i := 0 TO LEN(hash)-1 DO IF hash[i] = 1 THEN INC(count) END END;
    NEW(ret,count);
    j := 0;
    FOR i := 0 TO LEN(hash)-1 DO IF hash[i] = 1 THEN ret[j] := SHORT(i); INC(j) END END;
    RETURN ret;
  END Uniq;

  PROCEDURE ThirdHighest(VAR A:ARRAY OF INTEGER):INTEGER;
    VAR
      i:LONGINT;
      uniqs:PArr;
  BEGIN
    uniqs := Uniq(A);
    QuickSort(uniqs^,0,LEN(uniqs^)-1);
    IF LEN(uniqs^) < 3 THEN RETURN uniqs[0] ELSE RETURN uniqs[2] END;
  END ThirdHighest;
  
BEGIN
  Init;
  Out.Int(ThirdHighest(A1),0); Out.Ln;
  Out.Int(ThirdHighest(A2),0); Out.Ln;
  Out.Int(ThirdHighest(A3),0); Out.Ln;
END Ch1.

