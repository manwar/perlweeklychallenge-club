MODULE Ch2 EXPORTS Main;

IMPORT SIO,IntSorting,IntSeq;

VAR
  A1:ARRAY[0..3] OF INTEGER := ARRAY OF INTEGER{2,5,3,4};
  A2:ARRAY[0..7] OF INTEGER := ARRAY OF INTEGER{9,4,1,3,6,4,6,1};
  A3:ARRAY[0..3] OF INTEGER := ARRAY OF INTEGER{1,2,2,3};
  
PROCEDURE NumberGame(VAR A:ARRAY OF INTEGER):IntSeq.T =
  VAR Ret:IntSeq.T := NEW(IntSeq.T).init(NUMBER(A));
  BEGIN
    IntSorting.QuickSort(A,FIRST(A),LAST(A));
    FOR I := FIRST(A) TO LAST(A) BY 2 DO
      Ret.addhi(A[I+1]);
      Ret.addhi(A[I])
    END;
    RETURN Ret
  END NumberGame;

PROCEDURE PrintSequence(READONLY S:IntSeq.T) =
  BEGIN
    FOR I := 0 TO S.size()-1 DO
      SIO.PutInt(S.get(I)); SIO.PutChar(' ')
    END;
    SIO.Nl()
  END PrintSequence;

BEGIN
  PrintSequence(NumberGame(A1));
  PrintSequence(NumberGame(A2));
  PrintSequence(NumberGame(A3));
END Ch2.

