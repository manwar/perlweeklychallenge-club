MODULE Ch2 EXPORTS Main;

IMPORT SIO,Text;

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

PROCEDURE PrimeStep(READONLY S:TEXT):CARDINAL =
  VAR Sum,Distance := 0;
  BEGIN
    FOR I := 0 TO Text.Length(S)-1 DO
      INC(Sum,ORD(Text.GetChar(S,I)))
    END;
    WHILE TRUE DO
      IF IsPrime(Sum - Distance) OR IsPrime(Sum + Distance) THEN
        RETURN Distance
      END;
      INC(Distance)
    END;
  END PrimeStep;

BEGIN
  SIO.PutInt(PrimeStep("hello")); SIO.Nl();
  SIO.PutInt(PrimeStep("football")); SIO.Nl();
  SIO.PutInt(PrimeStep("a")); SIO.Nl();
  SIO.PutInt(PrimeStep("challenge")); SIO.Nl();
  SIO.PutInt(PrimeStep("perl")); SIO.Nl();
END Ch2.

