MODULE Ch1 EXPORTS Main;

IMPORT SIO;

VAR 
  A1:ARRAY[0..3] OF INTEGER := ARRAY OF INTEGER{1,2,3,4};
  A2:ARRAY[0..5] OF INTEGER := ARRAY OF INTEGER{2,7,1,19,18,3};

PROCEDURE SpecialNumbers(VAR A:ARRAY OF INTEGER):INTEGER = 
  VAR Sum:INTEGER := 0;
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO 
      IF NUMBER(A) MOD (I+1) = 0 THEN INC(Sum,A[I] * A[I]) END
    END;
    RETURN Sum
  END SpecialNumbers;

BEGIN
  SIO.PutInt(SpecialNumbers(A1)); SIO.Nl();
  SIO.PutInt(SpecialNumbers(A2)); SIO.Nl()
END Ch1.