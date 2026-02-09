MODULE Ch2 EXPORTS Main;

IMPORT SIO,Text,CharSeq;

PROCEDURE StringReduction(READONLY Str:TEXT):TEXT =
  VAR
    Stk := NEW(CharSeq.T).init(Text.Length(Str));
    Res:TEXT := "";
  BEGIN
    FOR I := 0 TO Text.Length(Str)-1 DO
      IF Stk.size() > 0 AND Stk.gethi() = Text.GetChar(Str,I) THEN
        EVAL Stk.remhi()
      ELSE
        Stk.addhi(Text.GetChar(Str,I))
      END
    END;
    FOR I := 0 TO Stk.size()-1 DO
      Res := Res & Text.FromChar(Stk.get(I))
    END;
    RETURN Res
  END StringReduction;

BEGIN
  SIO.PutText(StringReduction("aabbccdd")); SIO.Nl();
  SIO.PutText(StringReduction("abccba")); SIO.Nl();
  SIO.PutText(StringReduction("abcdef")); SIO.Nl();
  SIO.PutText(StringReduction("aabbaeaccdd")); SIO.Nl();
  SIO.PutText(StringReduction("mississippi")); SIO.Nl()
END Ch2.

