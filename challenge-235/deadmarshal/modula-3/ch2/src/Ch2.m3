MODULE Ch2 EXPORTS Main;

IMPORT IO;

TYPE
  PArr = REF ARRAY OF INTEGER;

VAR
  A1:ARRAY[0..7] OF INTEGER := ARRAY OF INTEGER{1,0,2,3,0,4,5,0};
  A2:ARRAY[0..2] OF INTEGER := ARRAY OF INTEGER{1,2,3};
  A3:ARRAY[0..4] OF INTEGER := ARRAY OF INTEGER{0,3,0,4,5};
  Ret1,Ret2,Ret3:PArr;
  
PROCEDURE DuplicateZeros(VAR A:ARRAY OF INTEGER):PArr =
  VAR
    I,J:INTEGER := 0;
    Ret:PArr;
  BEGIN
    Ret := NEW(PArr,NUMBER(A));
    WHILE J <= LAST(A) DO
      IF A[I] = 0 THEN
        Ret[J] := 0; INC(J); Ret[J] := 0;
        INC(I); INC(J);
      ELSE
        Ret[J] := A[I]; INC(I); INC(J);
      END
    END;
    RETURN Ret
  END DuplicateZeros;

  PROCEDURE PrintArray(VAR A:ARRAY OF INTEGER) = 
    BEGIN
      FOR I := FIRST(A) TO LAST(A) DO IO.PutInt(A[I]); IO.PutChar(' ') END;
      IO.Put("\n");
    END PrintArray;
    
BEGIN
  Ret1 := DuplicateZeros(A1);
  Ret2 := DuplicateZeros(A2);
  Ret3 := DuplicateZeros(A3);
  PrintArray(Ret1^);
  PrintArray(Ret2^);
  PrintArray(Ret3^);
END Ch2.

