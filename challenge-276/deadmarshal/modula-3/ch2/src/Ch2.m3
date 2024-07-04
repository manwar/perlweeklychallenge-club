MODULE Ch2 EXPORTS Main;

IMPORT SIO;

VAR 
  A1:ARRAY[0..5] OF INTEGER := ARRAY OF INTEGER{1,2,2,4,1,5};
  A2:ARRAY[0..4] OF INTEGER := ARRAY OF INTEGER{1,2,3,4,5};

PROCEDURE MaximumFrequency(VAR A:ARRAY OF INTEGER):INTEGER = 
VAR
  Sum:INTEGER := 0; 
  Max:INTEGER := A[FIRST(A)];  
  Hash:ARRAY[0..9] OF INTEGER := ARRAY[0..9] OF INTEGER{0,..};
BEGIN  
  FOR I := FIRST(A) TO LAST(A) DO INC(Hash[A[I]]) END;
  FOR I := FIRST(Hash) TO LAST(Hash) DO 
    IF Hash[I] > Max THEN 
      Max := Hash[I] 
    END;
  END;
  FOR I := FIRST(Hash) TO LAST(Hash) DO
    IF Hash[I] = Max THEN 
      INC(Sum,Hash[I]) 
    END
  END;
  RETURN Sum
END MaximumFrequency;

BEGIN
  SIO.PutInt(MaximumFrequency(A1)); SIO.Nl();
  SIO.PutInt(MaximumFrequency(A2)); SIO.Nl();
END Ch2.

