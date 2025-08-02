MODULE Ch2 EXPORTS Main;

IMPORT SIO;

VAR 
  A1:ARRAY[0..6] OF CARDINAL := ARRAY OF CARDINAL{3,1,2,2,2,1,3};
  A2:ARRAY[0..2] OF CARDINAL := ARRAY OF CARDINAL{1,2,3};

PROCEDURE CountEqualDivisible(VAR A:ARRAY OF CARDINAL;
                              READONLY K:CARDINAL):CARDINAL =
  VAR Count:CARDINAL := 0;
  BEGIN
    FOR I := FIRST(A) TO LAST(A)-1 DO
      FOR J := I+1 TO LAST(A) DO
        IF (A[I] = A[J]) AND ((I*J) MOD K = 0) THEN INC(Count) END
      END
    END;
    RETURN Count
  END CountEqualDivisible;

BEGIN
  SIO.PutInt(CountEqualDivisible(A1,2)); SIO.Nl();
  SIO.PutInt(CountEqualDivisible(A2,1)); SIO.Nl();
END Ch2.

