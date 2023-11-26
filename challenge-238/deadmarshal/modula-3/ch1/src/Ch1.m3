MODULE Ch1 EXPORTS Main;

IMPORT IO;

VAR
  A1:ARRAY[0..4] OF INTEGER := ARRAY OF INTEGER{1,2,3,4,5};
  A2:ARRAY[0..4] OF INTEGER := ARRAY OF INTEGER{1,1,1,1,1};
  A3:ARRAY[0..3] OF INTEGER := ARRAY OF INTEGER{0,-1,1,2};
  
PROCEDURE RunningSum(VAR Arr:ARRAY OF INTEGER) = 
  VAR Sum:INTEGER;
  BEGIN
    Sum := 0;
    FOR I := FIRST(Arr) TO LAST(Arr) DO
      INC(Sum,Arr[I]);
      IO.PutInt(Sum); IO.Put(" ")
    END;
    IO.Put("\n");
  END RunningSum;

BEGIN
  RunningSum(A1);
  RunningSum(A2);
  RunningSum(A3);
END Ch1.

