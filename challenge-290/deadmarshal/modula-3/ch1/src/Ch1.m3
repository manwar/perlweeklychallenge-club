MODULE Ch1 EXPORTS Main;

IMPORT SIO,IntIntTbl;

VAR
  A1 := ARRAY[0..3] OF INTEGER{6,2,3,3};
  A2 := ARRAY[0..3] OF INTEGER{3,1,4,13};
  A3 := ARRAY[0..3] OF INTEGER{2,1,4,2};

PROCEDURE DoubleExist(VAR A:ARRAY OF INTEGER):BOOLEAN =
  VAR
    H := NEW(IntIntTbl.Default).init(NUMBER(A));
    It:IntIntTbl.Iterator;
    K,V:INTEGER := 0;
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO
      IF NOT H.get(A[I],V) THEN EVAL H.put(A[I],0)
      ELSE
        EVAL H.get(A[I],V);
        EVAL H.put(A[I],V+1)
      END
    END;
    It := H.iterate();
    WHILE It.next(K,V) DO
      IF H.get(K * 2,V) THEN RETURN TRUE END
    END;
    RETURN FALSE
  END DoubleExist;
  
BEGIN
  SIO.PutBool(DoubleExist(A1)); SIO.Nl();
  SIO.PutBool(DoubleExist(A2)); SIO.Nl();
  SIO.PutBool(DoubleExist(A3)); SIO.Nl();
END Ch1.

