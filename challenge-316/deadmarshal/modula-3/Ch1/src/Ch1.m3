MODULE Ch1 EXPORTS Main;

IMPORT SIO,Text;

PROCEDURE Circular(VAR A:ARRAY OF TEXT):BOOLEAN =
  BEGIN
    FOR I := FIRST(A) TO LAST(A)-1 DO
      IF Text.GetChar(A[I],Text.Length(A[I])-1) #
        Text.GetChar(A[I+1],0) THEN
        RETURN FALSE
      END
    END;
    RETURN TRUE
  END Circular;

VAR
  A1 := ARRAY[0..2] OF TEXT{"perl","loves","scala"};
  A2 := ARRAY[0..2] OF TEXT{"love","the","programming"};
  A3 := ARRAY[0..3] OF TEXT{"java","awk","kotlin","node.js"};

BEGIN
  SIO.PutBool(Circular(A1)); SIO.Nl();
  SIO.PutBool(Circular(A2)); SIO.Nl();
  SIO.PutBool(Circular(A3)); SIO.Nl()
END Ch1.

