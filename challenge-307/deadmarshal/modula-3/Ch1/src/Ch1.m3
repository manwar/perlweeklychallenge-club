MODULE Ch1 EXPORTS Main;

IMPORT SIO,IntArraySort,IntSeq;

PROCEDURE CheckOrder(VAR A:ARRAY OF INTEGER):IntSeq.T =
  VAR
    Sorted := NEW(REF ARRAY OF INTEGER,NUMBER(A));
    S := NEW(IntSeq.T).init(NUMBER(A));
  BEGIN
    SUBARRAY(Sorted^,FIRST(Sorted^),NUMBER(Sorted^)) :=
        SUBARRAY(A,FIRST(A),NUMBER(A));
    IntArraySort.Sort(Sorted^);
    FOR I := FIRST(A) TO LAST(A) DO
      IF A[I] # Sorted[I] THEN S.addhi(I); END
    END;
    RETURN S
  END CheckOrder;

PROCEDURE PrintSequence(READONLY S:IntSeq.T) =
  BEGIN
    FOR I := 0 TO S.size()-1 DO
      SIO.PutInt(S.get(I));
      SIO.PutChar(' ')
    END;
    SIO.Nl()
  END PrintSequence;

VAR
  A1 := ARRAY[0..4] OF INTEGER{5,2,4,3,1};
  A2 := ARRAY[0..4] OF INTEGER{1,2,1,1,3};
  A3 := ARRAY[0..4] OF INTEGER{3,1,3,2,3};

BEGIN
  PrintSequence(CheckOrder(A1));
  PrintSequence(CheckOrder(A2));
  PrintSequence(CheckOrder(A3))
END Ch1.

