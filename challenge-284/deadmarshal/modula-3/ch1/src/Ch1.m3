MODULE Ch1 EXPORTS Main;

IMPORT SIO,Fmt,IntIntTbl;

VAR
  A1:ARRAY[0..3] OF INTEGER := ARRAY OF INTEGER{2,2,3,4};
  A2:ARRAY[0..5] OF INTEGER := ARRAY OF INTEGER{1,2,2,3,3,3};
  A3:ARRAY[0..3] OF INTEGER := ARRAY OF INTEGER{1,1,1,3};
  
PROCEDURE LuckyInteger(VAR A:ARRAY OF INTEGER):INTEGER =
  VAR
    H:IntIntTbl.Default := NEW(IntIntTbl.Default).init(NUMBER(A));
    K,V:INTEGER;
    It:IntIntTbl.Iterator;
    M:INTEGER := -1;
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO
      IF NOT H.get(A[I],V) THEN EVAL H.put(A[I],1)
      ELSE
        EVAL H.get(A[I],V);
        EVAL H.put(A[I],V+1)
      END
    END;
    It := H.iterate();
    WHILE It.next(K,V) DO IF K = V THEN M := MAX(M,K) END END;
    RETURN M
  END LuckyInteger;

BEGIN
  SIO.PutText(Fmt.F("%s\n",Fmt.Int(LuckyInteger(A1))));
  SIO.PutText(Fmt.F("%s\n",Fmt.Int(LuckyInteger(A2))));
  SIO.PutText(Fmt.F("%s\n",Fmt.Int(LuckyInteger(A3))));
END Ch1.

