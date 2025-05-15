MODULE Ch1 EXPORTS Main;

IMPORT SIO,IntSetDef,IntArraySort;

VAR
  A1 := ARRAY[0..5] OF INTEGER{1,2,4,3,5,6};
  A2 := ARRAY[0..5] OF INTEGER{0,2,4,8,3,5};
  A3 := ARRAY[0..5] OF INTEGER{7,3,1,0,5,9};

PROCEDURE DistinctAverage(VAR A:ARRAY OF INTEGER):INTEGER =
  VAR S := NEW(IntSetDef.T).init();
  BEGIN
    IntArraySort.Sort(A);
    FOR I := FIRST(A) TO NUMBER(A) DIV 2 DO
      EVAL S.insert(A[I] + A[LAST(A)-I])
    END;
    RETURN S.size()
  END DistinctAverage;
  
BEGIN
  SIO.PutInt(DistinctAverage(A1)); SIO.Nl();
  SIO.PutInt(DistinctAverage(A2)); SIO.Nl();
  SIO.PutInt(DistinctAverage(A3)); SIO.Nl()
END Ch1.

