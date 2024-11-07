MODULE Ch2 EXPORTS Main;

IMPORT SIO,IntSwap;

VAR
  A1 := ARRAY[0..2] OF INTEGER{1,2,3};
  A2 := ARRAY[0..2] OF INTEGER{2,1,3};
  A3 := ARRAY[0..2] OF INTEGER{3,1,2};
  
PROCEDURE ReverseArray(VAR A:ARRAY OF INTEGER) =
  VAR
    Start := FIRST(A);
    End := LAST(A);
  BEGIN
    WHILE Start < End DO
      IntSwap.Swap(A[Start],A[End]);
      INC(Start);
      DEC(End)
    END;
  END ReverseArray;

PROCEDURE NextPermutation(VAR A:ARRAY OF INTEGER) =
  VAR P:INTEGER := -1;
  BEGIN
    FOR I := LAST(A)-1 TO FIRST(A) BY -1 DO
      IF A[I] < A[I+1] THEN P := I; EXIT END
    END;
    IF P = -1 THEN ReverseArray(A) END;
    FOR I := LAST(A) TO P BY -1 DO
      IF A[I] > A[P] THEN IntSwap.Swap(A[I],A[P]); EXIT END
    END;
    ReverseArray(SUBARRAY(A,P+1,LAST(A)-1))
  END NextPermutation;

PROCEDURE PrintArray(READONLY A:ARRAY OF INTEGER) =
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO
      SIO.PutInt(A[I]);
      SIO.PutChar(' ')
    END;
    SIO.Nl()
  END PrintArray;
  
BEGIN
  NextPermutation(A1);
  NextPermutation(A2);
  NextPermutation(A3);
  PrintArray(A1);
  PrintArray(A2);
  PrintArray(A3)
END Ch2.

