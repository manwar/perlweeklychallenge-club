MODULE Ch2 EXPORTS Main;

IMPORT SIO,IntSeq;

VAR
  A1 := ARRAY[0..3] OF CARDINAL{1,3,2,4};
  A2 := ARRAY[0..3] OF CARDINAL{1,1,2,2};
  A3 := ARRAY[0..3] OF CARDINAL{3,1,3,2};

PROCEDURE DecompressedList(VAR A:ARRAY OF CARDINAL):IntSeq.T =
  VAR Res := NEW(IntSeq.T).init(NUMBER(A));
  BEGIN
    FOR I := FIRST(A) TO LAST(A) BY 2 DO
      FOR J := 1 TO A[I] DO Res.addhi(A[I+1]) END;
    END;
    RETURN Res
  END DecompressedList;

PROCEDURE PrintSeq(READONLY S:IntSeq.T) =
  BEGIN
    FOR I := 0 TO S.size()-1 DO
      SIO.PutInt(S.get(I));
      SIO.PutChar(' ')
    END;
    SIO.Nl()
  END PrintSeq;

BEGIN
  PrintSeq(DecompressedList(A1));
  PrintSeq(DecompressedList(A2));
  PrintSeq(DecompressedList(A3))
END Ch2.

