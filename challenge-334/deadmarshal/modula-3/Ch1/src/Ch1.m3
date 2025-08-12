MODULE Ch1 EXPORTS Main;

IMPORT SIO;

VAR    
  A1 := ARRAY[0..5] OF INTEGER{-2,0,3,-5,2,-1};
  A2 := ARRAY[0..4] OF INTEGER{1,-2,3,-4,5};
  A3 := ARRAY[0..4] OF INTEGER{1,0,2,-1,3};
  A4 := ARRAY[0..5] OF INTEGER{-5,4,-3,2,-1,0};
  A5 := ARRAY[0..5] OF INTEGER{-1,0,2,-3,-2,1};

PROCEDURE RangeSum(VAR A:ARRAY OF INTEGER;
                   READONLY X,Y:INTEGER):INTEGER =
  VAR Sum := 0;
  BEGIN
    FOR I := X TO Y DO INC(Sum,A[I]) END;
    RETURN Sum
  END RangeSum;

BEGIN
  SIO.PutInt(RangeSum(A1,0,2)); SIO.Nl();
  SIO.PutInt(RangeSum(A2,1,3)); SIO.Nl();
  SIO.PutInt(RangeSum(A3,3,4)); SIO.Nl();
  SIO.PutInt(RangeSum(A4,0,3)); SIO.Nl();
  SIO.PutInt(RangeSum(A5,0,2)); SIO.Nl()
END Ch1.

