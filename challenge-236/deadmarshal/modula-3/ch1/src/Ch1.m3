MODULE Ch1 EXPORTS Main;

IMPORT IO;

VAR
  A1:ARRAY[0..4] OF INTEGER := ARRAY OF INTEGER{5,5,5,10,20};
  A2:ARRAY[0..4] OF INTEGER := ARRAY OF INTEGER{5,5,10,10,20};
  A3:ARRAY[0..3] OF INTEGER := ARRAY OF INTEGER{5,5,5,20};
  
PROCEDURE ExactExchange(VAR A:ARRAY OF INTEGER):INTEGER =
  VAR
    Fives,Tens,Twenties:INTEGER := 0;
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO
      IF A[I] = 10 THEN
        DEC(Fives);
        IF Fives = 0 THEN RETURN 0 END
      ELSIF A[I] = 20 THEN
        IF (Fives # 0) AND (Tens # 0) THEN DEC(Fives); DEC(Tens)
        ELSIF Fives > 2 THEN DEC(Fives,3)
        ELSE RETURN 0
        END
      END;
      CASE A[I] OF
      | 5 => INC(Fives)
      | 10 => INC(Tens)
      | 20 => INC(Twenties)
      ELSE
        IO.Put("Only 5,10,20 allowed!\n");
        RETURN 0
      END
    END;
    RETURN 1
  END ExactExchange;

BEGIN
  IO.PutInt(ExactExchange(A1)); IO.Put("\n");
  IO.PutInt(ExactExchange(A2)); IO.Put("\n");
  IO.PutInt(ExactExchange(A3)); IO.Put("\n");
END Ch1.

