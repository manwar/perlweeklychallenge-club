MODULE Ch1 EXPORTS Main;

IMPORT SIO,IntSetDef;

VAR
  A1 := ARRAY[0..5] OF INTEGER{10,4,20,1,3,2};
  A2 := ARRAY[0..9] OF INTEGER{0,6,1,8,5,2,4,3,0,7};
  A3 := ARRAY[0..2] OF INTEGER{10,30,20};

PROCEDURE ConsecutiveSequence(VAR A:ARRAY OF INTEGER):INTEGER =
  VAR
    Res,J:INTEGER;
    S:IntSetDef.T := NEW(IntSetDef.T).init(NUMBER(A)).fromArray(A);
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO
      IF NOT S.member(A[I]-1) THEN
        J := A[I];
        WHILE S.member(J) DO INC(J) END;
        Res := MAX(Res,J - A[I])
      END;
    END;
    IF Res = 1 THEN RETURN -1 ELSE RETURN Res END
  END ConsecutiveSequence;

BEGIN
  SIO.PutInt(ConsecutiveSequence(A1)); SIO.Nl();
  SIO.PutInt(ConsecutiveSequence(A2)); SIO.Nl();
  SIO.PutInt(ConsecutiveSequence(A3)); SIO.Nl()
END Ch1.

