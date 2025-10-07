MODULE Ch1 EXPORTS Main;

IMPORT SIO,ASCII;
FROM Text IMPORT FromChar,GetChar,Length;

PROCEDURE BalanceString(READONLY Str:TEXT):TEXT =
  VAR
    A,B,Res:TEXT := "";
    M,N:CARDINAL;
  BEGIN
    FOR I := 0 TO Length(Str)-1 DO
      WITH C = GetChar(Str,I) DO
        IF C IN ASCII.Digits THEN
          A := A & FromChar(C)
        ELSE
          B := B & FromChar(C)          
        END
      END
    END;
    M := Length(A);
    N := Length(B);
    IF ABS(M-N) > 1 THEN RETURN "" END;
    FOR I := 0 TO MIN(M,N)-1 DO
      IF M > N THEN
        Res := Res & FromChar(GetChar(A,I)) & FromChar(GetChar(B,I))
      ELSE
        Res := Res & FromChar(GetChar(B,I)) & FromChar(GetChar(A,I))
      END
    END;
    IF M > N THEN Res := Res & FromChar(GetChar(A,M-1)) END;
    IF M < N THEN Res := Res & FromChar(GetChar(B,N-1)) END;
    RETURN Res
  END BalanceString;

BEGIN
  SIO.PutText(BalanceString("a0b1c2")); SIO.Nl();
  SIO.PutText(BalanceString("abc12")); SIO.Nl();
  SIO.PutText(BalanceString("0a2b1c3")); SIO.Nl();
  SIO.PutText(BalanceString("1a23")); SIO.Nl();
  SIO.PutText(BalanceString("ab123")); SIO.Nl()
END Ch1.

