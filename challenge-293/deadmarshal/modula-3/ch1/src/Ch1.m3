MODULE Ch1 EXPORTS Main;

IMPORT SIO,Fmt,TextIntTbl,IntArraySort;

VAR
  A1 := ARRAY[0..3],[0..1] OF INTEGER{
  ARRAY OF INTEGER{1,3},
  ARRAY OF INTEGER{3,1},
  ARRAY OF INTEGER{2,4},
  ARRAY OF INTEGER{6,8}};
  A2 := ARRAY[0..4],[0..1] OF INTEGER{
  ARRAY OF INTEGER{1,2},
  ARRAY OF INTEGER{2,1},
  ARRAY OF INTEGER{1,1},
  ARRAY OF INTEGER{1,2},
  ARRAY OF INTEGER{2,2}};
  
PROCEDURE SimilarDominos(VAR A:ARRAY OF ARRAY OF INTEGER):INTEGER =
  VAR
    Sum,V:INTEGER;
    K:TEXT := "";
    H := NEW(TextIntTbl.Default).init();
    It:TextIntTbl.Iterator;
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO IntArraySort.Sort(A[I]) END;
    FOR I := FIRST(A) TO LAST(A) DO
      K := "";
      FOR J := FIRST(A[I]) TO LAST(A[I]) DO K := K & Fmt.Int(A[I,J]) END;
      IF NOT H.get(K,V) THEN EVAL H.put(K,1)
      ELSE EVAL H.put(K,V+1)
      END;
    END;
    It := H.iterate();
    WHILE It.next(K,V) DO IF V > 1 THEN INC(Sum,V) END END;
    RETURN Sum
  END SimilarDominos;

BEGIN
  SIO.PutInt(SimilarDominos(A1)); SIO.Nl();
  SIO.PutInt(SimilarDominos(A2)); SIO.Nl();
END Ch1.

