MODULE Ch2 EXPORTS Main;

IMPORT SIO,IntSeq;

VAR
  A1 := ARRAY[0..2] OF INTEGER{5,-1,-1};
  A2 := ARRAY[0..4] OF INTEGER{3,7,-1,-1,-1};
  A3 := ARRAY[0..4] OF INTEGER{2,-1,4,-1,-1};
  A4 := ARRAY[0..5] OF INTEGER{10,20,-1,30,-1,-1};
  A5 := ARRAY[0..3] OF INTEGER{-1,-1,5,-1};
  
PROCEDURE LastVisitor(VAR A:ARRAY OF INTEGER):IntSeq.T =
  VAR
    Res := NEW(IntSeq.T).init(NUMBER(A));
    Seen := NEW(IntSeq.T).init(NUMBER(A));
    K := 0;
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO
      IF A[I] # -1 THEN
        Seen.addhi(A[I]);
        K := Seen.size()
      ELSIF K = 0 THEN
        Res.addhi(-1)
      ELSE
        DEC(K);
        Res.addhi(Seen.get(K))
      END
    END;
    RETURN Res
  END LastVisitor;

PROCEDURE PrintSeq(READONLY S:IntSeq.T) =
  BEGIN
    IF S = NIL OR S.size() = 0 THEN SIO.PutText("[]\n"); RETURN END;
    FOR I := 0 TO S.size()-1 DO
      SIO.PutInt(S.get(I));
      SIO.PutChar(' ')
    END;
    SIO.Nl()
  END PrintSeq;
  
BEGIN
  PrintSeq(LastVisitor(A1));
  PrintSeq(LastVisitor(A2));
  PrintSeq(LastVisitor(A3));
  PrintSeq(LastVisitor(A4));
  PrintSeq(LastVisitor(A5))
END Ch2.

