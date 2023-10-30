MODULE Ch2 EXPORTS Main;

IMPORT IO;

VAR
  A1:ARRAY[0..19] OF INTEGER :=
      ARRAY OF INTEGER{4,6,3,8,15,0,13,18,7,16,14,19,17,5,11,1,12,2,9,10};
  A2:ARRAY[0..19] OF INTEGER :=
      ARRAY OF INTEGER{0,1,13,7,6,8,10,11,2,14,16,4,12,9,17,5,3,18,15,19};
  A3:ARRAY[0..19] OF INTEGER :=
      ARRAY OF INTEGER{9,8,3,11,5,7,13,19,12,4,14,10,18,2,16,1,0,15,6,17};

PROCEDURE ArrayLoops(VAR A:ARRAY OF INTEGER):INTEGER =
  VAR
    I,Count:INTEGER := 0;
    Indices:REF ARRAY OF INTEGER;
  BEGIN
    Indices := NEW(REF ARRAY OF INTEGER,NUMBER(A));
    FOR I := FIRST(Indices^) TO LAST(Indices^) DO Indices[I] := -1 END;
    WHILE I <= LAST(A) DO 
      IF Indices[I] = -1 THEN
        INC(Count);
        WHILE Indices[I] = -1 DO
          Indices[I] := 1;
          I := A[I];
        END
      END;
      INC(I);
    END;
    RETURN Count
  END ArrayLoops;

BEGIN
  IO.PutInt(ArrayLoops(A1)); IO.Put("\n");
  IO.PutInt(ArrayLoops(A2)); IO.Put("\n");
  IO.PutInt(ArrayLoops(A3)); IO.Put("\n");
END Ch2.

