MODULE Ch2 EXPORTS Main;

IMPORT IO;

VAR
  A1:ARRAY[0..3] OF INTEGER := ARRAY OF INTEGER{10,4,8,3};
  A2:ARRAY[0..0] OF INTEGER := ARRAY OF INTEGER{1};
  A3:ARRAY[0..4] OF INTEGER := ARRAY OF INTEGER{1,2,3,4,5};

PROCEDURE LeftRightSumDiff(VAR A:ARRAY OF INTEGER) = 
  VAR
  Left,Right:INTEGER := 0;
BEGIN
  FOR I := FIRST(A)+1 TO LAST(A) DO INC(Right,A[I]) END;
  FOR I := FIRST(A) TO LAST(A) DO
    IO.PutInt(ABS(Left-Right));
    IO.PutChar(' ');
    INC(Left,A[I]);
    IF I < LAST(A) THEN DEC(Right,A[I+1]) END;
  END;
  IO.Put("\n")
END LeftRightSumDiff;

BEGIN
  LeftRightSumDiff(A1);
  LeftRightSumDiff(A2);
  LeftRightSumDiff(A3);
END Ch2.

