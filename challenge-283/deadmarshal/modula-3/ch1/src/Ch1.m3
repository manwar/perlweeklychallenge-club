MODULE Ch1 EXPORTS Main;

IMPORT SIO;

VAR
  A1 := ARRAY[0..2] OF CARDINAL{3,3,1};
  A2 := ARRAY[0..4] OF CARDINAL{3,2,4,2,4};
  A3 := ARRAY[0..0] OF CARDINAL{1};
  A4 := ARRAY[0..5] OF CARDINAL{4,3,1,1,1,4};
  
PROCEDURE UniqueNumber(VAR A:ARRAY OF CARDINAL):CARDINAL =
  VAR
    Hash:ARRAY[0..9] OF CARDINAL := ARRAY[0..9] OF CARDINAL{0,..};
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO INC(Hash[A[I] MOD 10]) END;
    FOR I := FIRST(Hash) TO LAST(Hash) DO
      IF Hash[I] = 1 THEN RETURN I END
    END;
  END UniqueNumber;

BEGIN
  SIO.PutInt(UniqueNumber(A1)); SIO.Nl();
  SIO.PutInt(UniqueNumber(A2)); SIO.Nl();
  SIO.PutInt(UniqueNumber(A3)); SIO.Nl();
  SIO.PutInt(UniqueNumber(A4)); SIO.Nl()
END Ch1.

