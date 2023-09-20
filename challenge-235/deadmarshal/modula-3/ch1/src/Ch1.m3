MODULE Ch1 EXPORTS Main;

FROM SIO IMPORT PutBool,PutLine;

VAR
  A1:ARRAY[0..4] OF INTEGER := ARRAY OF INTEGER{0,2,9,4,5};
  A2:ARRAY[0..3] OF INTEGER := ARRAY OF INTEGER{5,1,3,2};
  A3:ARRAY[0..2] OF INTEGER := ARRAY OF INTEGER{2,2,3};

PROCEDURE RemoveOne(VAR A:ARRAY OF INTEGER):BOOLEAN =
  VAR
    C1,C2:INTEGER := 0;
    Idx1,Idx2:INTEGER := -1;
  BEGIN
    FOR I := 1 TO LAST(A) DO
      IF A[I] <= A[I-1] THEN INC(C1); Idx1 := I-1 END
    END;
    FOR I := LAST(A)-1 TO 1 BY -1 DO
      IF A[I] >= A[I+1] THEN INC(C2); Idx2 := I+1 END
    END;
    IF (C1 = 1) AND (C2 = 1) AND ((Idx2 - Idx1 + 1) = 2) THEN RETURN TRUE END;
    IF (C1 > 1) OR (C2 > 1) THEN RETURN FALSE END;
    RETURN TRUE
  END RemoveOne;

BEGIN
  PutBool(RemoveOne(A1)); PutLine("");
  PutBool(RemoveOne(A2)); PutLine("");
  PutBool(RemoveOne(A3)); PutLine("");
END Ch1.

