MODULE Ch1 EXPORTS Main;

IMPORT SIO,Text;

VAR
  A1 := ARRAY[0..2] OF TEXT{"--x","x++","x++"};
  A2 := ARRAY[0..2] OF TEXT{"x++","++x","x++"};
  A3 := ARRAY[0..3] OF TEXT{"x++","++x","--x","x--"};
  
PROCEDURE IncrementDecrement(VAR A:ARRAY OF TEXT):INTEGER =
  VAR X:INTEGER;
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO
      IF Text.FindChar(A[I],'+',0) # -1 THEN
        INC(X)
      ELSE DEC(X)
      END;
    END;
    RETURN X
  END IncrementDecrement;

BEGIN
  SIO.PutInt(IncrementDecrement(A1)); SIO.Nl();
  SIO.PutInt(IncrementDecrement(A2)); SIO.Nl();
  SIO.PutInt(IncrementDecrement(A3)); SIO.Nl()
END Ch1.

