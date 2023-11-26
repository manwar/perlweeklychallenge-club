MODULE Ch2;

  IMPORT Out;

  TYPE
    TProc = PROCEDURE(a,b:LONGINT):LONGINT;
      
  VAR
    A1:ARRAY 4 OF LONGINT;
    
  PROCEDURE Init;
  BEGIN
    A1[0] := 11; A1[1] := 8; A1[2] := 27; A1[3] := 4;
  END Init;
  
  PROCEDURE QuickSort(VAR arr:ARRAY OF LONGINT;left,right:LONGINT;comp:TProc);
    VAR i,j,pivot,temp:LONGINT;
  BEGIN
    i := left; j := right;
    pivot := arr[(left + right) DIV 2];
    REPEAT
      WHILE comp(pivot,arr[i]) > 0 DO INC(i) END;
      WHILE comp(pivot,arr[j]) < 0 DO DEC(j) END;
      IF i <= j THEN
	temp := arr[i]; arr[i] := arr[j]; arr[j] := temp;
	INC(i); DEC(j);
      END;
    UNTIL i > j;
    IF left < j THEN QuickSort(arr,left,j,comp) END;
    IF i < right THEN QuickSort(arr,i,right,comp) END;
  END QuickSort;

  PROCEDURE CountFactors(n:LONGINT):LONGINT;
    VAR c,count:LONGINT;
  BEGIN
    count := 0; c := 2;
    WHILE n > 1 DO
      IF n MOD c = 0 THEN n := n DIV c; INC(count) ELSE INC(c) END
    END;
    RETURN count
  END CountFactors;

  PROCEDURE compare(a,b:LONGINT):LONGINT;
    VAR fa,fb:LONGINT;
  BEGIN
    fa := CountFactors(a);
    fb := CountFactors(b);
    IF fa - fb = 0 THEN RETURN a - b ELSE RETURN fa - fb END
  END compare;

  PROCEDURE PrimeOrder(VAR arr:ARRAY OF LONGINT);
  BEGIN
    QuickSort(arr,0,LEN(arr)-1,compare);
  END PrimeOrder;

  PROCEDURE PrintArray(VAR arr:ARRAY OF LONGINT);
    VAR i:LONGINT;
  BEGIN
    FOR i := 0 TO LEN(arr)-1 DO Out.Int(arr[i],0); Out.Char(' ') END; Out.Ln
  END PrintArray;

BEGIN
  Init;
  PrimeOrder(A1);
  PrintArray(A1);
END Ch2.

