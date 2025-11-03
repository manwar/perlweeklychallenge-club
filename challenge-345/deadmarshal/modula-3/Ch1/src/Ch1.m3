MODULE Ch1 EXPORTS Main;

IMPORT SIO,IntSeq;

VAR
  A1 := ARRAY[0..2] OF INTEGER{1,3,2};
  A2 := ARRAY[0..4] OF INTEGER{2,4,6,5,3};
  A3 := ARRAY[0..5] OF INTEGER{1,2,3,2,4,1};
  A4 := ARRAY[0..2] OF INTEGER{5,3,1};
  A5 := ARRAY[0..6] OF INTEGER{1,5,1,5,1,5,1};

PROCEDURE PeakPositions(VAR A:ARRAY OF INTEGER):IntSeq.T =
  VAR
    S := NEW(IntSeq.T).init(NUMBER(A));
    I:INTEGER := 1;
  BEGIN
    IF NUMBER(A) < 3 THEN RETURN NIL END;
    WHILE I < NUMBER(A)-1 DO
      IF A[I-1] < A[I] AND A[I+1] < A[I] THEN S.addhi(I) END;
      INC(I);
    END;
    IF S.size() = 0 THEN S.addhi(0) END;
    RETURN S
  END PeakPositions;

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
  PrintSeq(PeakPositions(A1));
  PrintSeq(PeakPositions(A2));
  PrintSeq(PeakPositions(A3));
  PrintSeq(PeakPositions(A4));
  PrintSeq(PeakPositions(A5))
END Ch1.

