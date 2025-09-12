MODULE Ch1 EXPORTS Main;

IMPORT SIO;

VAR
  A1 := ARRAY[0..2],[0..3] OF INTEGER{
  ARRAY[0..3] OF INTEGER{4,4,4,4},
  ARRAY[0..3] OF INTEGER{10,0,0,0},
  ARRAY[0..3] OF INTEGER{2,2,2,9}};

  A2 := ARRAY[0..2],[0..1] OF INTEGER{
  ARRAY[0..1] OF INTEGER{1,5},
  ARRAY[0..1] OF INTEGER{7,3},
  ARRAY[0..1] OF INTEGER{3,5}};
  
  A3 := ARRAY[0..1],[0..2] OF INTEGER{
  ARRAY[0..2] OF INTEGER{1,2,3},
  ARRAY[0..2] OF INTEGER{3,2,1}};

  A4 := ARRAY[0..2],[0..2] OF INTEGER{
  ARRAY[0..2] OF INTEGER{2,8,7},
  ARRAY[0..2] OF INTEGER{7,1,3},
  ARRAY[0..2] OF INTEGER{1,9,5}};

  A5 := ARRAY[0..3],[0..2] OF INTEGER{
  ARRAY[0..2] OF INTEGER{10,20,30},
  ARRAY[0..2] OF INTEGER{5,5,5},
  ARRAY[0..2] OF INTEGER{0,100,0},
  ARRAY[0..2] OF INTEGER{25,25,25}};

PROCEDURE HighestRow(VAR A:ARRAY OF ARRAY OF INTEGER):INTEGER =
  VAR
    Max := FIRST(INTEGER);
    Sum:INTEGER;
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO
      Sum := 0;
      FOR J := FIRST(A[I]) TO LAST(A[I]) DO
        INC(Sum,A[I,J])
      END;
      IF Sum > Max THEN Max := Sum END;
    END;
    RETURN Max
  END HighestRow;
  
BEGIN
  SIO.PutInt(HighestRow(A1)); SIO.Nl();
  SIO.PutInt(HighestRow(A2)); SIO.Nl();
  SIO.PutInt(HighestRow(A3)); SIO.Nl();
  SIO.PutInt(HighestRow(A4)); SIO.Nl();
  SIO.PutInt(HighestRow(A5)); SIO.Nl()
END Ch1.

