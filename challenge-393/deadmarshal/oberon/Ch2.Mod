MODULE Ch2;

  IMPORT Out;

  PROCEDURE IsPrime(N:LONGINT):BOOLEAN;
    VAR I:LONGINT;
  BEGIN
    I := 5;
    IF (N = 2) OR (N = 3) THEN RETURN TRUE END;
    IF (N <= 1) OR (N MOD 2 = 0) OR (N MOD 3 = 0) THEN
      RETURN FALSE
    END;
    WHILE I * I <= N DO
      IF (N MOD I = 0) OR (N MOD (I+2) = 0) THEN RETURN FALSE END;
      INC(I,6)
    END;
    RETURN TRUE
  END IsPrime;

  PROCEDURE PrimeStep(S:ARRAY OF CHAR):LONGINT;
    VAR Sum,D,I:LONGINT;
  BEGIN
    Sum := 0;
    D := 0;
    FOR I := 0 TO LEN(S)-1 DO INC(Sum,ORD(S[I])) END;
    WHILE TRUE DO
      IF IsPrime(Sum - D) OR IsPrime(Sum + D) THEN RETURN D END;
      INC(D)
    END
  END PrimeStep;

BEGIN
  Out.Int(PrimeStep("hello"),0); Out.Ln;
  Out.Int(PrimeStep("football"),0); Out.Ln;
  Out.Int(PrimeStep("a"),0); Out.Ln;
  Out.Int(PrimeStep("challenge"),0); Out.Ln;
  Out.Int(PrimeStep("perl"),0); Out.Ln;
END Ch2.

