MODULE Ch2 EXPORTS Main;

IMPORT SIO,IntSeq;

VAR
  A1 := ARRAY[0..4] OF INTEGER{8,4,6,2,3};
  A2 := ARRAY[0..4] OF INTEGER{1,2,3,4,5};
  A3 := ARRAY[0..3] OF INTEGER{7,1,1,5};

PROCEDURE FinalPrice(VAR A:ARRAY OF INTEGER) =
  VAR S := NEW(IntSeq.T).init(NUMBER(A));
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO
      WHILE S.size() # 0 AND A[S.gethi()] >= A[I] DO
        DEC(A[S.remhi()],A[I])
      END;
      S.addhi(I)
    END;
  END FinalPrice;

PROCEDURE PrintArray(VAR A:ARRAY OF INTEGER) =
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO
      SIO.PutInt(A[I]);
      SIO.PutChar(' ')
    END;
    SIO.Nl()
  END PrintArray;

BEGIN
  FinalPrice(A1);
  FinalPrice(A2);
  FinalPrice(A3);
  PrintArray(A1);
  PrintArray(A2);
  PrintArray(A3)
END Ch2.

