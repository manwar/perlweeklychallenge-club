MODULE Ch2;

  IMPORT Out;

  TYPE
    TProc = PROCEDURE(a,b:LONGINT):LONGINT;
    
  VAR
    A1,A2:ARRAY 4 OF LONGINT;

  PROCEDURE Init;
  BEGIN
    A1[0] := 15; A1[1] := 99; A1[2] := 1; A1[3] := 34; 
    A2[0] := 50; A2[1] := 25; A2[2] := 33; A2[3] := 22; 
  END Init;

  PROCEDURE Helper(n:LONGINT):LONGINT;
    VAR sum:LONGINT;
    PROCEDURE Product(n:LONGINT):LONGINT;
      VAR p:LONGINT;
    BEGIN
      p := 1;
      WHILE n # 0 DO p := p * (n MOD 10); n := n DIV 10 END;
      RETURN p
    END Product;
  BEGIN
    sum := 0;
    REPEAT INC(sum); n := Product(n) UNTIL n < 10;
    RETURN sum
  END Helper; 

  PROCEDURE Compare(a,b:LONGINT):LONGINT;
    VAR ha,hb:LONGINT;
  BEGIN
    ha := Helper(a);
    hb := Helper(b);
    IF ha # hb THEN
      IF ha < hb THEN RETURN -1 ELSE RETURN 1 END
    END;
    IF a < b THEN RETURN -1
    ELSIF a > b THEN RETURN 1
    ELSE RETURN 0
    END;
  END Compare;
  
  PROCEDURE QuickSort(VAR arr:ARRAY OF LONGINT;left,right:LONGINT;comp:TProc);
    VAR
      i,j,pivot,temp:LONGINT;
  BEGIN
    i := left; j := right;
    pivot := arr[(left + right) DIV 2];
    REPEAT
      WHILE comp(pivot,arr[i]) = 1 DO INC(i) END;
      WHILE comp(pivot,arr[j]) = -1 DO DEC(j) END;
      IF i <= j THEN
	temp := arr[i]; arr[i] := arr[j]; arr[j] := temp;
	INC(i); DEC(j);
      END;
    UNTIL i > j;
    IF left < j THEN QuickSort(arr,left,j,comp) END;
    IF i < right THEN QuickSort(arr,i,right,comp) END;
  END QuickSort;
  
  PROCEDURE PrintArray(VAR arr:ARRAY OF LONGINT);
    VAR i:LONGINT;
  BEGIN
    FOR i := 0 TO LEN(arr)-1 DO Out.Int(arr[i],0); Out.Char(' ') END; Out.Ln
  END PrintArray;
  
  PROCEDURE PersistenceSort(VAR arr:ARRAY OF LONGINT);
  BEGIN
    QuickSort(arr,0,LEN(arr)-1,Compare);
  END PersistenceSort;

BEGIN
  Init;
  PersistenceSort(A1);
  PersistenceSort(A2);
  PrintArray(A1);
  PrintArray(A2);
END Ch2.

