MODULE Ch1 EXPORTS Main;

IMPORT SIO;

PROCEDURE Gcd(A,B:CARDINAL):CARDINAL =
  BEGIN
    IF A = 0 THEN RETURN B
    ELSIF B = 0 THEN RETURN A
    ELSIF A > B THEN RETURN Gcd(B,A MOD B)
    ELSE RETURN Gcd(A,B MOD A)
    END
  END Gcd;

PROCEDURE PythagorasMultiplied(READONLY N:INTEGER):INTEGER =
  VAR
    C,K:INTEGER;
    Count := 0;
    M := 2;
  BEGIN
    WHILE M * M + 1 <= N DO
      K := 1;
      WHILE (K < M) AND (M * M + K * K <= N) DO
        IF (M - K) MOD 2 # 0 AND Gcd(M,K) = 1 THEN
          C := M * M + K * K;
          INC(Count,2 * (N DIV C))
        END;
        INC(K)
      END;
      INC(M)
    END;
    RETURN Count
  END PythagorasMultiplied;

BEGIN
  SIO.PutInt(PythagorasMultiplied(20)); SIO.Nl();
  SIO.PutInt(PythagorasMultiplied(7)); SIO.Nl();
  SIO.PutInt(PythagorasMultiplied(1)); SIO.Nl();
  SIO.PutInt(PythagorasMultiplied(15)); SIO.Nl();
  SIO.PutInt(PythagorasMultiplied(30)); SIO.Nl()
END Ch1.

