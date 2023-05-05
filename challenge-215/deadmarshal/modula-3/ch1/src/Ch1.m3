MODULE Ch1 EXPORTS Main;

IMPORT IO,Text;

VAR
  A1:ARRAY[0..2] OF TEXT := ARRAY OF TEXT{"abc","xyz","tsu"};
  A2:ARRAY[0..2] OF TEXT := ARRAY OF TEXT{"rat","cab","dad"}; 
  A3:ARRAY[0..2] OF TEXT := ARRAY OF TEXT{"x","y","z"};

PROCEDURE IsAlphabeticalOrder(READONLY t:TEXT):BOOLEAN =
  BEGIN
    FOR I := 1 TO Text.Length(t)-1 DO
      IF Text.GetChar(t,I) < Text.GetChar(t,I-1) THEN RETURN FALSE END
    END;
    RETURN TRUE
  END IsAlphabeticalOrder;

PROCEDURE OddOneOut(READONLY A:ARRAY OF TEXT):INTEGER =
  VAR
    Count:INTEGER := 0;
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO
      IF NOT IsAlphabeticalOrder(A[I]) THEN INC(Count) END
    END;
    RETURN Count
  END OddOneOut;

BEGIN
  IO.PutInt(OddOneOut(A1)); IO.Put("\n");
  IO.PutInt(OddOneOut(A2)); IO.Put("\n");
  IO.PutInt(OddOneOut(A3)); IO.Put("\n");
END Ch1.

