MODULE Ch1 EXPORTS Main;

IMPORT SIO,TextIntTbl;

VAR
  A1 := ARRAY[0..2],[0..1] OF TEXT{
  ARRAY[0..1] OF TEXT{"B","C"},
  ARRAY[0..1] OF TEXT{"D","B"},
  ARRAY[0..1] OF TEXT{"C","A"}};
  A2 := ARRAY[0..0],[0..1] OF TEXT{
  ARRAY OF TEXT{"A","Z"}};

PROCEDURE NoConnection(VAR A:ARRAY OF ARRAY OF TEXT):TEXT =
  VAR
    Destinations,Sources := NEW(TextIntTbl.Default).init(NUMBER(A));
    It:TextIntTbl.Iterator;
    K:TEXT := "";
    V:INTEGER;
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO
      EVAL Sources.put(A[I,0],1);
      EVAL Destinations.put(A[I,1],1);
    END;
    It := Destinations.iterate();
    WHILE It.next(K,V) DO
      IF Destinations.get(K,V) THEN RETURN K END
    END;
    RETURN ""
  END NoConnection;

BEGIN
  SIO.PutText(NoConnection(A1) & "\n");
  SIO.PutText(NoConnection(A2) & "\n")
END Ch1.

