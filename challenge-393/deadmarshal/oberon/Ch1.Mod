MODULE Ch1;

  IMPORT Out;

  PROCEDURE Gcd(A,B:LONGINT):LONGINT;
  BEGIN
    IF A = 0 THEN RETURN B
    ELSIF B = 0 THEN RETURN A
    ELSIF A > B THEN RETURN Gcd(B,A MOD B)
    ELSE RETURN Gcd(A,B MOD A)
    END
  END Gcd;

  PROCEDURE PythagorasMultiplied(N:LONGINT):LONGINT;
    VAR Count,C,M,K:LONGINT;
  BEGIN
    Count := 0;
    M := 2;
    WHILE M * M + 1 <= N DO
      K := 1;
      WHILE (K < M) & (M * M + K * K <= N) DO
	IF ((M - K) MOD 2 # 0) & (Gcd(M,K) = 1) THEN
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
  Out.Int(PythagorasMultiplied(20),0); Out.Ln;
  Out.Int(PythagorasMultiplied(7),0); Out.Ln;
  Out.Int(PythagorasMultiplied(1),0); Out.Ln;
  Out.Int(PythagorasMultiplied(15),0); Out.Ln;
  Out.Int(PythagorasMultiplied(30),0); Out.Ln;
END Ch1.

