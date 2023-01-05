MODULE Ch2 EXPORTS Main;

IMPORT IO;

PROCEDURE IsPrime(N:INTEGER):BOOLEAN =
  VAR I:INTEGER;
  BEGIN
    I := 5;
    IF (N = 2) OR (N = 3) THEN RETURN TRUE END;
    IF (N <= 1) OR (N MOD 2 = 0) OR (N MOD 3 = 0) THEN RETURN FALSE END;
    WHILE I * I <= N DO
      IF (N MOD I = 0) OR (N MOD (I+2) = 0) THEN RETURN FALSE END;
      INC(I,6);
    END;
    RETURN TRUE;
  END IsPrime;

PROCEDURE PrimeCount(N:INTEGER):INTEGER =
  VAR Count:INTEGER;
  BEGIN
    Count := 0;
    FOR I := 1 TO N-1 DO
      IF IsPrime(I) THEN INC(Count) END;
    END;
    RETURN Count;
  END PrimeCount;
  
BEGIN
  IO.PutInt(PrimeCount(10)); IO.Put("\n");
  IO.PutInt(PrimeCount(15)); IO.Put("\n");
  IO.PutInt(PrimeCount(1)); IO.Put("\n");
  IO.PutInt(PrimeCount(25)); IO.Put("\n");
END Ch2.

