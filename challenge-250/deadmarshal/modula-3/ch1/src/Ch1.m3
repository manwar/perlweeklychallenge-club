MODULE Ch1 EXPORTS Main;

IMPORT IO;

VAR
  A1 := ARRAY[0..2] OF CARDINAL{0,1,2};
  A2 := ARRAY[0..3] OF CARDINAL{4,3,2,1};
  A3 := ARRAY[0..9] OF CARDINAL{1,2,3,4,5,6,7,8,9,0};

PROCEDURE SmallestIndex(VAR A:ARRAY OF CARDINAL):INTEGER =
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO
      IF I MOD 10 = A[I] THEN RETURN I END
    END;
    RETURN -1
  END SmallestIndex;

BEGIN
  IO.PutInt(SmallestIndex(A1)); IO.Put("\n");
  IO.PutInt(SmallestIndex(A2)); IO.Put("\n");
  IO.PutInt(SmallestIndex(A3)); IO.Put("\n");
END Ch1.

