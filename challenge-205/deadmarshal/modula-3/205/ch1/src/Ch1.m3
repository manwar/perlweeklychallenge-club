MODULE Ch1 EXPORTS Main;

IMPORT IO;

TYPE
  PArr = REF ARRAY OF INTEGER;
  
VAR
  A1:ARRAY[0..2] OF INTEGER := ARRAY OF INTEGER{5,3,4};
  A2:ARRAY[0..1] OF INTEGER := ARRAY OF INTEGER{5,6};
  A3:ARRAY[0..3] OF INTEGER := ARRAY OF INTEGER{5,4,4,3};
    
PROCEDURE QuickSort(VAR A:ARRAY OF INTEGER;Left,Right:INTEGER) = 
  VAR
    I,J:INTEGER;
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

PROCEDURE Uniq(VAR Arr:ARRAY OF INTEGER):PArr =
  VAR
    J,Count:INTEGER;
    Hash:ARRAY[0..9] OF INTEGER;
    Ret:PArr;
  BEGIN
    Count := 0;
    FOR I := FIRST(Arr) TO LAST(Arr) DO Hash[Arr[I] MOD 10] := 1 END;
    FOR I := FIRST(Hash) TO LAST(Hash) DO IF Hash[I] = 1 THEN INC(Count) END END;
    Ret := NEW(PArr,Count);
    J := 0;
    FOR I := FIRST(Hash) TO LAST(Hash) DO IF Hash[I] = 1 THEN Ret[J] := I; INC(J) END END;
    RETURN Ret
  END Uniq;
   
  PROCEDURE ThirdHighest(VAR A:ARRAY OF INTEGER):INTEGER = 
    VAR
      Uniqs:PArr;
  BEGIN
    Uniqs := Uniq(A);
    QuickSort(Uniqs^,FIRST(Uniqs^),LAST(Uniqs^));
    IF NUMBER(Uniqs^) < 3 THEN RETURN Uniqs[0] ELSE RETURN Uniqs[2] END;
  END ThirdHighest;
  
BEGIN
  IO.PutInt(ThirdHighest(A1)); IO.Put("\n");
  IO.PutInt(ThirdHighest(A2)); IO.Put("\n");
  IO.PutInt(ThirdHighest(A3)); IO.Put("\n");
END Ch1.

