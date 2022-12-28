MODULE Ch2 EXPORTS Main;

IMPORT IO;

VAR
  A1:ARRAY[0..5] OF INTEGER := ARRAY OF INTEGER{1,5,1,1,6,4};
  A2:ARRAY[0..5] OF INTEGER := ARRAY OF INTEGER{1,3,2,2,3,1};
  
PROCEDURE Swap(VAR A,B:INTEGER) = 
  VAR Temp:INTEGER := A;
  BEGIN
    A := B;
    B := Temp;
  END Swap;

PROCEDURE PrintArray(VAR Arr:ARRAY OF INTEGER) = 
  BEGIN
    FOR I := FIRST(Arr) TO LAST(Arr) DO
      IO.PutInt(Arr[I]); IO.PutChar(' ');
    END;
    IO.Put("\n");
  END PrintArray;
  
PROCEDURE WiggleSort(VAR Arr:ARRAY OF INTEGER) = 
  BEGIN
    FOR I := FIRST(Arr) TO LAST(Arr)-1 DO
      IF((I MOD 2 = 0) = (Arr[I] > Arr[I+1])) THEN Swap(Arr[I],Arr[I+1]); END;
    END;
  END WiggleSort;
  
BEGIN
  WiggleSort(A1);
  WiggleSort(A2);
  PrintArray(A1);
  PrintArray(A2);
END Ch2.

