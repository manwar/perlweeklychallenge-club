MODULE Ch2 EXPORTS Main;

IMPORT SIO;

VAR
  A1 := ARRAY[0..5] OF INTEGER{1,12,-5,-6,50,3};
  A2 := ARRAY[0..0] OF INTEGER{5};

PROCEDURE MaximumAverage(VAR A:ARRAY OF INTEGER;
                         READONLY N:INTEGER):LONGREAL =
  VAR
    Max,SubSum,Avg:LONGREAL;  
  BEGIN
    FOR Start := FIRST(A) TO NUMBER(A) - N DO
      FOR I := Start TO Start+N-1 DO
        SubSum := SubSum + FLOAT(A[I],LONGREAL)
      END;
      Avg := SubSum / FLOAT(N,LONGREAL);
      IF Avg > Max THEN Max := Avg END;
      SubSum := 0.0D0;
    END;
    RETURN Max
  END MaximumAverage;

BEGIN
  SIO.PutLongReal(MaximumAverage(A1,4)); SIO.Nl();
  SIO.PutLongReal(MaximumAverage(A2,1)); SIO.Nl()
END Ch2.

