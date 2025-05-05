MODULE Ch2 EXPORTS Main;

IMPORT SIO;

PROCEDURE SumDigits(N:INTEGER):CARDINAL =
  VAR
    Sum:CARDINAL;
  BEGIN
    WHILE N # 0 DO
      INC(Sum,N MOD 10);
      N := N DIV 10
    END;
    RETURN Sum
  END SumDigits;

PROCEDURE SumDifference(VAR A:ARRAY OF INTEGER):CARDINAL =
  VAR
    Sum1,Sum2:CARDINAL;
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO
      INC(Sum1,A[I]);
      INC(Sum2,SumDigits(A[I]))
    END;
    RETURN ABS(Sum1 - Sum2)
  END SumDifference;

VAR
  A1 := ARRAY[0..3] OF INTEGER{1,23,4,5};
  A2 := ARRAY[0..4] OF INTEGER{1,2,3,4,5};
  A3 := ARRAY[0..2] OF INTEGER{1,2,34};

BEGIN
  SIO.PutInt(SumDifference(A1)); SIO.Nl();
  SIO.PutInt(SumDifference(A2)); SIO.Nl();
  SIO.PutInt(SumDifference(A3)); SIO.Nl()
END Ch2.

