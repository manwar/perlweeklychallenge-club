MODULE Ch2 EXPORTS Main;

IMPORT SIO;

VAR
  A1 := ARRAY[0..7] OF INTEGER{1,0,2,3,0,4,5,0};
  A2 := ARRAY[0..2] OF INTEGER{1,2,3};
  A3 := ARRAY[0..3] OF INTEGER{1,2,3,0};
  A4 := ARRAY[0..3] OF INTEGER{0,0,1,2};
  A5 := ARRAY[0..4] OF INTEGER{1,2,0,3,4};

PROCEDURE DuplicateZeros(VAR A:ARRAY OF INTEGER) =
  VAR
    N := NUMBER(A);
    I := -1;
    K := 0;
    J := N-1;
  BEGIN
    WHILE K < N DO
      INC(I);
      IF A[I] > 0 THEN INC(K) ELSE INC(K,2) END
    END;
    IF K = N+1 THEN
      A[J] := 0;
      DEC(J);
      DEC(I)
    END;
    WHILE J >= FIRST(A) DO
      A[J] := A[I];
      IF A[I] = 0 THEN DEC(J); A[J] := A[I] END;
      DEC(I);
      DEC(J)
    END;    
  END DuplicateZeros;

PROCEDURE PrintArray(VAR A:ARRAY OF INTEGER) =
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO
      SIO.PutInt(A[I]);
      SIO.PutChar(' ')
    END;
    SIO.Nl()
  END PrintArray;
  
BEGIN
  DuplicateZeros(A1);
  DuplicateZeros(A2);
  DuplicateZeros(A3);
  DuplicateZeros(A4);
  DuplicateZeros(A5);
  PrintArray(A1);
  PrintArray(A2);
  PrintArray(A3);
  PrintArray(A4);
  PrintArray(A5);
END Ch2.

