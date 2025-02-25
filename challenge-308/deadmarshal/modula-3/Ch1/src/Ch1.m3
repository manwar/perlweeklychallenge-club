MODULE Ch1 EXPORTS Main;

IMPORT SIO,TextIntTbl;

VAR
  A1 := ARRAY[0..2] OF TEXT{"perl","weekly","challenge"};
  A2 := ARRAY[0..2] OF TEXT{"raku","weekly","challenge"};
  A3 := ARRAY[0..2] OF TEXT{"perl","raku","python"};
  A4 := ARRAY[0..1] OF TEXT{"python","java"};
  A5 := ARRAY[0..1] OF TEXT{"guest","contribution"};
  A6 := ARRAY[0..2] OF TEXT{"fun","weekly","challenge"};

PROCEDURE CountCommon(VAR A1,A2:ARRAY OF TEXT):CARDINAL =
  VAR
    H := NEW(TextIntTbl.Default).init(NUMBER(A1));
    It:TextIntTbl.Iterator;
    K:TEXT := "";
    Count,V:INTEGER;
  BEGIN
    FOR I := FIRST(A1) TO LAST(A1) DO
      IF NOT H.get(A1[I],V) THEN EVAL H.put(A1[I],1)
      ELSE EVAL H.put(A1[I],V+1)
      END
    END;
    FOR I := FIRST(A2) TO LAST(A2) DO
      IF NOT H.get(A2[I],V) THEN EVAL H.put(A2[I],1)
      ELSE EVAL H.put(A2[I],V+1)
      END
    END;
    It := H.iterate();
    WHILE It.next(K,V) DO IF V >= 2 THEN INC(Count) END END;
    RETURN Count
  END CountCommon;

BEGIN
  SIO.PutInt(CountCommon(A1,A2)); SIO.Nl();
  SIO.PutInt(CountCommon(A3,A4)); SIO.Nl();
  SIO.PutInt(CountCommon(A5,A6)); SIO.Nl()
END Ch1.

