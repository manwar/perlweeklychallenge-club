MODULE Ch2 EXPORTS Main;

IMPORT IO,Word;

VAR
  A1:ARRAY[0..6] OF INTEGER := ARRAY OF INTEGER{1,2,3,4,5,6,7};
  A2:ARRAY[0..3] OF INTEGER := ARRAY OF INTEGER{2,4,1,3};
  A3:ARRAY[0..4] OF INTEGER := ARRAY OF INTEGER{10,5,7,12,8};

PROCEDURE MaximumXor(VAR A:ARRAY OF INTEGER):INTEGER =
  VAR
    Max,Temp:INTEGER := 0;
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO
      FOR J := FIRST(A) TO LAST(A) DO
        Temp := Word.Xor(A[I],A[J]);
        IF Max < Temp THEN Max := Temp END;
      END;
    END;
    RETURN Max;
  END MaximumXor;

BEGIN
  IO.PutInt(MaximumXor(A1)); IO.Put("\n");
  IO.PutInt(MaximumXor(A2)); IO.Put("\n");
  IO.PutInt(MaximumXor(A3)); IO.Put("\n");
END Ch2.

