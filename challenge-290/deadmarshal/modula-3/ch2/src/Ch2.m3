MODULE Ch2 EXPORTS Main;

IMPORT SIO,ASCII,Scan,Text,Stdio,FloatMode,Lex;

VAR
  Str1:TEXT := "17893729974";
  Str2:TEXT := "4137 8947 1175 5904";
  Str3:TEXT := "4137 8974 1175 5904";
  
PROCEDURE LuhnsAlgorithm(VAR Str:TEXT):BOOLEAN
  RAISES{FloatMode.Trap,Lex.Error} =
  VAR
    P:INTEGER := Scan.Int(Text.FromChar(Text.GetChar(Str,Text.Length(Str)-1)));
    Sum:INTEGER;
    Even:BOOLEAN;
  BEGIN
    FOR I := Text.Length(Str)-2 TO 0 BY -1 DO
      IF Text.GetChar(Str,I) IN ASCII.Spaces THEN
      ELSE
        WITH D = Scan.Int(Text.FromChar(Text.GetChar(Str,I))) DO
          IF Even THEN INC(Sum,D)
          ELSE
            IF 2 * D > 9 THEN INC(Sum,2 * D - 9) ELSE INC(Sum,2 * D) END
          END
        END;
        Even := NOT Even
      END
    END;
    RETURN (Sum + P) MOD 10 = 0
  END LuhnsAlgorithm;

BEGIN
  TRY
    SIO.PutBool(LuhnsAlgorithm(Str1)); SIO.Nl();
    SIO.PutBool(LuhnsAlgorithm(Str2)); SIO.Nl();
    SIO.PutBool(LuhnsAlgorithm(Str3)); SIO.Nl()
  EXCEPT
    FloatMode.Trap => SIO.PutText("Floating point exception!\n",Stdio.stderr)
  | Lex.Error => SIO.PutText("Malformed number!\n",Stdio.stderr)
  ELSE
    SIO.PutText("Some other exception!\n",Stdio.stderr)
  END;
END Ch2.

