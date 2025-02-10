MODULE Ch2 EXPORTS Main;

IMPORT SIO,Word;

TYPE
  PArr = REF ARRAY OF INTEGER;
  
VAR
  A1 := ARRAY[0..2] OF INTEGER{1,2,3};
  A2 := ARRAY[0..3] OF INTEGER{6,2,7,3};

PROCEDURE DecodeXor(VAR A:ARRAY OF INTEGER;
                    READONLY First:INTEGER):PArr =
  VAR
    Res := NEW(PArr,NUMBER(A)+1);
  BEGIN
    Res[0] := First;
    FOR I := FIRST(A) TO LAST(A) DO
      Res[I+1] := Word.Xor(Res[I],A[I])
    END;
    RETURN Res
  END DecodeXor;

PROCEDURE PrintArray(VAR A:ARRAY OF INTEGER) =
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO
      SIO.PutInt(A[I]);
      SIO.PutChar(' ')
    END;
    SIO.Nl()
  END PrintArray;
  
BEGIN
  PrintArray(DecodeXor(A1,1)^);
  PrintArray(DecodeXor(A2,4)^);
END Ch2.

