MODULE Ch2;

  IMPORT Out;

  PROCEDURE IsPrime(N:INTEGER):BOOLEAN;
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

  PROCEDURE PrimeCount(N:INTEGER):INTEGER;
    VAR I,Count:INTEGER;
  BEGIN
    Count := 0;
    FOR I := 1 TO N-1 DO
      IF IsPrime(I) THEN INC(Count) END;
    END;
    RETURN Count;
  END PrimeCount;
  
BEGIN
  Out.Int(PrimeCount(10),0); Out.Ln;
  Out.Int(PrimeCount(15),0); Out.Ln;
  Out.Int(PrimeCount(1),0); Out.Ln;
  Out.Int(PrimeCount(25),0); Out.Ln;
END Ch2.

