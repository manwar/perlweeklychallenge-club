MODULE Ch1 EXPORTS Main;

IMPORT IO,Fmt;

VAR
  A1:ARRAY[0..3] OF INTEGER := ARRAY OF INTEGER{3,2,1,4};
  A2:ARRAY[0..1] OF INTEGER := ARRAY OF INTEGER{3,1};
  A3:ARRAY[0..2] OF INTEGER := ARRAY OF INTEGER{2,1,3}; 

PROCEDURE MinMax(VAR A:ARRAY OF INTEGER) =
  VAR
    Min:INTEGER := LAST(INTEGER);
    Max:INTEGER := FIRST(INTEGER);
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO
      IF Max < A[I] THEN Max := A[I] END;
      IF Min > A[I] THEN Min := A[I] END
    END;
    FOR I := FIRST(A) TO LAST(A) DO
      IF A[I] # Min AND A[I] # Max THEN
        IO.Put(Fmt.F("%s ",Fmt.Int(A[I])));
      END
    END;
    IO.Put("\n")
  END MinMax;
  
BEGIN
  MinMax(A1);
  MinMax(A2);
  MinMax(A3);
END Ch1.

